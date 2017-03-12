<?php
function parseSQL($connection, $sql, $variables) {
    $statement = oci_parse($connection, $sql);

    foreach ($variables as $name => $variable) {
        oci_bind_by_name($statement, $name, $variables[$name]);
    }

    return $statement;
}
?>
