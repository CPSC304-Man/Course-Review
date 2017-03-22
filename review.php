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

    if ($_POST['review_id'] == null) {
        $sql = "INSERT INTO Review (review_ID, " .
                "course_ID, professor_ID, " .
                "reviewComment) " .
                "VALUES (SYS_GUID(), " .
                ":course_id, :professor_id, " .
                ":reviewComment" .
                ")";
        $variables[':course_id'] = $_POST['course_id'];
        $variables[':professor_id'] = $_POST['professor_id'];
        $variables[':reviewComment'] = $_POST['reviewComment'];
    } else {
        $sql = 'UPDATE Review ' .
                'SET reviewComment = :reviewComment ' .
                'WHERE RAWTOHEX(review_id) = :review_id';
        $variables[':review_id'] = $_POST['review_id'];
        $variables[':reviewComment'] = $_POST['reviewComment'];
    }
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
