<%@ page language="java" contentType="text/html" pageEncoding="GBK"%>

<% request.setCharacterEncoding("GBK"); %>

<html>
<head>
<title>�����ɹ�</title>
</head>
<body>

<%
	String flag = request.getParameter("flag");
	String type;

	if(flag.equals("true")){
		type = "����Ա";
	}
	else if(flag.equals("false")){
		type = "��Ա";
	}
	else{
		type = "��Աע��";
	}
%>

<%
	if(type.equals("��Ա")){
		response.setHeader("refresh","5;URL=user.jsp");
%>		
		<h1>��¼�ɹ�����ӭ���� <%=request.getParameter("name")+" "+type%></h1> <br>
		<h2>5�����ת����Ա�û����棬���<a href="user.jsp">����</a>������ת</h2>
<%
	}
	else if(type.equals("����Ա")){
		response.setHeader("refresh","5;URL=admin.jsp");
%>
		<h1>��¼�ɹ�����ӭ���� <%=request.getParameter("name")+" "+type%></h1> <br>
		<h2>5�����ת������Ա�û����棬���<a href="admin.jsp">����</a>������ת</h2>
<%
	}
	else{
		response.setHeader("refresh","5;URL=login.html");
%>
		<h1>��Աע��ɹ����û����� <%=request.getParameter("name")%></h1> <br>
		<h2>5�����ת����¼���棬���<a href="login.html">����</a>������ת</h2>
<%
	}
%>

</body>
</html>