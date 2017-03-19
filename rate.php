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

    $sql = "INSERT INTO RateCourse (rate_course_ID, " .
            "course_id, student_id, " .
            "courseComment, courseRate, " .
            "professorComment, professorRate, " .
            "taComment, taRate) " .
            "VALUES (SYS_GUID(), " .
            ":course_id, :student_id, " .
            ":courseComment, :courseRate, " .
            ":professorComment, :professorRate, " .
            ":taComment, :taRate" .
            ")";
    $variables[":course_id"] = $_POST["course_id"];
    $variables[":student_id"] = $_POST["student_id"];
    $variables[":courseComment"] = $_POST["courseComment"];
    $variables[":courseRate"] = $_POST["courseRate"];
    $variables[":professorComment"] = $_POST["professorComment"];
    $variables[":professorRate"] = $_POST["professorRate"];
    $variables[":taComment"] = $_POST["taComment"];
    $variables[":taRate"] = $_POST["taRate"];
    // echo $sql;
    // echo json_encode($variables);

    $statement = parseSQL($connection, $sql, $variables);
    $result = oci_execute($statement);
    if ($result) {
        echo $SQL_SUCCESS_JSON;
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
