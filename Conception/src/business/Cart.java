package business;

import java.util.HashMap;
import java.util.Map;
import javafx.util.Pair;

public class Cart {

	Map<Integer, Pair<Article, Integer>> cartMap;
			
	public Cart(){
		cartMap = new HashMap<Integer, Pair<Article, Integer>>();
	}
	
	/**
	 * Calcul le prix total du panier
	 * @return le prix total du panier
	 */
	public double getTotalPrice(){
		double total = 0.0;
		for(Pair<Article, Integer> p : cartMap.values()){
			total =+ p.getKey().getPrice()*p.getValue();
		}
		return total;
	}
	
	/**
	 * Retire un article du panier
	 * @param ref, la reference de l'article
	 * @return true si l'objet existé et a été retiré, false sinon
	 */
	public boolean remove(int ref){
		for(Pair<Article, Integer> p : cartMap.values()){
			if(p.getKey().getReference()==ref){
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
		Pair<Article, Integer> p = cartMap.get(ref);
		if(p != null) cartMap.put(ref, new Pair<Article, Integer>(a, p.getValue()+number));
		else cartMap.put(ref, new Pair<Article, Integer>(a, number));
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
		cartMap.put(ref, new Pair<Article, Integer>(a, number));
		return true;
	}
	
	
}
