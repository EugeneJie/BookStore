<%@ page language="java" contentType="text/html" pageEncoding="GBK"%>
<%@ page import="java.sql.*,javaee.User"%>

<html>
<head>
<title>��Ա����-�������ϵͳ</title>
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
<h4>���ã���Ա��<%=name%> [<a href="logout.jsp?flag=user">�˳���¼</a>]</h4> <br><br>
<h2><a href="QueryBook.html">��ѯ/����ͼ��</a></h2> <br>
<h2><a href="ShoppingCart.jsp">������㣨���ﳵ��</a></h2>
</body>
</html>