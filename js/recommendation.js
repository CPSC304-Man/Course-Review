var userId;
getUser(function(uid) {
    console.log(uid);

    userId = uid;
});
// TODO: authenticate the user


function getRecommendations() {
    if (userId.substring(0, 4) === 'test') {
        alert('Please log in.');
        return;
    }

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            var response = JSON.parse(this.responseText);
            console.log(response);

            $('#recommendations>table').remove();
            $('#recommendations').append(response.dataHtml);

            $('#recommendation-table>tbody>tr>td>input').datepicker({dateFormat: 'dd-M-y'});
        }
    };

    xmlhttp.open('GET', 'getRecommendation.php?admin_id='+userId, true);
    xmlhttp.send();
}


function setRecommendationDate(recommendId) {
    if (userId.substring(0, 4) === 'test') {
        alert('Please log in.');
        return;
    }

    var completionDate = $('#'+recommendId+'-date')[0].value;
    if (completionDate === '') {
        alert('Please set the completion date.');
        return;
    }

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            var response = JSON.parse(this.responseText);
            console.log(response);

            if (response.success) {
                alert("Completion date set.");
                getRecommendations();
            } else {
                alert("Error.");
            }
        }
    };

    xmlhttp.open(
            'POST',
            'setRecommendationDate.php?'+
            'recommend_id='+recommendId+
            '&completionDate='+completionDate,
            true);
    xmlhttp.send();
}
