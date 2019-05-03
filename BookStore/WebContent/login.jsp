<%@ page language="java" contentType="text/html" pageEncoding="GBK"%>
<%@ page import="java.sql.*,javaee.*"%>

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
	String sql = null;
	
	boolean flag = false;
	boolean isadmin = false;
	
	User user = null;
	Admin admin = null;
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	
	if(username.equals("") | password.equals("")){
%>
		<jsp:forward page="error.jsp">
			<jsp:param name="type" value="0"/>
			<jsp:param name="flag" value="0"/>
		</jsp:forward>
<%
	}
%>

<%
	try{
		Class.forName(DBDRIVER) ;
		conn = DriverManager.getConnection(DBURL,DBUSER,DBPASS) ;
		if(request.getParameter("admin")==null){
			sql = "SELECT username,password,balance,age,sex FROM user" ;
			user = new User();
			isadmin = false;
		}
		else{
			sql = "SELECT username,password FROM admin" ;
			admin  = new Admin();
			isadmin = true;
		}
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		while(rs.next()){
			String name = rs.getString(1);
			String psd = rs.getString(2);
			if(username.equals(name) && password.equals(psd)){
				flag = true;
				
				if(isadmin){
					admin.setUsername(name);
					admin.setPassword(psd);
				}
				else{
					double balance = rs.getDouble(3);
					int age = rs.getInt(4);
					String sex = rs.getString(5);
					user.setUsername(name);
					user.setPassword(psd);
					user.setBalance(balance);
					user.setAge(age);
					user.setSex(sex);
				}
				break;
				}
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
		System.out.println("µÇÂ¼³É¹¦£¡");
		if(isadmin){
			session.setAttribute("admin",admin);
		}
		else{
			session.setAttribute("user",user);
		}
		//response.sendRedirect("welcome.jsp");
		
%>
		<jsp:forward page="welcome.jsp">
			<jsp:param name="name" value="<%=username%>"/>
			<jsp:param name="flag" value="<%=isadmin%>"/>
		</jsp:forward>

<%
	}
	else{
		System.out.println("µÇÂ¼Ê§°Ü£¡");
		//response.sendRedirect("login_error.jsp");
%>
		<jsp:forward page="error.jsp">
			<jsp:param name="type" value="0"/>
			<jsp:param name="flag" value="1"/>
		</jsp:forward>
<% } %>
