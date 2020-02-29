<?php
   
   session_start();
      $username = "root";
      $password = "root";
      $host = "localhost";
	  $dbname ="projectfinal";

     // Create connection
$conn = mysqli_connect($host, $username, $password, $dbname);
// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}



     


  
   
   if($_SERVER["REQUEST_METHOD"] == "POST") {
      // username and password sent from form 
      
      $myusername = mysqli_real_escape_string($conn,$_POST['user']);
      $mypassword = mysqli_real_escape_string($conn,$_POST['pass']); 
      
      $sql = "SELECT admin FROM User WHERE username = '$myusername' and password = '$mypassword'";
      $result = mysqli_query($conn,$sql);
      //$row = mysqli_fetch_array($result,MYSQLI_ASSOC);
	 $row = mysqli_fetch_array($result);
	$admin = $row['admin'];
      
      $count = mysqli_num_rows($result);
      
      // If result matched $myusername and $mypassword, table row must be 1 row
	  if($count ==1){
		
      if($admin == 'user') {
		  
		  
        
         $_SESSION["login_user"] = "$myusername";
		 header("location: user-login.html");
         
         
      }else if($admin == 'admin') {
		  
		   $_SESSION["login_user"] = "$myusername";
		  header("location: admin-login.php");
		 
         
      }
	  }
	  else{
		  header("location: invalidCredentials.html");
	  }
   }
?>