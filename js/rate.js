var userId;
getUser(function(uid) {
    console.log(uid);

    userId = uid;
});
// TODO: authenticate the user


var course_id = getURLParameter('course_id');
console.log(course_id);


function rate() {
    if (userId.substring(0, 4) === 'test') {
        alert('Please log in.');
        return;
    }

    var courseComment = $('#course-comment')[0].value;
    var courseRate = $('#course-rate-input')[0].value;
    var professorComment = $('#professor-comment')[0].value;
    var professorRate = $('#professor-rate-input')[0].value;
    var taComment = $('#ta-comment')[0].value;
    var taRate = $('#ta-rate-input')[0].value;
    if (courseComment === '') {
        alert('Please input the course comment.');
        return;
    }
    if (professorComment === '') {
        alert('Please input the professor comment.');
        return;
    }
    if (taComment === '') {
        alert('Please input the TA comment.');
        return;
    }

    if (courseRate === '0' || professorRate === '0' || taRate === '0') {
        if (!confirm('Submit? All ratings should be between 1 and 10.')) {
            return;
        }
    }

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            var response = JSON.parse(this.responseText);
            console.log(response);

            if (response.success) {
                alert("Feedback submitted.");
                window.open("course.html", "_self");
            } else {
                alert("Error.");
            }
        }
    };

    xmlhttp.open('POST', 'rate.php', true);
    xmlhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlhttp.send(
            'course_id='+course_id+
            '&student_id='+userId+
            '&courseComment='+courseComment+
            '&courseRate='+courseRate+
            '&professorComment='+professorComment+
            '&professorRate='+professorRate+
            '&taComment='+taComment+
            '&taRate='+taRate);
}


function rateChange(rateID) {
    $('#'+rateID+'-label').text($('#'+rateID+'-input')[0].value);
}
