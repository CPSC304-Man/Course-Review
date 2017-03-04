function connectDB() {
  var xmlhttp = new XMLHttpRequest();
  xmlhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      var dbConnection = JSON.parse(this.responseText);
      if (dbConnection.connect) {
        alert("Connected to the database.");
        console.log(dbConnection);
      } else {
        alert("Failed to connect to the database.");
        console.log(dbConnection);
      }
    }
  };
  xmlhttp.open("GET", "connectDB.php?test=test", true);
  xmlhttp.send();
}