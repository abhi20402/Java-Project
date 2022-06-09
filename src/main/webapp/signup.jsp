<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.Driver.*" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.SQLException" %>
<%@ page import ="javax.sql.*" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import ="java.util.*" %>
<%@ page import ="java.lang.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Registration Form</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<div class="head">
		<h2 style="font-size:large;">Farmer Equipment Leverage</h2>
	</div>
	<div class="log">
		<p style="text-align:left;">Please Fill all the Fields</p>
		<form method="post">
			<h3>Registration Form<br></h3>
			<div class="content">
				<div class="form-field">
					<label for="FirstName">First Name:</label>
					<input type="text" id="FirstName" name="fn" placeholder="Enter First Name"><br>
					<label for="LastName">Last Name:</label>
					<input type="text" id="LastName" name="ln" placeholder="Enter Last Name" required><br>
					<label for="Age">Age:</label>
					<input type="text" id="Age" name="a" placeholder="Enter Valid Age" required><br>
					<label for="Contact">Mobile Number:</label>
					<input type="text" id="Contact" name="co" placeholder="Enter valid Mobile Number" required><br>
					<label for="Password">Password:</label>
					<input type="password" id="Password" name="pass" placeholder="Enter Password" required><br>
					<h4>Address Details:</h4>
					House No<input type="text" name="hno" placeholder="Enter House No" required><br>
					Street<input type="text" name="s" placeholder="Enter Street Name"><br>
					Locality<input type="text" name="l" placeholder="Enter Area" required><br>
					City<input type="text" name="c" placeholder="Enter City Name" required><br>
					District<input type="text" name="d" placeholder="Enter District Name" required><br>
					State<input type="text" name="st" placeholder="Enter State" required><br>
					Pincode<input type="text" name="pin" placeholder="Enter valid Pincode" required><br>
				</div>
				<button type="submit" onclick="validate()">REGISTER</button>
				<p>Already have an account? <a href="signin.jsp">Sign-In</a></p>
			</div>
		</form>
	</div>
	<%
try
{
	int a=0,pin=0;
	String fn=request.getParameter("fn");
	String ln=request.getParameter("ln");
	if(ln!=null){
		a=Integer.parseInt(request.getParameter("a"));
	}
	String co=request.getParameter("co");
	String pass=request.getParameter("pass");
	String hn=request.getParameter("hno");
	String s=request.getParameter("s");
	String l=request.getParameter("l");
	String c=request.getParameter("c");
	String d=request.getParameter("d");
	String st=request.getParameter("st");
	if(hn!=null){
	pin=Integer.parseInt(request.getParameter("pin"));
	}
	Class.forName("com.mysql.cj.jdbc.Driver");
	//Establish Connection to Database Server
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "abhi@20402");
	Statement stmt=conn.createStatement();
	ResultSet rs;
	rs=stmt.executeQuery("select f_hno from farmer_add");
	String fh="";
	int flag=0,ch=0;
	if(hn!=null)
	{
		while(rs.next())
		{
			fh=rs.getString("f_hno");
			if(hn.equals(fh))
			{
				flag=1;
			}
		}
	}
	if(flag==0&&pin!=0)
	{
		stmt.executeUpdate("insert into farmer_add(f_hno,pincode,street,locality,city,district,state) values('"+hn+"',"+pin+",'"+s+"','"+l+"','"+c+"','"+d+"','"+st+"');");
	}
	if(hn!=null)
	{
		stmt.executeUpdate("insert into farmer_det(f_fname,f_lname,age,contact,f_pass,f_hno) values('"+fn+"','"+ln+"',"+a+",'"+co+"','"+pass+"','"+hn+"');");
		ch=1;
	}
	request.setAttribute("message","Registration Successfull");
	if(ch==1){
	response.sendRedirect("signin.jsp");
	}
}
catch(SQLException e)
{
	out.print(e);
}
catch(Exception e)
{
	out.print(e);
}
%>
</body>
</html>