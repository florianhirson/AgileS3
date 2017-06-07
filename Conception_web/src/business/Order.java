package business;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class Order {
	private int order_id;
	private int client_id;
	private String address;
	private String recipient;
	private int status;
	private Date date;
	private Map<Integer, Integer> references_quantity = new HashMap<Integer, Integer>();

	// Passer une commande

	public Order(int client_id, Map<Integer, Integer> references_quantity) {
		this.client_id = client_id;
		this.references_quantity = references_quantity;
		this.status = 0;
		this.date = new Date();
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}

	// Afficher une commande depuis la BDD

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

	public String getStatusToString() {
		switch (status) {
		case -3:
			return "Annule";
		case -2:
			return "Erreur de livraison";
		case -1:
			return "Erreur de stock";
		case 0:
			return "En attente";
		case 1:
			return "En cours de preparation";
		case 2:
			return "Expidie";
		case 3:
			return "Livre";
		}
		return null;
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

	public Date getDate() {
		return date;
	}

	@Override
	public String toString() {
		String temp = "Commande : " + getOrder_id() + "\nClient : " + getClient_id() + "\nStatus : "
				+ getStatusToString() + "\nAddresse : " + getAddress() + "\nDestinataire : " + getRecipient()
				+ "\nContenu de la commande :";
		for (Integer reference : references_quantity.keySet()) {
			Article article = Bridge.getArticle(reference);
			temp += "\n   Article " + article.getName() + " :\n" + this.references_quantity.get(reference).toString();
		}
		return temp;
	}

	public String toHTML() {
		String temp = "<tr><th>Libelle</th><th>Quantite</th><th>Aperçu</th>";
		for (Integer reference : references_quantity.keySet()) {
			Article article = Bridge.getArticle(reference);
			temp += "<tr><td>" + article.getName() + "</td><td>" + article.getReference() + "</td><td><img src=\""
					+ article.getImage_url()
					+ "\" class=\"img-responsive img-thumbnail\" style=\"width:10%; height:auto ; display:inline-block ; float:right \" alt=\""
					+ article.getName() + "\" /></td></tr>\n";

		}
		temp += "<tr><td>Remises :</td><td>" + this.getTotalDiscount() + " </td><td>euros TTC</td></tr>\n";
		temp += "<tr><td>Montant a payé :</td><td>" + this.getTotalPrice() + " </td><td>euros TTC</td></tr>\n";
		return temp;
	}
}
