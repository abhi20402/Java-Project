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
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1 style="text-align:center;">Farmer Equipment Leverage</h1>
<h3 style="text-align:justify;">Sign-IN</h3>
<form method="post">
Phone Number<input type="text" name="un" required><br>
Password<input type="password" name="p" required><br>
<input type="submit" value="sign-in"><br>
</form>
<%
String un=request.getParameter("un");
String pa=request.getParameter("p");
try
{
	Class.forName("com.mysql.cj.jdbc.Driver");
	//Establish Connection to Database Server
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "abhi@20402");
	Statement stmt=conn.createStatement();
	stmt = conn.createStatement();
	ResultSet rs;
	rs=stmt.executeQuery("select contact,f_pass from farmer_det");
	String con="",pass="";
	int flag=0;
	if(un!=null&&pass!=null)
	{
		while(rs.next())
		{
			con=rs.getString("contact");
			pass=rs.getString("f_pass");
			if(un.equals(con)&& pa.equals(pass))
			{
				out.print("Login Success!");
				response.sendRedirect("HomeP.jsp");
				flag=1;
				break;
			}
		}
	}
	if(un!=null && flag==0)
	{
		out.println("Incorrect Credentials."+"<a href='signin.jsp'>Retry</a>");
	}
	conn.close();
}
catch(SQLException e){
	out.print(e);
}
catch(Exception e)
{
	out.print(e);
}
%>
</body>
</html>