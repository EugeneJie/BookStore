<%@ page language="java" contentType="text/html" pageEncoding="GBK"%>
<%@ page import="javaee.Admin"%>

<html>
<head>
<title>����Ա����-�������ϵͳ</title>
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
<h4>���ã�����Ա��<%=name%> [<a href="logout.jsp?flag=admin">�˳���¼</a>]</h4> <br><br>
<h2><a href="AddBook.html">����ͼ��</a></h2> <br>
<h2><a href="QueryUser.html">��ѯ��ע���Ա</a></h2>
</body>
</html>