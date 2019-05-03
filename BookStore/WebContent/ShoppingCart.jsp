<%@ page language="java" contentType="text/html" pageEncoding="GBK"%>
<%@ page import="java.sql.*,javaee.*,java.util.ArrayList"%>

<% request.setCharacterEncoding("GBK"); %>

<%!
	public static final String DBDRIVER = "com.mysql.jdbc.Driver" ;
	public static final String DBURL = "jdbc:mysql://localhost:3306/bookstore?useSSL=false" ;
	public static final String DBUSER = "root" ;
	public static final String DBPASS = "root" ;
%>

<html>
<head>
<title>���ﳵ-�������ϵͳ</title>
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
	
	String username = user.getUsername();
	double balance = user.getBalance();
	
	Connection conn = null ;
	PreparedStatement pstmt = null ;
	ResultSet rs = null ;
	String sql = "";
	
	String id_ = request.getParameter("id");
	String flag_ = request.getParameter("flag");
	int id,flag;
	
	ShoppingCart cart = (ShoppingCart) session.getAttribute("shoppingcart");
	if (cart == null) {
		cart = new ShoppingCart();
		session.setAttribute("shoppingcart", cart);
	}
	
	if(id_!=null && flag_!=null){
		id = Integer.parseInt(id_);
		flag = Integer.parseInt(flag_);
		
		if(flag==1){           // flag=1ʱ�Ƴ����ﳵ
			cart.removeCartItem(id);
			session.setAttribute("shoppingcart", cart);
		}
		if(flag==2){       // flag=2ʱ���빺�ﳵ
			String num_ = request.getParameter("num");
			int num = 1;
			try{
				num = Integer.parseInt(num_);
				if(num<=0){
					num = 1;
				}
			}catch(Exception e){
				num = 1;
			}
			sql = "SELECT name,author,price FROM book WHERE id=?";
			
			try{
				Class.forName(DBDRIVER) ;
				conn = DriverManager.getConnection(DBURL,DBUSER,DBPASS) ;
				
				pstmt = conn.prepareStatement(sql) ;
				pstmt.setInt(1, id);

				rs = pstmt.executeQuery() ;

				while(rs.next()){
					String name = rs.getString(1);
					String author = rs.getString(2);
					double price = rs.getDouble(3);	
					
					CartItem item = new CartItem(id,name,author,price,num);	
					cart.addCartItem(item);
					}
				}catch(Exception e){
					System.out.println(e);
				}finally{
					rs.close() ;
					pstmt.close() ;
					conn.close() ;	
					}
		}
	}
	
	if(id_==null && flag_!=null){      
		flag = Integer.parseInt(flag_);
		if(flag==0){                            // flag=0ʱ��չ��ﳵ
			cart = new ShoppingCart();
			session.setAttribute("shoppingcart", cart);
		}
	}
%>	
		<h2><%=username%>����<%=balance%>Ԫ���Ĺ��ﳵ��</h2>
		[<a href="ShoppingCart.jsp?flag=0">��չ��ﳵ</a>] 
		[<a href="QueryBook.html">����ͼ���ѯ����</a>] <br>
		<table border="1">
			<tr>
			<td>����</td>
			<td>����</td>
			<td>�۸�</td>
			<td>����</td>
			<td>����</td>
			</tr>
			
<%
	ArrayList<CartItem> items = cart.getCart();
	CartItem item = null;
	
	for (int i = 0; i < items.size(); i++) {
		item = items.get(i);
%>
		<tr>
		<td><%=item.getName()%></td>
		<td><%=item.getAuthor()%></td>
		<td><%=item.getPrice()%>Ԫ</td>
		<td><%=item.getQuantity()%></td>
		<td>
			<form action="ShoppingCart.jsp" method="post" style="margin: 0;">
				<input name="id" value=<%=item.getId()%> type="hidden">
				<input name="flag" value=1 type="hidden">
				<input value="�Ƴ����ﳵ" type="submit">
			</form>
		</td>
		</tr>
<%
	}
%>

		<tr>
		<td colspan="5">
			���ﳵ�й���<%=items.size()%>����Ʒ�����ƣ�<%=cart.getTotal()%>Ԫ
			<a href="pay.jsp">ȥ����</a>
		</td>
		</tr>
	</table>
</body>
</html>