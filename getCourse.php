<?php
require "connectDB.php";
require "parseSQL.php";
require "getData.php";

$SQL_FAIL_JSON = "{\"success\":false}";

// connect to the database
$dbConnection = connectDB();
$connection = null;
$sql = "";
$variables = array();

if ($dbConnection["connect"]) {
    // get the connection
    $connection = $dbConnection["connection"];

    $sql = "SELECT * FROM Course";
    if ($_POST["course_id"] != null) {
        $sql .= " WHERE course_id = :course_id";
        $variables[":course_id"] = $_POST["course_id"];
    }

    $statement = parseSQL($connection, $sql, $variables);
    $result = oci_execute($statement);
    if ($result) {
        $data = getData($statement);
        echo json_encode(array(success => true, data => $data));
    } else {
        echo $SQL_FAIL_JSON;
    }

    // close the connection
    OCILogoff($connection);
} else {
    echo $SQL_FAIL_JSON;
}
?>
