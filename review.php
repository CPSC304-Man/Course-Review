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

    $sql = "";
    $variables[":course_id"] = $_POST["course_id"];

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
