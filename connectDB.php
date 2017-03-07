<?php
$testSuccessDBConnection = array(connect=>true);
$testFailDBConnection = array(connect=>false, connection=>array(message=>"Failed to connect to the database"));

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

if ($_GET["test"] === "test") {
  $dbConnection = connectDB();
  if ($dbConnection["connect"]) {
    echo json_encode($testSuccessDBConnection);
  } else {
    echo json_encode($dbConnection);
  }
  OCILogoff($dbConnection.connection);
} elseif ($_GET["test"] === "true") {
  echo json_encode($testSuccessDBConnection);
} elseif ($_GET["test"] === "false") {
  echo json_encode($testFailDBConnection);
}
?>