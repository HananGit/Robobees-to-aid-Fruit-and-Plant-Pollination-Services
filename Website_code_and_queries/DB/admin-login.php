<?php

session_start();

$myusername= $_SESSION["login_user"];
$servername = "localhost";
$username = "root";
$password = "root";
$dbname = "dbproject";

$con=mysqli_connect($servername,$username,$password,$dbname);
// Check connection
if (mysqli_connect_errno())
{
echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$result = mysqli_query($con,"SELECT r.RequestId,r.username,r.status,rd.email,rd.phone,rd.crop,rd.address,rd.city,rd.farea,rd.zipcode FROM Request r FULL OUTER JOIN ReqDet rd where r.RequestId=rd.RequestId");

echo "<table border='1'>
<tr>
<th>Request ID</th>
<th>Username</th>
<th>Status</th>
<th>email</th>
<th>Phone</th>
<th>Crop</th>
<th>Address</th>
<th>City</th>
<th>Area of Field</th>
<th>Zip Code</th>
</tr>";

while($row = mysqli_fetch_array($result))
{
echo "<tr>";
echo "<td>" . $row['RequestId'] . "</td>";
echo "<td>" . $row['username'] . "</td>";
echo "<td>" . $row['status'] . "</td>";
echo "<td>" . $row['email'] . "</td>";
echo "<td>" . $row['phone'] . "</td>";
echo "<td>" . $row['crop'] . "</td>";
echo "<td>" . $row['address'] . "</td>";
echo "<td>" . $row['city'] . "</td>";
echo "<td>" . $row['farea'] . "</td>";
echo "<td>" . $row['zipcode'] . "</td>";
echo "</tr>";
}
echo "</table>";

mysqli_close($con);
?>