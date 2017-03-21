var userId;
getUser(function(uid) {
    console.log(uid);

    userId = uid;
});
// TODO: authenticate the user


var course_id = getURLParameter('course_id');
console.log(course_id);


function getFeedback() {
    var courseCommentFilter = $('#course-comment-filter')[0].value;
    var courseRateFilterMin = $('#course-rate-filter-min')[0].value;
    var courseRateFilterMax = $('#course-rate-filter-max')[0].value;
    var professorCommentFilter = $('#professor-comment-filter')[0].value;
    var professorRateFilterMin = $('#professor-rate-filter-min')[0].value;
    var professorRateFilterMax = $('#professor-rate-filter-max')[0].value;
    var taCommentFilter = $('#ta-comment-filter')[0].value;
    var taRateFilterMin = $('#ta-rate-filter-min')[0].value;
    var taRateFilterMax = $('#ta-rate-filter-max')[0].value;

    var courseCommentCheck = $('#course-comment-check')[0].checked;
    var courseRateCheck = $('#course-rate-check')[0].checked;
    var professorCommentCheck = $('#professor-comment-check')[0].checked;
    var professorRateCheck = $('#professor-rate-check')[0].checked;
    var taCommentCheck = $('#ta-comment-check')[0].checked;
    var taRateCheck = $('#ta-rate-check')[0].checked;

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            var response = JSON.parse(this.responseText);
            console.log(response);

            $('#feedback>table').remove();
            $('#feedback').append(response.dataHtml);
        }
    };

    xmlhttp.open(
            'GET',
            'getFeedback.php?course_id='+course_id+
            '&courseCommentFilter='+courseCommentFilter+
            '&courseRateFilterMin='+courseRateFilterMin+
            '&courseRateFilterMax='+courseRateFilterMax+
            '&professorCommentFilter='+professorCommentFilter+
            '&professorRateFilterMin='+professorRateFilterMin+
            '&professorRateFilterMax='+professorRateFilterMax+
            '&taCommentFilter='+taCommentFilter+
            '&taRateFilterMin='+taRateFilterMin+
            '&taRateFilterMax='+taRateFilterMax+
            '&courseCommentCheck='+courseCommentCheck+
            '&courseRateCheck='+courseRateCheck+
            '&professorCommentCheck='+professorCommentCheck+
            '&professorRateCheck='+professorRateCheck+
            '&taCommentCheck='+taCommentCheck+
            '&taRateCheck='+taRateCheck,
            true);
    xmlhttp.send();
};


function review() {
    var reviewComment = $('#review-comment')[0].value;

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            var response = JSON.parse(this.responseText);
            console.log(response);

            if (response.success) {
                alert("Review submitted.");
                window.open("course.html", "_self");
            } else {
                alert("Error.");
            }
        }
    };

    xmlhttp.open('POST', 'review.php', true);
    xmlhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlhttp.send(
            'course_id='+course_id+
            '&professor_id='+userId+
            '&reviewComment='+reviewComment);
}
