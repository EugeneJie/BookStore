<%@ page language="java" contentType="text/html" pageEncoding="GBK"%>
<%@ page import="javaee.*"%>

<%
	String flag = request.getParameter("flag");
	String type;
	if(flag.equals("admin")){
		type = "管理员";
		Admin admin = (Admin)session.getAttribute("admin");
		if(admin!=null){
			session.removeAttribute("admin");
		}
	}
	else{
		type = "会员";
		User user = (User)session.getAttribute("user");
		if(user!=null){
			session.removeAttribute("user");
		}
	}
	
	response.setHeader("refresh","5;URL=login.html");
%>

<html>
<head>
<title>退出登录成功</title>
</head>
<body>
	<h1>已退出当前<%=type%>账号!</h1> <br>
	<h2>5秒后跳转到登录界面，点击<a href="login.html">这里</a>立即跳转</h2>
</body>
</html>