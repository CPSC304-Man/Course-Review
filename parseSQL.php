<?php
function parseSQL($connection, $sql) {
    return oci_parse($connection, $sql);
}
?>
