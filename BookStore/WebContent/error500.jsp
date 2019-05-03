<%@ page language="java"  contentType="text/html" pageEncoding="GBK" isErrorPage="true" %>

<html>
<head>
<title>500错误-网上书店系统</title>
</head>
<body>
<h1> 对不起，您访问的页面出现了不可预知的错误！</h1> <br>
<h2>5秒后回到登录界面，点击<a href="login.html">这里</a>立即跳转</h2>
<% response.setHeader("refresh","5;URL=login.html"); %>
</body>
</html>