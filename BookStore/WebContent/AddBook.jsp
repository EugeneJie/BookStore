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
<title>增加图书-网上书店系统</title>
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
	String sql = "SELECT name,author,price,num FROM book";
	
	boolean flag = true;
	
	String bookname = request.getParameter("name");
	String author = request.getParameter("author");
	String price_ = request.getParameter("price");
	String num_ = request.getParameter("num");
	double price = 0;
	int num = 0;
	
	double oldprice = 0;
	int oldnum = 0;
	
	response.setHeader("refresh","5;URL=AddBook.html");
	
	if(bookname.equals("")|author.equals("")|price_.equals("")|num_.equals("")){
		flag = false;
%>
		<h1> 操作失败： 所有图书信息均不能为空，请填写完整！</h1> <br>
		<h2>5秒后回到增加图书界面，点击<a href="AddBook.html">这里</a>立即跳转</h2>
<%
	}
	else{
		try{
			price = Double.parseDouble(price_);
			if(price<=0){
				int errorint = 1/0;
			}
		}catch(Exception e){
			flag = false;
%>
			<h1> 操作失败： 图书价格应为正整数或浮点数！</h1> <br>
			<h2>5秒后回到增加图书界面，点击<a href="AddBook.html">这里</a>立即跳转</h2> <br><br>
<%
		}
		try{
			num = Integer.parseInt(num_);
			if(num<=0){
				int errorint = 1/0;
			}
		}catch(Exception e){
			flag = false;
%>
			<h1> 操作失败： 图书数量应为正整数！</h1> <br>
			<h2>5秒后回到增加图书界面，点击<a href="AddBook.html">这里</a>立即跳转</h2>
<%
		}
	}
%>

<%
	if(flag){
		try{
			Class.forName(DBDRIVER) ;
			conn = DriverManager.getConnection(DBURL,DBUSER,DBPASS) ;
			
			pstmt = conn.prepareStatement(sql) ;
			rs = pstmt.executeQuery() ;
			
			while(rs.next()){
				String name = rs.getString(1);
				String writer = rs.getString(2);
				if(bookname.equals(name) && author.equals(writer)){
					oldprice = rs.getDouble(3);
					oldnum = rs.getInt(4);
					flag = false;	
					rs.close() ;
					pstmt.close() ;
					break;
					}
				}
			
			if(flag){	
				sql = "INSERT INTO book(name,author,price,num) VALUES (?,?,?,?)";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,bookname);
				pstmt.setString(2,author);
				pstmt.setDouble(3,price);
				pstmt.setInt(4,num);
				
				pstmt.executeUpdate() ;
			}
			else{
				num += oldnum;
				sql = "UPDATE book SET price=?,num=? WHERE name=? and author=?";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setDouble(1,price);
				pstmt.setInt(2,num);
				pstmt.setString(3,bookname);
				pstmt.setString(4,author);
				
				pstmt.executeUpdate() ;
				flag = true;
			}
			}
		catch(Exception e){flag = false;System.out.println(e);}
		finally{
				rs.close() ;
				pstmt.close() ;
				conn.close() ;	
				}
%>

<%
	if(flag){
%>
		<h1><%=author%>的《<%=bookname%>》增加成功！</h1> <br>
<%
	if(oldprice==0 | oldprice==price){
%>
		<h2>价格：<%=price%>元</h2>		
<%		
	}
	else{
%>
		<h2>价格：<%=oldprice%>元--><%=price%>元</h2>
<%		
	}
%>		<br>
		<h2>数量：<%=oldnum%>--><%=num%></h2> <br><br>
		<h2>5秒后回到增加图书界面，点击<a href="AddBook.html">这里</a>立即跳转</h2>

<%
	}
	else{
%>
		<h1>图书增加失败，请重试！</h1> <br>
		<h2>5秒后回到增加图书界面，点击<a href="AddBook.html">这里</a>立即跳转</h2>
<% }} %>

</body>
</html>