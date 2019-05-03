<%@ page language="java" contentType="text/html" pageEncoding="GBK"%>
<%@ page import="java.sql.*,javaee.*,java.util.Random"%>

<% request.setCharacterEncoding("GBK"); %>

<%!
	public static final String DBDRIVER = "com.mysql.jdbc.Driver" ;
	public static final String DBURL = "jdbc:mysql://localhost:3306/bookstore?useSSL=false" ;
	public static final String DBUSER = "root" ;
	public static final String DBPASS = "root" ;
%>
<%
	Connection conn = null ;
	PreparedStatement pstmt = null ;
	ResultSet rs = null ;
	String sql = "SELECT username FROM user";
	
	boolean flag = true;
	
	User user = null;
	Admin admin = null;
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	int age = 18;
	try{
		age = Integer.parseInt(request.getParameter("age"));
		if(age<=0){
			age = 1;
		}
	}catch(Exception e){
%>
		<jsp:forward page="error.jsp">
			<jsp:param name="type" value="1"/>
			<jsp:param name="flag" value="3"/>
		</jsp:forward>
<%	
	}
	String sex = request.getParameter("sex");
	
	if(username.equals("") | password.equals("")){
%>
		<jsp:forward page="error.jsp">
			<jsp:param name="type" value="1"/>
			<jsp:param name="flag" value="0"/>
		</jsp:forward>
<%
	}
%>

<%
	try{
		Class.forName(DBDRIVER) ;
		conn = DriverManager.getConnection(DBURL,DBUSER,DBPASS) ;
		
		pstmt = conn.prepareStatement(sql) ;
		rs = pstmt.executeQuery() ;
		
		while(rs.next()){
			String name = rs.getString(1) ;
			if(username.equals(name)){
				flag = false;	
				rs.close() ;
				pstmt.close() ;
				break;
				}
			}
		
		if(flag){
			Random rand = new Random();
			double balance = rand.nextInt(1000-500+1)+500;			
			sql = "INSERT INTO user(username,password,balance,age,sex) VALUES (?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,username);
			pstmt.setString(2,password);
			pstmt.setDouble(3, balance);
			pstmt.setInt(4,age);
			pstmt.setString(5,sex);
			
			pstmt.executeUpdate() ;
		}
		}
	catch(Exception e){System.out.println(e);}
	finally{
			rs.close() ;
			pstmt.close() ;
			conn.close() ;	
			}
%>
<%
	if(flag){
		System.out.println("×¢²á³É¹¦£¡");
%>
		<jsp:forward page="welcome.jsp">
			<jsp:param name="name" value="<%=username%>"/>
			<jsp:param name="flag" value="register"/>
		</jsp:forward>

<%
	}
	else{
		System.out.println("×¢²áÊ§°Ü£¡");
		//response.sendRedirect("login_error.jsp");
%>
		<jsp:forward page="error.jsp">
			<jsp:param name="type" value="1"/>
			<jsp:param name="flag" value="2"/>
		</jsp:forward>
<% } %>
