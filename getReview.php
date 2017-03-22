<?php
require "connectDB.php";
require "parseSQL.php";
require "getData.php";

$SQL_SUCCESS_JSON = "{\"success\":true}";
$SQL_FAIL_JSON = "{\"success\":false}";

// connect to the database
$dbConnection = connectDB();
$connection = null;
$sql = "";
$variables = array();

if ($dbConnection["connect"]) {
    // get the connection
    $connection = $dbConnection["connection"];

    $sql = "SELECT RAWTOHEX(review_id) AS REVIEW_ID, reviewComment FROM Review WHERE course_id = :course_id AND professor_id = :professor_id";
    $variables[":course_id"] = $_GET["course_id"];
    $variables[":professor_id"] = $_GET["professor_id"];
    // echo $sql;
    // echo json_encode($variables);

    $statement = parseSQL($connection, $sql, $variables);
    $result = oci_execute($statement);
    if ($result) {
        $data = getData($statement);
        echo json_encode(array(success => true, data => $data));
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
