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
                        '<td class="mdl-data-table__cell--non-numeric">' + coursesData[i].AVERAGE + '</td>' +
                        '<td class="mdl-data-table__cell--non-numeric"><a href="rate.html?course_id='+coursesData[i].COURSE_ID+'" target="_self"><button class="mdl-button mdl-js-button mdl-button--raised mdl-button--accent">Rate</button></td>' +
                        '<td class="mdl-data-table__cell--non-numeric"><a href="review.html?course_id='+coursesData[i].COURSE_ID+'" target="_self"><button class="mdl-button mdl-js-button mdl-button--raised mdl-button--accent">Review</button></td>';

                if (coursesData[i].RATE_DEADLINE === null || coursesData[i].REVIEW_DEADLINE === null) {
                    $('#courseTable>tbody').append(
                            '<tr>' + tds +
                            '<td class="mdl-data-table__cell--non-numeric"><a href="addReviewCourse.html?course_id='+coursesData[i].COURSE_ID+'" target="_self"><button class="mdl-button mdl-js-button mdl-button--raised mdl-button--accent">Add</button></a></td>' +
                            '</tr>');
                } else {
                    $('#courseTable>tbody').append(
                            '<tr>' + tds +
                            '<td class="mdl-data-table__cell--non-numeric"><button onclick="deleteReviewCourse(\''+coursesData[i].COURSE_ID+'\')" class="mdl-button mdl-js-button mdl-button--raised mdl-button--accent">Remove</button></td>' +
                            '</tr>');
                }
            }
        }
    };

    xmlhttp.open('GET', 'getCourse.php', true);
    xmlhttp.send();
})();


function deleteReviewCourse(courseId) {
    if (confirm('Delete? All rate, review, and recommendation records will also be deleted.')) {
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                var response = JSON.parse(this.responseText);
                console.log(response);

                if (response.success) {
                    alert('Removed the course from review.');
                    window.open("course.html", "_self");
                } else {
                    alert('Error.');
                }
            }
        };

        xmlhttp.open('GET', 'deleteReviewCourse.php?course_id='+courseId, true);
        xmlhttp.send();
    }
}

function filterCourse() {
    var dept = $('#department-code-filter')[0].value;
    var number = $('#course-number-filter')[0].value;
    var year = $('#year-filter')[0].value;

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            console.log(JSON.parse(this.responseText));

            coursesData = JSON.parse(this.responseText).data;

            displayCourseData(courseData);
        }
    };

    xmlhttp.open('GET', 'getCourse.php?dept='+dept+
                 '&number='+number+
                 '&year='+year,
                 true);
    xmlhttp.send();
}
