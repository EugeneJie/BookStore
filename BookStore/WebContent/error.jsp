<%@ page language="java" contentType="text/html" pageEncoding="GBK"%>

<html>
<head>
<title>操作失败</title>
</head>
<body>

<%
	String type,flag,msg,url;
	if(request.getParameter("type").equals("0")){
		type = "登录";
		url = "login.html";
	}
	else{
		type = "会员注册";
		url = "register.html";
	}

	response.setHeader("refresh","5;URL="+url);
	
	flag = request.getParameter("flag");
	if(flag.equals("0")){
		msg = "用户名和密码不能为空！";
	}
	else if(flag.equals("1")){
		msg = "用户名或密码错误！";
	}
	else if(flag.equals("2")){
		msg = "该用户名已被注册，请重试！";
	}
	else if(flag.equals("3")){
		msg = "年龄应为正整数，请正确输入！";
	}
	else if(flag.equals("4")){
		msg = "访问本页面需要登录管理员账号！";
	}
	else{
		msg = "访问本页面需要登录会员账号！";
	}
%>

<h1> <%=type%>失败： <%=msg%></h1> <br>
<h2>5秒后回到<%=type%>界面，点击<a href=" <%=url%>">这里</a>立即跳转</h2>
</body>
</html>