var userID;
getUser(function(userID) {
    console.log(userID);

    userID = userID;
});
// TODO: authenticate the user


var course_id = getURLParameter('course_id');
console.log(course_id);


function rate() {
    var courseComment = $('#course-comment')[0].value;
    var courseRate = $('#course-rate-input')[0].value;
    var professorComment = $('#professor-comment')[0].value;
    var professorRate = $('#professor-rate-input')[0].value;
    var taComment = $('#ta-comment')[0].value;
    var taRate = $('#ta-rate-input')[0].value;

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            console.log(JSON.parse(this.responseText));

            // window.open("course.html", "_self");
        }
    };

    xmlhttp.open('POST', 'rate.php', true);
    xmlhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlhttp.send(
            'course_id='+course_id+
            '&student_id='+userID+
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
