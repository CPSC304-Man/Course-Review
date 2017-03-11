<?php
function getData($statement) {
    oci_fetch_all($statement, $data, null, null, OCI_FETCHSTATEMENT_BY_ROW);

    return $data;
}
?>
