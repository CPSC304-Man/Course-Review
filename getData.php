<?php
function getData($statement) {
    $data = array();

    while (($row = oci_fetch_array($statement)) != false) {
        array_push($data, $row);
    }

    return $data;
}
?>
