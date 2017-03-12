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

    $sql = "SELECT c.*, rc.rate_deadline, rc.review_deadline FROM Course c LEFT JOIN ReviewCourse rc ON c.course_id = rc.course_id";
    if ($_GET["course_id"] != null) {
        $sql .= " WHERE course_id = :course_id";
        $variables[":course_id"] = $_GET["course_id"];
    }

    $statement = parseSQL($connection, $sql, $variables);
    $result = oci_execute($statement);
    // echo json_encode(oci_error($statement));
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
