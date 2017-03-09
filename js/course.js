var user = getUser(function(userId) {
    console.log(userId);
});
// TODO: authenticate the user


(function getCourse() {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            console.log(JSON.parse(this.responseText));

            var data = JSON.parse(this.responseText).data;

            // display the data
            for (var i in data) {
                $("#courseTable>tbody").append(
                    "<tr>"
                    + "<td class=\"mdl-data-table__cell--non-numeric\">" + data[i].COURSE_ID + "</td>"
                    + "<td class=\"mdl-data-table__cell--non-numeric\">" + data[i].DEPARTMENT + "</td>"
                    + "<td class=\"mdl-data-table__cell--non-numeric\">" + data[i].CODE + "</td>"
                    + "<td class=\"mdl-data-table__cell--non-numeric\">" + data[i].SEMESTER + "</td>"
                    + "<td class=\"mdl-data-table__cell--non-numeric\">" + data[i].PROFESSOR_ID + "</td>"
                    + "<td class=\"mdl-data-table__cell--non-numeric\">" + data[i].TA_ID + "</td>"
                    + "<td class=\"mdl-data-table__cell--non-numeric\">" + data[i].AVERAGE + "</td>"
                    + "</tr>"
                );
            }
        }
    };

    xmlhttp.open("GET", "getCourse.php", true);
    xmlhttp.send();
})();
