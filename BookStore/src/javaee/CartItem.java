package javaee;

public class CartItem {
	private int id;
	private String name;
	private String author;
	private double price;
	private int quantity;

	public CartItem(int id, String name, String author, double price, int quantity) {
		this.id = id;
		this.name = name;
		this.author = author;
		this.price = price;
		this.quantity = quantity;
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getSum() {
		return this.quantity * this.price;
	}
}
