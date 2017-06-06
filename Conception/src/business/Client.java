package business;

public class Client extends Personne{
	
	String creditCard;
	Cart cart;
	
	public Client(){
		super();
		this.role = false;
		this.cart = new Cart();
	}
	
	public String getCreditCard() {
		return creditCard;
	}
	public void setCreditCard(String creditCard) {
		this.creditCard = creditCard;
	}
	public Cart getCart() {
		return cart;
	}
	public void setCart(Cart cart) {
		this.cart = cart;
	}
}
