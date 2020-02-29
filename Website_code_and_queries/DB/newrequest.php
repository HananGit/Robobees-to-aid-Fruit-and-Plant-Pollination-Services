<?php

session_start();

$myusername= $_SESSION["login_user"];
$servername = "localhost";
$username = "root";
$password = "root";
$dbname = "projectfinal";


$userid=$_SESSION["login_user"];

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

//$sql = "INSERT INTO Request (username,status) VALUES ('$myusername','pending approval')";

//$sql = "INSERT INTO ReqDet(email,phone,crop,address,city,farea,zipcode) VALUES ('$email','$phone','$crop','$address','$city','$area','$zip')";

$sql = "INSERT INTO Request (username,status) VALUES ('$myusername','pending approval')";


if ($conn->query($sql)  === TRUE) {
    echo "Request created successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>