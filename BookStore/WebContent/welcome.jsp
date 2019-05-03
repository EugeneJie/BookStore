<%@ page language="java" contentType="text/html" pageEncoding="GBK"%>

<% request.setCharacterEncoding("GBK"); %>

<html>
<head>
<title>操作成功</title>
</head>
<body>

<%
	String flag = request.getParameter("flag");
	String type;

	if(flag.equals("true")){
		type = "管理员";
	}
	else if(flag.equals("false")){
		type = "会员";
	}
	else{
		type = "会员注册";
	}
%>

<%
	if(type.equals("会员")){
		response.setHeader("refresh","5;URL=user.jsp");
%>		
		<h1>登录成功！欢迎您： <%=request.getParameter("name")+" "+type%></h1> <br>
		<h2>5秒后跳转到会员用户界面，点击<a href="user.jsp">这里</a>立即跳转</h2>
<%
	}
	else if(type.equals("管理员")){
		response.setHeader("refresh","5;URL=admin.jsp");
%>
		<h1>登录成功！欢迎您： <%=request.getParameter("name")+" "+type%></h1> <br>
		<h2>5秒后跳转到管理员用户界面，点击<a href="admin.jsp">这里</a>立即跳转</h2>
<%
	}
	else{
		response.setHeader("refresh","5;URL=login.html");
%>
		<h1>会员注册成功！用户名： <%=request.getParameter("name")%></h1> <br>
		<h2>5秒后跳转到登录界面，点击<a href="login.html">这里</a>立即跳转</h2>
<%
	}
%>

</body>
</html>