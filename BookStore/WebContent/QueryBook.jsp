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
<title>查询图书-网上书店系统</title>
</head>
<body>

<%
	Connection conn = null ;
	PreparedStatement pstmt = null ;
	ResultSet rs = null ;
	String sql = "";
	int count = 0;
	
	String keyword = request.getParameter("keyword");
	
	if(keyword.equals("")){
		sql = "SELECT id,name,author,price,num FROM book";
	}
	else{
		sql = "SELECT id,name,author,price,num FROM book WHERE name LIKE ?";
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
		<h2>查询结果：</h2>
		<table border="1">
			<tr>
			<td>书名</td>
			<td>作者</td>
			<td>价格</td>
			<td>库存</td>
			<td>购买数量</td>
			</tr>
<%		
		
		while(rs.next()){
			int id = rs.getInt(1);
			String name = rs.getString(2);
			String author = rs.getString(3);
			double price = rs.getDouble(4);
			int quantity = rs.getInt(5);
			count += 1;
%>
			<tr>
			<td><%=name%></td>
			<td><%=author%></td>
			<td><%=price%></td>
			<td><%=quantity%></td>
			<td>
				<form name="add" action="ShoppingCart.jsp" method="post" style="margin: 0;">
					<input name="id" value=<%=id%> type="hidden">
					<input name="flag" value=2 type="hidden">
					<input name="num" style="width: 4em;" type="text">
<%
	if(quantity==0){
		out.println("<input value=\"加入购物车\" type=\"submit\" disabled=\"disabled\">");
	}
	else{
		out.println("<input value=\"加入购物车\" type=\"submit\">");
	}
%>
				</form>
			</td>
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
			<td colspan="5">共找到 <%=count%> 个符合条件的结果！<a href="QueryBook.html">返回图书查询界面</a></td>
			</tr>
		</table>
</body>
</html>