package business;

import java.util.HashMap;
import java.util.Map;

public class Cart {

	Map<Integer, Integer> cartMap;
			
	public Cart(){
		cartMap = new HashMap<Integer, Integer>();
	}
	
	/**
	 * Calcul le prix total du panier
	 * @return le prix total du panier
	 */
	public double getTotalPrice(){
		double total = 0.0;
		for(Integer i : cartMap.keySet()){
			Article a = Bridge.getArticles(i)[0];
			if(a != null) total =+ a.getPrice()*cartMap.get(i);
		}
		return total;
	}
	
	/**
	 * Retire un article du panier
	 * @param ref, la reference de l'article
	 * @return true si l'objet existé et a été retiré, false sinon
	 */
	public boolean remove(int ref){
		for(Integer i : cartMap.keySet()){
			Article a = Bridge.getArticles(i)[0];
			if(a != null && a.getReference() == ref){
				cartMap.remove(ref);
				return true;
			}
		}
		return false;
	}
	
	/**
	 * Ajoute un article au panier (un seul exemplaire)
	 * @param ref
	 * @return true si l'article a été ajouté, false en cas d'erreur ou si il n'existe pas
	 */
	public boolean add(int ref){
		return this.add(ref, 1);
	}
	
	/**
	 * Ajoute un certain nombre du meme article au panier
	 * @param ref
	 * @param number
	 * @return true si l'article a été ajouté, false en cas d'erreur ou si il n'existe pas
	 */
	public boolean add(int ref, int number){
		Article a = Bridge.getArticles(ref)[0];
		if(a == null) return false;
		Integer i = cartMap.get(ref);
		if(i != null) cartMap.put(ref, number+i);
		else cartMap.put(ref, number);
		return true;
	}
	
	/**
	 * Initialise un article a un certain nombre
	 * @param ref
	 * @param number
	 */
	public boolean set(int ref, int number){
		Article a = Bridge.getArticles(ref)[0];
		if(a == null) return false;
		cartMap.put(ref, number);
		return true;
	}
	
	
}
