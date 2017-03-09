<?php
$TEST_DB_CONNECTION_SUCCESS_JSON = "{\"connect\":true}";
$TEST_DB_CONNECTION_FAIL_JSON = "{\"connect\":false,\"connection\":{message:\"Failed to connect to the database\"}}";

function connectDB() {
  $dbConnection = array();

  $connection_string = "(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=dbhost.ugrad.cs.ubc.ca)(PORT=1522))(CONNECT_DATA=(SID=ug)))";

  if ($c=OCILogon("ora_b8f1b", "a28144970", $connection_string)) {
    $dbConnection["connect"] = true;
    $dbConnection["connection"] = $c;
  } else {
    $dbConnection["connect"] = false;
    $dbConnection["connection"] = OCIError();
  }

  return $dbConnection;
}


/*
if ($_GET["test"] === "test") {
  $dbConnection = connectDB();
  if ($dbConnection["connect"]) {
    echo $TEST_DB_CONNECTION_SUCCESS_JSON;
  } else {
    echo json_encode($dbConnection);
  }
  OCILogoff($dbConnection.connection);
} elseif ($_GET["test"] === "true") {
  echo $TEST_DB_CONNECTION_SUCCESS_JSON;
} elseif ($_GET["test"] === "false") {
  echo $TEST_DB_CONNECTION_FAIL_JSON;
}
*/
?>
