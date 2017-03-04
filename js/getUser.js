function getURLParameter(name) {
    return decodeURIComponent((new RegExp("[?|&]" + name + "=" + "([^&;]+?)(&|#|;|$)").exec(location.search) || [null, ""])[1].replace(/\+/g, "%20")) || null;
}

function getUser(callback) {
    var userId = "";

    var user = getURLParameter("user");

    if (user !== null && user !== "test") {
        userId = user;
    } else {
        var testUser = getURLParameter("testUser");

        if (testUser === null || testUser === "admin") {
            userId = "testAdmin";
        } else if (testUser === "student") {
            userId = "testStudent";
        } else if (testUser === "professor") {
            userId = "testProfessor";
        }
    }

    callback(userId);
}