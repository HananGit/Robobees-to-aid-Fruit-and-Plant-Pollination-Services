<?php
session_start();
$username = "root";
$password = "root";
      $host = "localhost";
	  $dbname ="projectfinal";
		$user_name = $_POST['user_name'];
$password1 = $_POST['password'];
$email = $_POST['email'];
$user='user';
     // Create connection
$conn = mysqli_connect($host,$username,$password,$dbname);
// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

$sql = "INSERT INTO user (username,password,admin,email)VALUES('$user_name','$password1','$user','$email')";

if ($conn->query($sql) === TRUE) {
   header("location: register-success.html");
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>