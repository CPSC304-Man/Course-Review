<?php
require 'connectDB.php';
require 'parseSQL.php';
require 'getData.php';

$SQL_SUCCESS_JSON = '{"success":true}';
$SQL_FAIL_JSON = '{"success":false}';

// connect to the database
$dbConnection = connectDB();
$connection = null;
$sql = "";
$variables = array();

if ($dbConnection['connect']) {
    // get the connection
    $connection = $dbConnection['connection'];

    $parsedGroups = array();
    $groups = explode(',', $_GET['summaryGroup']);
    foreach ($groups as $group) {
        if ($group === 'course_id') {
            array_push($parsedGroups, 'c.course_id');
        } else if ($group === 'level') {
            array_push($parsedGroups, 'SUBSTR(c.code, 1, 1)');
        } else if ($group === 'dept') {
            array_push($parsedGroups, 'c.dept');
        } else if ($group === 'semester') {
            array_push($parsedGroups, 'c.semester');
        }
    }
    $sql = "SELECT " . implode($parsedGroups, ", ") . ", ";
    if (in_array($_GET['summaryData'], array('courseRate', 'professorRate', 'taRate'))) {
        $sql .=
                $_GET['summaryType'] . "(" . $_GET['summaryData'] . ") AS summary " .
                "FROM RateCourse rc " .
                "INNER JOIN Course c ON rc.course_id = c.course_id ";
    } else if (in_array($_GET['summaryData'], array('feedback'))) {
        $sql .=
                $_GET['summaryType'] . "(rc.feedback_number) AS summary " .
                "FROM Course c " .
                "INNER JOIN " .
                "(SELECT course_id, COUNT(*) AS feedback_number FROM RateCourse GROUP BY course_id) rc " .
                "ON c.course_id = rc.course_id ";
    }
    $sql .= "GROUP BY " . implode($parsedGroups, ", ");
    // echo $sql;
    // echo json_encode($variables);

    $statement = parseSQL($connection, $sql, $variables);
    $result = oci_execute($statement);
    if ($result) {
        $response = array(success => true);

        $data = getData($statement);

        $dataHtml = '<table id="summary-table" class="table table-responsive mdl-data-table mdl-js-data-table">';

        $dataHtml .= '<thead><tr>';
        foreach ($groups as $group) {
            if ($group === 'course_id') {
                $dataHtml .= '<th class="mdl-data-table__cell--non-numeric">Course</th>';
            } else if ($group === 'level') {
                $dataHtml .= '<th class="mdl-data-table__cell--non-numeric">Level</th>';
            } else if ($group === 'dept') {
                $dataHtml .= '<th class="mdl-data-table__cell--non-numeric">Department</th>';
            } else if ($group === 'semester') {
                $dataHtml .= '<th class="mdl-data-table__cell--non-numeric">Semester</th>';
            }
        }
        $dataHtml .= '<th class="mdl-data-table__cell--non-numeric">' . $_GET['summaryType'] . '</th>';
        $dataHtml .= '</tr></thead>';

        $dataHtml .= '<tbody>';
        foreach ($data as $row) {
            $dataHtml .= '<tr>';
            foreach ($groups as $group) {
                if ($group === 'course_id') {
                    $dataHtml .= '<td class="mdl-data-table__cell--non-numeric">' . $row['COURSE_ID'] . '</td>';
                } else if ($group === 'level') {
                    $dataHtml .= '<td class="mdl-data-table__cell--non-numeric">' . $row['SUBSTR(C.CODE,1,1)'] . '</td>';
                } else if ($group === 'dept') {
                    $dataHtml .= '<td class="mdl-data-table__cell--non-numeric">' . $row['DEPT'] . '</td>';
                } else if ($group === 'semester') {
                    $dataHtml .= '<td class="mdl-data-table__cell--non-numeric">' . $row['SEMESTER'] . '</td>';
                }
            }
            $dataHtml .= '<td class="mdl-data-table__cell--non-numeric">' . strval($row['SUMMARY']) . '</td>';
            $dataHtml .= '</tr>';
        }
        $dataHtml .= '</tbody>';

        $dataHtml .= '</table>';

        $response['dataHtml'] = $dataHtml;
        // echo $dataHtml;

        echo json_encode($response);
    } else {
        $error = array(success => false, error => oci_error($statement));
        echo json_encode($error);
    }

    // close the connection
    OCILogoff($connection);
} else {
    echo $SQL_FAIL_JSON;
}
?>
