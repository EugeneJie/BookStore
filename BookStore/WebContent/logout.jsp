<%@ page language="java" contentType="text/html" pageEncoding="GBK"%>
<%@ page import="javaee.*"%>

<%
	String flag = request.getParameter("flag");
	String type;
	if(flag.equals("admin")){
		type = "����Ա";
		Admin admin = (Admin)session.getAttribute("admin");
		if(admin!=null){
			session.removeAttribute("admin");
		}
	}
	else{
		type = "��Ա";
		User user = (User)session.getAttribute("user");
		if(user!=null){
			session.removeAttribute("user");
		}
	}
	
	response.setHeader("refresh","5;URL=login.html");
%>

<html>
<head>
<title>�˳���¼�ɹ�</title>
</head>
<body>
	<h1>���˳���ǰ<%=type%>�˺�!</h1> <br>
	<h2>5�����ת����¼���棬���<a href="login.html">����</a>������ת</h2>
</body>
</html>