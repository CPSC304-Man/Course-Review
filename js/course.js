var user = getUser(function(userId) {
    console.log(userId);
});
// TODO: authenticate the user


var coursesData;

// get courses data
(function getCourse() {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            console.log(JSON.parse(this.responseText));

            coursesData = JSON.parse(this.responseText).data;

            // display the data
            for (var i in coursesData) {
                var tds = '<td class="mdl-data-table__cell--non-numeric">' + coursesData[i].COURSE_ID + '</td>' +
                        '<td class="mdl-data-table__cell--non-numeric">' + coursesData[i].DEPT + '</td>' +
                        '<td class="mdl-data-table__cell--non-numeric">' + coursesData[i].CODE + '</td>' +
                        '<td class="mdl-data-table__cell--non-numeric">' + coursesData[i].SEMESTER + '</td>' +
                        '<td class="mdl-data-table__cell--non-numeric">' + coursesData[i].PROFESSOR_ID + '</td>' +
                        '<td class="mdl-data-table__cell--non-numeric">' + coursesData[i].TA_ID + '</td>' +
                        '<td class="mdl-data-table__cell--non-numeric">' + coursesData[i].AVERAGE + '</td>';

                if (coursesData[i].RATE_DEADLINE === null || coursesData[i].REVIEW_DEADLINE === null) {
                    $('#courseTable>tbody').append(
                            '<tr>' + tds +
                            '<td class="mdl-data-table__cell--non-numeric"><a href="addReviewCourse.html?course_id='+coursesData[i].COURSE_ID+'" target="_self"><button class="mdl-button mdl-js-button mdl-button--raised mdl-button--accent">Add</button></td>' +
                            '</tr>');
                } else {
                    $('#courseTable>tbody').append(
                            '<tr>' + tds +
                            '<td></td>' +
                            '</tr>');
                }
            }
        }
    };

    xmlhttp.open('GET', 'getCourse.php', true);
    xmlhttp.send();
})();
