<%@ page language="java" contentType="text/html" pageEncoding="GBK"%>

<html>
<head>
<title>����ʧ��</title>
</head>
<body>

<%
	String type,flag,msg,url;
	if(request.getParameter("type").equals("0")){
		type = "��¼";
		url = "login.html";
	}
	else{
		type = "��Աע��";
		url = "register.html";
	}

	response.setHeader("refresh","5;URL="+url);
	
	flag = request.getParameter("flag");
	if(flag.equals("0")){
		msg = "�û��������벻��Ϊ�գ�";
	}
	else if(flag.equals("1")){
		msg = "�û������������";
	}
	else if(flag.equals("2")){
		msg = "���û����ѱ�ע�ᣬ�����ԣ�";
	}
	else if(flag.equals("3")){
		msg = "����ӦΪ������������ȷ���룡";
	}
	else if(flag.equals("4")){
		msg = "���ʱ�ҳ����Ҫ��¼����Ա�˺ţ�";
	}
	else{
		msg = "���ʱ�ҳ����Ҫ��¼��Ա�˺ţ�";
	}
%>

<h1> <%=type%>ʧ�ܣ� <%=msg%></h1> <br>
<h2>5���ص�<%=type%>���棬���<a href=" <%=url%>">����</a>������ת</h2>
</body>
</html>