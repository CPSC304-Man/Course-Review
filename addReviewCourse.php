<?php
require "connectDB.php";
require "parseSQL.php";
require "getData.php";

$SQL_SUCCESS_JSON = "{\"success\":true}";
$SQL_FAIL_JSON = "{\"success\":false}";

// echo json_encode($_POST);
if ($_POST["course_id"] == null || $_POST["rate_deadline"] == null || $_POST["review_deadline"] == null) {
    echo $SQL_FAIL_JSON;
    exit();
}

// connect to the database
$dbConnection = connectDB();
$connection = null;
$sql = "";
$variables = array();

if ($dbConnection["connect"]) {
    // get the connection
    $connection = $dbConnection["connection"];

    // $sql = "INSERT INTO ReviewCourse VALUES ('CPSC304_2016W1', '12-Mar-17', '12-Mar-17')";
    $sql = "INSERT INTO ReviewCourse VALUES (:course_id, :rate_deadline, :review_deadline)";
    $variables[":course_id"] = $_POST["course_id"];
    $variables[":rate_deadline"] = $_POST["rate_deadline"];
    $variables[":review_deadline"] = $_POST["review_deadline"];

    $statement = parseSQL($connection, $sql, $variables);
    $result = oci_execute($statement);
    if ($result) {
        echo $SQL_SUCCESS_JSON;
    } else {
        echo $SQL_FAIL_JSON;
    }

    // close the connection
    OCILogoff($connection);
} else {
    echo $SQL_FAIL_JSON;
}
?>
