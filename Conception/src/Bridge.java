import java.sql.Connection;
import java.sql.DriverManager;

import business.Admin;
import business.Article;
import business.Client;

public class Bridge {

	private Connection con;
	
	/**
	 * Creer la connection avec la bdd
	 * @throws ClassNotFoundException 
	 */
	Bridge() throws Exception{
		Class.forName("org.postgresql.Driver");
		con = DriverManager.getConnection("jdbc:postgresql://psqlserv/n2p1?allowMultiQueries=true","barbetf","moi");
	}
	
	/**
	 * Transforme les articles de la bdd en objet Article
	 * @param ref les references vers les articles
	 * @return un tableau d'article
	 */
	Article[] getArticles(int ... ref){
		return null;
	}
	
	Article[] getAllArticles(){
		return null;
	}
	
	/**
	 * Transforme un client de la bdd en objet Client
	 * @param ID
	 * @return un objet Client
	 */
	Client getClient(int ID){
		return null;
	}
	
	/**
	 * Transforme un client de la bdd en objet Admin
	 * @param ID
	 * @return un objet Admin
	 */
	Admin getAdmin(int ID){
		return null;
	}
	
	/**
	 * Transforme une commande de la bdd en objet Order
	 * @param ID
	 * @return un objet Order
	 */
	Order getOrder(int ID){
		return null;
	}
	
}
