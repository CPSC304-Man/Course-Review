var user = getUser(function(userId) {
    console.log(userId);
});
// TODO: authenticate the user


$(function() {
    $('#rate-deadline').datepicker({dateFormat: 'dd-M-y'});
    $('#review-deadline').datepicker({dateFormat: 'dd-M-y'});
});


var course_id = getURLParameter('course_id');
console.log(course_id);

var course;

// get the course data
(function getCourse() {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            console.log(JSON.parse(this.responseText));

            course = JSON.parse(this.responseText).data[0];

            $('#course').html($('#course').html() + course.DEPT + course.CODE + ' (' + course.SEMESTER + ')');
            $('#professor').html($('#professor').html() + course.PROFESSOR_ID);
            $('#ta').html($('#ta').html() + course.TA_ID);
            $('#average').html($('#average').html() + course.AVERAGE);
        }
    };

    xmlhttp.open('GET', 'getCourse.php?course_id='+course_id, true);
    xmlhttp.send();
})();


function addReviewCourse() {
    var rateDeadline = $('#rate-deadline')[0].value;
    var reviewDeadline = $('#review-deadline')[0].value;
    console.log(rateDeadline, reviewDeadline);

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            console.log(JSON.parse(this.responseText));

            window.open("course.html", "_self");
        }
    };

    xmlhttp.open('POST', 'addReviewCourse.php', true);
    xmlhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlhttp.send('course_id='+course_id+'&rate_deadline='+rateDeadline+'&review_deadline='+reviewDeadline);
}
