var userId;
getUser(function(uid) {
    console.log(uid);

    userId = uid;
});
// TODO: authenticate the user


var course_id = getURLParameter('course_id');
console.log(course_id);


var reviewId = '';


function getFeedback() {
    if (userId.substring(0, 4) === 'test') {
        alert('Please log in.');
        return;
    }

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


function getFeedbackSummary() {
    if (userId.substring(0, 4) === 'test') {
        alert('Please log in.');
        return;
    }

    var summaryType = $('input[name="feedback-summary-type"]:checked')[0].value;
    var summaryData = $('input[name="feedback-summary-data"]:checked')[0].value;

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            var response = JSON.parse(this.responseText);
            console.log(response);

            var summaryText = '';
            summaryText += 'The ';
            if (summaryType === 'avg') {
                summaryText += 'average of ';
            } else if (summaryType === 'max') {
                summaryText += 'maximum of ';
            } else if (summaryType === 'min') {
                summaryText += 'minimum of ';
            }
            if (summaryData === 'courseRate') {
                summaryText += 'course rate is ';
            } else if (summaryData === 'professorRate') {
                summaryText += 'professor rate is ';
            } else if (summaryData === 'taRate') {
                summaryText += 'TA rate is ';
            }
            summaryText += response.data;
            summaryText += '.';
            $('#feedback-summary-result').text(summaryText);
        }
    };

    xmlhttp.open(
            'GET',
            'getFeedbackSummary.php?course_id='+course_id+
            '&summaryType='+summaryType+
            '&summaryData='+summaryData,
            true);
    xmlhttp.send();
};


function review() {
    if (userId.substring(0, 4) === 'test') {
        alert('Please log in.');
        return;
    }

    var reviewComment = $('#review-comment')[0].value;

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            var response = JSON.parse(this.responseText);
            console.log(response);

            if (response.success) {
                if (reviewId === '') {
                    alert("Review submitted.");
                } else {
                    alert("Review updated.");
                }
                window.open("course.html", "_self");
            } else {
                alert("Error.");
            }
        }
    };

    xmlhttp.open('POST', 'review.php', true);
    xmlhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    if (reviewId === '') {
        xmlhttp.send(
                'course_id='+course_id+
                '&professor_id='+userId+
                '&reviewComment='+reviewComment);
    } else {
        xmlhttp.send(
                'review_id='+reviewId+
                '&course_id='+course_id+
                '&professor_id='+userId+
                '&reviewComment='+reviewComment);
    }
}


(function() {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            var response = JSON.parse(this.responseText);
            console.log(response);

            if (response.success) {
                if (response.data.length > 0) {
                    alert("Review loaded.");

                    reviewId = response.data[0]['REVIEW_ID'];
                    console.log(reviewId);
                    $('#review-comment').val(response.data[0]['REVIEWCOMMENT']);

                    $('#submit-btn').text('Update Review');
                }

                $('#submit-btn').prop('disabled', false);
            } else {
                alert("Error.");
            }
        }
    };

    xmlhttp.open('GET', 'getReview.php?course_id='+course_id+'&professor_id='+userId, true);
    xmlhttp.send();
})();
