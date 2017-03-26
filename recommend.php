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

    $sql = "INSERT INTO Recommend (recommend_ID, " .
            "course_ID, professor_ID, " .
            "recommendation, " .
            "admin_ID, complete) " .
            "VALUES (SYS_GUID(), " .
            ":course_id, :professor_id, " .
            ":recommendation, " .
            "'', NULL" .
            ")";
    $variables[':course_id'] = $_POST['course_id'];
    $variables[':professor_id'] = $_POST['professor_id'];
    $variables[':recommendation'] = $_POST['recommendation'];
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
