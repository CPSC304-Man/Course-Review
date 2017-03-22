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

    $sql = "SELECT " . $_GET['summaryType'] . "(" . $_GET['summaryData'] . ") AS summary FROM RateCourse WHERE course_id = :course_id";
    $variables[':course_id'] = $_GET['course_id'];
    // echo $sql;
    // echo json_encode($variables);

    $statement = parseSQL($connection, $sql, $variables);
    $result = oci_execute($statement);
    if ($result) {
        $data = getData($statement);
        echo json_encode(array(success => true, data => $data[0]['SUMMARY']));
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
