<%@ page language="java" contentType="text/html" pageEncoding="GBK"%>
<%@ page import="java.sql.*,javaee.User"%>

<html>
<head>
<title>会员界面-网上书店系统</title>
</head>
<body>
<%
	User user = (User)session.getAttribute("user");
	if(user==null){
%>
		<jsp:forward page="error.jsp">
			<jsp:param name="type" value="0"/>
			<jsp:param name="flag" value="5"/>
		</jsp:forward>
<%
	}
	String name = user.getUsername();
%>
<h4>您好，会员：<%=name%> [<a href="logout.jsp?flag=user">退出登录</a>]</h4> <br><br>
<h2><a href="QueryBook.html">查询/购买图书</a></h2> <br>
<h2><a href="ShoppingCart.jsp">购书结算（购物车）</a></h2>
</body>
</html>