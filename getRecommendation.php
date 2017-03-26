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

    $sql =
            "SELECT RAWTOHEX(r.recommend_id) AS recommend_id, r.course_id, cd.name AS course_name, p.name AS professor_name, r.recommendation, r.admin_id, r.complete " .
            "FROM Recommend r " .
            "INNER JOIN Course c ON r.course_id = c.course_id " .
            "INNER JOIN CourseDetails cd ON c.dept = cd.dept AND c.code = cd.code " .
            "INNER JOIN Professor p ON r.professor_id = p.professor_id " .
            "WHERE r.admin_id = :admin_id";
    $variables[':admin_id'] = $_GET['admin_id'];
    // echo $sql;
    // echo json_encode($variables);

    $statement = parseSQL($connection, $sql, $variables);
    $result = oci_execute($statement);
    if ($result) {
        $response = array(success => true);

        $data = getData($statement);

        $dataHtml = '<table id="recommendation-table" class="table table-responsive mdl-data-table mdl-js-data-table">';

        $dataHtml .= '<thead><tr>';
        $dataHtml .= '<th class="mdl-data-table__cell--non-numeric">Course ID</th>';
        $dataHtml .= '<th class="mdl-data-table__cell--non-numeric">Course</th>';
        $dataHtml .= '<th class="mdl-data-table__cell--non-numeric">Professor</th>';
        $dataHtml .= '<th class="mdl-data-table__cell--non-numeric">Recommendation</th>';
        $dataHtml .= '<th class="mdl-data-table__cell--non-numeric">Admin ID</th>';
        $dataHtml .= '<th class="mdl-data-table__cell--non-numeric">Completion Date</th>';
        $dataHtml .= '<th class="mdl-data-table__cell--non-numeric">Set</th>';
        $dataHtml .= '</tr></thead>';

        $dataHtml .= '<tbody>';
        foreach ($data as $row) {
            $dataHtml .= '<tr>';
            $dataHtml .= '<td class="mdl-data-table__cell--non-numeric">' . $row['COURSE_ID'] . '</td>';
            $dataHtml .= '<td class="mdl-data-table__cell--non-numeric">' . $row['COURSE_NAME'] . '</td>';
            $dataHtml .= '<td class="mdl-data-table__cell--non-numeric">' . $row['PROFESSOR_NAME'] . '</td>';
            $dataHtml .= '<td class="mdl-data-table__cell--non-numeric">' . $row['RECOMMENDATION'] . '</td>';
            $dataHtml .= '<td class="mdl-data-table__cell--non-numeric">' . $row['ADMIN_ID'] . '</td>';
            if ($row['COMPLETE'] === null) {
                $dataHtml .= '<td class="mdl-data-table__cell--non-numeric"><input type="text" id="' . $row['RECOMMEND_ID'] . '-date"></p></td>';
                $dataHtml .= '<td class="mdl-data-table__cell--non-numeric"><button onclick="setRecommendationDate(\'' . $row['RECOMMEND_ID'] . '\')" class="mdl-button mdl-js-button mdl-button--raised mdl-button--accent">Set</button></td>';
            } else {
                $dataHtml .= '<td class="mdl-data-table__cell--non-numeric">' . $row['COMPLETE'] . '</td>';
                $dataHtml .= '<td class="mdl-data-table__cell--non-numeric"></td>';
            }
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
