var user = getUser(function(userId) {
    console.log(userId);
});
// TODO: authenticate the user


var course_id = getURLParameter('course_id');
console.log(course_id);


function review() {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            console.log(JSON.parse(this.responseText));

            window.open("course.html", "_self");
        }
    };

    xmlhttp.open('POST', 'review.php', true);
    xmlhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlhttp.send('course_id='+course_id);
}
