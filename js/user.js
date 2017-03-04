var user = getUser(function(userId) {
    console.log(userId);
});

function editChange() {
    var checked = $("#edit")[0].checked;

    $("#bio").prop("disabled", !checked);
}

function save() {
    alert("saved");
}