package business;

import java.util.HashMap;
import java.util.Map;

public class Cart {

	Map<Integer, Integer> references_quantity;

	public Cart() {
		references_quantity = new HashMap<Integer, Integer>();
	}

	/**
	 * Calcul le prix total du panier
	 * 
	 * @return le prix total du panier
	 */
	public double getTotalPrice() {
		double total = 0.0;
		for (Integer i : references_quantity.keySet()) {
			Article a = Bridge.getArticles(i).get(0);
			if (a != null) {
				total += a.getPrice() * references_quantity.get(i);
			}
		}
		return total;
	}

	/**
	 * Retire un article du panier
	 * 
	 * @param ref,
	 *            la reference de l'article
	 * @return true si l'objet existé et a été retiré, false sinon
	 */
	public boolean remove(int ref) {
		for (Integer i : references_quantity.keySet()) {
			Article a = Bridge.getArticles(i).get(0);
			if (a != null && a.getReference() == ref) {
				references_quantity.remove(ref);
				return true;
			}
		}
		return false;
	}

	/**
	 * Ajoute un article au panier (un seul exemplaire)
	 * 
	 * @param ref
	 * @return true si l'article a été ajouté, false en cas d'erreur ou si il
	 *         n'existe pas
	 */
	public boolean add(int ref) {
		return this.add(ref, 1);
	}

	/**
	 * Ajoute un certain nombre du meme article au panier
	 * 
	 * @param ref
	 * @param number
	 * @return true si l'article a été ajouté, false en cas d'erreur ou si il
	 *         n'existe pas
	 */
	public boolean add(int ref, int number) {
		Article a = Bridge.getArticles(ref).get(0);
		if (a == null) {
			return false;
		}
		Integer i = references_quantity.get(ref);
		if (i != null) {
			references_quantity.put(ref, number + i);
		} else {
			references_quantity.put(ref, number);
		}
		return true;
	}

	/**
	 * Initialise un article a un certain nombre
	 * 
	 * @param ref
	 * @param number
	 */
	public boolean set(int ref, int number) {
		Article a = Bridge.getArticles(ref).get(0);
		if (a == null) {
			return false;
		}
		references_quantity.put(ref, number);
		return true;
	}

	@Override
	public String toString() {

		String temp = "Contenu du panier :";
		for (int i = 0; i < this.references_quantity.size(); i++) {
			temp += "\nArticle " + i + " :\n" + this.references_quantity.get(i).toString();
		}
		return null;
	}
}
