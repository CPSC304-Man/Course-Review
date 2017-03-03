<html>
<?php

if ($c=OCILogon("ora_b8f1b", "a28144970", "ug")) {
  echo "Successfully connected to Oracle.\n";
  OCILogoff($c);
} else {
  $err = OCIError();
  echo "Oracle Connect Error " . $err['message'];
}

?>
</html>
