<%@ page language="java" contentType="text/html" pageEncoding="GBK"%>
<%@ page import="java.sql.*,javaee.Admin"%>

<% request.setCharacterEncoding("GBK"); %>

<%!
	public static final String DBDRIVER = "com.mysql.jdbc.Driver" ;
	public static final String DBURL = "jdbc:mysql://localhost:3306/bookstore?useSSL=false" ;
	public static final String DBUSER = "root" ;
	public static final String DBPASS = "root" ;
%>

<html>
<head>
<title>��ѯ��Ա-�������ϵͳ</title>
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
	
	Connection conn = null ;
	PreparedStatement pstmt = null ;
	ResultSet rs = null ;
	String sql = "";
	int count = 0;
	
	String keyword = request.getParameter("keyword");
	
	if(keyword.equals("")){
		sql = "SELECT id,username,age,sex,balance FROM user";
	}
	else{
		sql = "SELECT id,username,age,sex,balance FROM user WHERE username LIKE ?";
	}
%>

<%
	try{
		Class.forName(DBDRIVER) ;
		conn = DriverManager.getConnection(DBURL,DBUSER,DBPASS) ;
		
		pstmt = conn.prepareStatement(sql) ;
		if(!keyword.equals("")){
			pstmt.setString(1, "%"+keyword+"%");
		}
		rs = pstmt.executeQuery() ;
%>	
		<h2>��ѯ�����</h2>
		<table border="1">
			<tr>
			<td>��Աid</td>
			<td>�û���</td>
			<td>����</td>
			<td>�Ա�</td>
			<td>���</td>
			</tr>
<%		
		
		while(rs.next()){
			int id = rs.getInt(1);
			String username = rs.getString(2);
			int age = rs.getInt(3);
			String sex = rs.getString(4);
			double balance = rs.getDouble(5);	
			count += 1;
%>
			<tr>
			<td><%=id%></td>
			<td><%=username%></td>
			<td><%=age%></td>
			<td><%=sex%></td>
			<td><%=balance%></td>
			</tr>
<%			
			}
		}catch(Exception e){
			System.out.println(e);
		}finally{
			rs.close() ;
			pstmt.close() ;
			conn.close() ;	
			}
%>
			<tr>
			<td colspan="5">���ҵ� <%=count%> �����������Ľ����<a href="QueryUser.html">���ػ�Ա��ѯ����</a></td>
			</tr>
		</table>
</body>
</html>