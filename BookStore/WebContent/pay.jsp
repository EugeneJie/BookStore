<%@ page language="java" contentType="text/html" pageEncoding="GBK"%>
<%@ page import="java.sql.*,javaee.*,java.util.*"%>

<% request.setCharacterEncoding("GBK"); %>

<%!
	public static final String DBDRIVER = "com.mysql.jdbc.Driver" ;
	public static final String DBURL = "jdbc:mysql://localhost:3306/bookstore?useSSL=false" ;
	public static final String DBUSER = "root" ;
	public static final String DBPASS = "root" ;
%>

<html>
<head>
<title>�������-�������ϵͳ</title>
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
	
	Connection conn = null ;
	PreparedStatement pstmt = null ;
	ResultSet rs = null ;
	
	String username = user.getUsername();
	double balance = user.getBalance();
	
	ShoppingCart cart = (ShoppingCart) session.getAttribute("shoppingcart");
	String url = "";
	double money = 0;
	
	boolean flag = false;  //��治���ʶ
	Map<Integer, Integer> map = new HashMap<Integer, Integer>();  // ��Ź��ﳵ��ͼ������
	
	if(cart!=null){
		int quantity = 0;
		money = cart.getTotal();
		ArrayList<CartItem> items = cart.getCart();
		CartItem item = null;
		
		for(int i = 0; i < items.size(); i++) {
			item = items.get(i);
			int id = item.getId();
			map.put(id, item.getQuantity());
			String sql = "SELECT num from book WHERE id=?";
			
			try{
				Class.forName(DBDRIVER) ;
				conn = DriverManager.getConnection(DBURL,DBUSER,DBPASS) ;
				
				pstmt = conn.prepareStatement(sql) ;	
				pstmt.setInt(1, id);
				rs = pstmt.executeQuery() ;
				while(rs.next()){
					quantity = rs.getInt(1);			
				}
				if(quantity<item.getQuantity()){
					flag = true;
					break;
				}
			}catch(Exception e){
				System.out.println(e);
			}finally{
				rs.close() ;
				pstmt.close() ;
				conn.close() ;	
				}
			}
		
		if(flag){
			url = "ShoppingCart.jsp";
%>
			<h1>����ʧ�ܣ�<%=item.getAuthor()%>�ġ�<%=item.getName()%>������<%=item.getQuantity()%>������棺<%=quantity%></h1> <br>
			<h2>5���ص����ﳵ�����<a href="ShoppingCart.jsp">����</a>������ת</h2> <br><br>
<%
		}
	}
	
if(!flag){
	
	if (cart == null | money ==0) {
		url = "QueryBook.html";
%>
		<h1>���Ĺ��ﳵ�տ���Ҳ����ȥ�����Ʒ�ɣ�</h1> <br>
		<h2>5���ص�ͼ���ѯ���棬���<a href="QueryBook.html">����</a>������ת</h2> <br><br>
<%
	}
	else if(money>balance){
		url = "ShoppingCart.jsp";
%>
		<h1>����ʧ�ܣ��������㣡</h1> <br>
		<h2>5���ص����ﳵ�����<a href="ShoppingCart.jsp">����</a>������ת</h2> <br><br>
<%
	}
	else{
		url = "QueryBook.html";
		
		try{
			balance -= money;			
			String sql = "UPDATE user SET balance=? WHERE username=?";
			Class.forName(DBDRIVER) ;
			conn = DriverManager.getConnection(DBURL,DBUSER,DBPASS) ;
			
			pstmt = conn.prepareStatement(sql) ;
			pstmt.setDouble(1, balance);
			pstmt.setString(2, username);
			
			pstmt.executeUpdate() ;
		}catch(Exception e){
			System.out.println(e);
		}finally{
			rs.close() ;
			pstmt.close() ;
			conn.close() ;	
			}
		
		ArrayList<CartItem> items = cart.getCart();
		CartItem item = null;
		
		for(int i = 0; i < items.size(); i++) {
			item = items.get(i);
			int id = item.getId();
			int num = map.get(id);
			String sql = "UPDATE book SET num=num-? WHERE id=?";
			try{
				Class.forName(DBDRIVER) ;
				conn = DriverManager.getConnection(DBURL,DBUSER,DBPASS) ;
				
				pstmt = conn.prepareStatement(sql) ;
				pstmt.setInt(1, num);
				pstmt.setInt(2, id);
				
				pstmt.executeUpdate() ;
			}catch(Exception e){
				System.out.println(e);
			}finally{
				rs.close() ;
				pstmt.close() ;
				conn.close() ;	
				}
		}
			
%>
		<h1>����ɹ���������<%=balance%>Ԫ</h1> <br>
		<h2>5���ص�ͼ���ѯ���棬���<a href="QueryBook.html">����</a>������ת</h2> <br><br>
<%
		user.setBalance(balance);
		session.setAttribute("user", user);
		session.removeAttribute("shoppingcart");
	}
}
	response.setHeader("refresh","5;URL="+url);
%>	

</body>
</html>