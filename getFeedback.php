<?php
require 'connectDB.php';
require 'parseSQL.php';
require 'getData.php';

$SQL_SUCCESS_JSON = '{"success":true}';
$SQL_FAIL_JSON = '{"success":false}';

// connect to the database
$dbConnection = connectDB();
$connection = null;
$sql = '';
$variables = array();

if ($dbConnection['connect']) {
    // get the connection
    $connection = $dbConnection['connection'];

    $sql =
            "SELECT rc.*, s.name FROM RateCourse rc " .
            "INNER JOIN Student s ON rc.student_ID = s.student_ID " .
            "WHERE rc.course_ID = :course_id";
    $variables[':course_id'] = $_GET['course_id'];
    // echo $sql;
    // echo json_encode($variables);

    $statement = parseSQL($connection, $sql, $variables);
    $result = oci_execute($statement);
    if ($result) {
        $response = array(success => true);

        $data = getData($statement);

        $dataHtml = '<table id="feedback-table" class="table table-responsive mdl-data-table mdl-js-data-table">';

        $dataHtml .=
                '<thead>' .
                '<tr>' .
                '<th class="mdl-data-table__cell--non-numeric">Course Comment</th>' .
                '<th class="mdl-data-table__cell--non-numeric">Course Rate</th>' .
                '<th class="mdl-data-table__cell--non-numeric">Professor Comment</th>' .
                '<th class="mdl-data-table__cell--non-numeric">Professor Rate</th>' .
                '<th class="mdl-data-table__cell--non-numeric">TA Comment</th>' .
                '<th class="mdl-data-table__cell--non-numeric">TA Rate</th>' .
                '<th class="mdl-data-table__cell--non-numeric">Student</th>' .
                '</tr>' .
                '</thead>';

        $dataHtml .= '<tbody>';
        foreach ($data as $row) {
            $dataHtml .=
                    '<tr>' .
                    '<td class="mdl-data-table__cell--non-numeric">' . $row['COURSECOMMENT'] . '</td>' .
                    '<td class="mdl-data-table__cell--non-numeric">' . $row['COURSERATE'] . '</td>' .
                    '<td class="mdl-data-table__cell--non-numeric">' . $row['PROFESSORCOMMENT'] . '</td>' .
                    '<td class="mdl-data-table__cell--non-numeric">' . $row['PROFESSORRATE'] . '</td>' .
                    '<td class="mdl-data-table__cell--non-numeric">' . $row['TACOMMENT'] . '</td>' .
                    '<td class="mdl-data-table__cell--non-numeric">' . $row['TARATE'] . '</td>' .
                    '<td class="mdl-data-table__cell--non-numeric">' . $row['NAME'] . '</td>' .
                    '</tr>';
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
