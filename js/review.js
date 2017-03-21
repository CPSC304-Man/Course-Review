var userId;
getUser(function(uid) {
    console.log(uid);

    userId = uid;
});
// TODO: authenticate the user


var course_id = getURLParameter('course_id');
console.log(course_id);


function getFeedback() {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            var response = JSON.parse(this.responseText);
            console.log(response);

            $('#feedback').append(response.dataHtml);
        }
    };

    xmlhttp.open('GET', 'getFeedback.php?course_id='+course_id, true);
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
