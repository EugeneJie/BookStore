<%@ page language="java" contentType="text/html" pageEncoding="GBK"%>
<%@ page import="javaee.Admin"%>

<html>
<head>
<title>管理员界面-网上书店系统</title>
</head>
<body>
<%
	Admin admin = (Admin)session.getAttribute("admin");
	if(admin==null){
%>
		<jsp:forward page="error.jsp">
			<jsp:param name="type" value="0"/>
			<jsp:param name="flag" value="4"/>
		</jsp:forward>
<%
	}
	String name = admin.getUsername();
%>
<h4>您好，管理员：<%=name%> [<a href="logout.jsp?flag=admin">退出登录</a>]</h4> <br><br>
<h2><a href="AddBook.html">增加图书</a></h2> <br>
<h2><a href="QueryUser.html">查询已注册会员</a></h2>
</body>
</html>