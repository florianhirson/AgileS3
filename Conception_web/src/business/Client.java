package business;

import java.util.Date;

public class Client extends Person {
	private String credit_card_number;
	private Date credit_card_date;
	private Cart cart;

	public Client(Person person, String credit_card_number, Date credit_card_date) {
		super(person);
		this.credit_card_number = credit_card_number;
		this.credit_card_date = credit_card_date;
	}

	public String getCreditCardNumber() {
		return credit_card_number;
	}

	public Date getCreditCardDate() {
		return credit_card_date;
	}

	public Boolean isCreditCardValid() {
		return credit_card_date.before(new Date());
	}

	public void setCreditCard(String credit_card_number, Date credit_card_date) {
		this.credit_card_number = credit_card_number;
		this.credit_card_date = credit_card_date;
	}

	public Cart getCart() {
		return cart;
	}

	public void setCart(Cart cart) {
		this.cart = cart;
	}
}
