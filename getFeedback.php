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

    $sqlColumns = "";
    if ($_GET['courseCommentCheck'] === 'true') {
        $sqlColumns .= ", courseComment";
    }
    if ($_GET['courseRateCheck'] === 'true') {
        $sqlColumns .= ", courseRate";
    }
    if ($_GET['professorCommentCheck'] === 'true') {
        $sqlColumns .= ", professorComment";
    }
    if ($_GET['professorRateCheck'] === 'true') {
        $sqlColumns .= ", professorRate";
    }
    if ($_GET['taCommentCheck'] === 'true') {
        $sqlColumns .= ", taComment";
    }
    if ($_GET['taRateCheck'] === 'true') {
        $sqlColumns .= ", taRate";
    }
    $sql =
            "SELECT s.name" . $sqlColumns . " FROM RateCourse rc " .
            "INNER JOIN Student s ON rc.student_ID = s.student_ID " .
            "WHERE rc.course_ID = :course_id";
    $variables[':course_id'] = $_GET['course_id'];
    if ($_GET['courseCommentFilter'] != null) {
        $sql .= " AND rc.courseComment LIKE :courseCommentFilter";
        $variables[':courseCommentFilter'] = '%' . $_GET['courseCommentFilter'] . '%';
    }
    $sql .= " AND rc.courseRate BETWEEN :courseRateFilterMin AND :courseRateFilterMax";
    $variables[':courseRateFilterMin'] = intval($_GET['courseRateFilterMin']);
    $variables[':courseRateFilterMax'] = intval($_GET['courseRateFilterMax']);
    if ($_GET['professorCommentFilter'] != null) {
        $sql .= " AND rc.professorComment LIKE :professorCommentFilter";
        $variables[':professorCommentFilter'] = '%' . $_GET['professorCommentFilter'] . '%';
    }
    $sql .= " AND rc.courseRate BETWEEN :professorRateFilterMin AND :professorRateFilterMax";
    $variables[':professorRateFilterMin'] = intval($_GET['professorRateFilterMin']);
    $variables[':professorRateFilterMax'] = intval($_GET['professorRateFilterMax']);
    if ($_GET['taCommentFilter'] != null) {
        $sql .= " AND rc.taComment LIKE :taCommentFilter";
        $variables[':taCommentFilter'] = '%' . $_GET['taCommentFilter'] . '%';
    }
    $sql .= " AND rc.courseRate BETWEEN :taRateFilterMin AND :taRateFilterMax";
    $variables[':taRateFilterMin'] = intval($_GET['taRateFilterMin']);
    $variables[':taRateFilterMax'] = intval($_GET['taRateFilterMax']);
    // echo $sql;
    // echo json_encode($variables);

    $statement = parseSQL($connection, $sql, $variables);
    $result = oci_execute($statement);
    if ($result) {
        $response = array(success => true);

        $data = getData($statement);

        $dataHtml = '<table id="feedback-table" class="table table-responsive mdl-data-table mdl-js-data-table">';

        $dataHtml .= '<thead><tr>';
        if ($_GET['courseCommentCheck'] === 'true') {
            $dataHtml .= '<th class="mdl-data-table__cell--non-numeric">Course Comment</th>';
        }
        if ($_GET['courseRateCheck'] === 'true') {
            $dataHtml .= '<th class="mdl-data-table__cell--non-numeric">Course Rate</th>';
        }
        if ($_GET['professorCommentCheck'] === 'true') {
            $dataHtml .= '<th class="mdl-data-table__cell--non-numeric">Professor Comment</th>';
        }
        if ($_GET['professorRateCheck'] === 'true') {
            $dataHtml .= '<th class="mdl-data-table__cell--non-numeric">Professor Rate</th>';
        }
        if ($_GET['taCommentCheck'] === 'true') {
            $dataHtml .= '<th class="mdl-data-table__cell--non-numeric">TA Comment</th>';
        }
        if ($_GET['taRateCheck'] === 'true') {
            $dataHtml .= '<th class="mdl-data-table__cell--non-numeric">TA Rate</th>';
        }
        $dataHtml .= '<th class="mdl-data-table__cell--non-numeric">Student</th>';
        $dataHtml .= '</tr></thead>';

        $dataHtml .= '<tbody>';
        foreach ($data as $row) {
            $dataHtml .= '<tr>';
            if ($_GET['courseCommentCheck'] === 'true') {
                $dataHtml .= '<td class="mdl-data-table__cell--non-numeric">' . $row['COURSECOMMENT'] . '</td>';
            }
            if ($_GET['courseRateCheck'] === 'true') {
                $dataHtml .= '<td class="mdl-data-table__cell--non-numeric">' . $row['COURSERATE'] . '</td>';
            }
            if ($_GET['professorCommentCheck'] === 'true') {
                $dataHtml .= '<td class="mdl-data-table__cell--non-numeric">' . $row['PROFESSORCOMMENT'] . '</td>';
            }
            if ($_GET['professorRateCheck'] === 'true') {
                $dataHtml .= '<td class="mdl-data-table__cell--non-numeric">' . $row['PROFESSORRATE'] . '</td>';
            }
            if ($_GET['taCommentCheck'] === 'true') {
                $dataHtml .= '<td class="mdl-data-table__cell--non-numeric">' . $row['TACOMMENT'] . '</td>';
            }
            if ($_GET['taRateCheck'] === 'true') {
                $dataHtml .= '<td class="mdl-data-table__cell--non-numeric">' . $row['TARATE'] . '</td>';
            }
            $dataHtml .= '<td class="mdl-data-table__cell--non-numeric">' . $row['NAME'] . '</td>';
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
