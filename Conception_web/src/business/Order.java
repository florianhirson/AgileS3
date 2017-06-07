package business;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class Order {
	private final int order_id;
	private final int client_id;
	private final String address;
	private final String recipient;
	private int status;
	private Date date;
	private Map<Integer, Integer> references_quantity = new HashMap<Integer, Integer>();

	public Order(int order_id, int client_id, String address, String recipient, int status, Date date,
			Map<Integer, Integer> references_quantity) {
		this.order_id = order_id;
		this.client_id = client_id;
		this.address = address;
		this.recipient = recipient;
		this.status = status;
		this.date = date;
		this.references_quantity = references_quantity;
	}

	public int getOrder_id() {
		return order_id;
	}

	public int getClient_id() {
		return client_id;
	}

	public int getStatus() {
		return status;
	}

	public String getAddress() {
		return address;
	}

	public String getRecipient() {
		return recipient;
	}

	public Map<Integer, Integer> getReferences_quantity() {
		return references_quantity;
	}

}