package business;

public class Client extends Person {

	private String credit_card;
	private Cart cart;

	public Client(String first_name, String last_name, String mail, String phone, String password) {
		super(first_name, last_name, mail, phone, password, false);
	}

	public String getCreditCard() {
		return credit_card;
	}

	public void setCreditCard(String credit_card) {
		this.credit_card = credit_card;
	}

	public Cart getCart() {
		return cart;
	}

	public void setCart(Cart cart) {
		this.cart = cart;
	}
}
