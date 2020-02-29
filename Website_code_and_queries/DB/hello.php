<?php

session_start();

$servername = "localhost";
$username = "root";
$password = "root";
$dbname = "dbproject";
$user_name = $_POST['user_name'];
$password = $_POST['password'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$crop = $_POST['crop'];
$address = $_POST['address'];
$city = $_POST['city'];
$zip = $_POST['zip'];
$area = $_POST['area'];
$userid=$_SESSION["login_user"];

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

$sql = "INSERT INTO user (username,password,admin) VALUES ($user_name,'yash','user');";

if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>