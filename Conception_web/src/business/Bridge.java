package business;

import java.sql.Connection;
import java.sql.DriverManager;

public class Bridge {

	private static Connection con;

	/**
	 * Creer la connection avec la bdd
	 * 
	 * @throws ClassNotFoundException
	 */
	public Bridge() throws Exception {
		Class.forName("org.postgresql.Driver");
		con = DriverManager.getConnection("jdbc:postgresql://psqlserv/n2p1?allowMultiQueries=true", "barbetf", "moi");
	}

	/**
	 * Transforme les articles de la bdd en objet Article
	 * 
	 * @param ref
	 *            les references vers les articles
	 * @return un tableau d'article
	 */
	public static Article[] getArticles(int... ref) {
		return null;
	}

	public static Article[] getAllArticles() {
		return null;
	}

	/**
	 * Transforme un client de la bdd en objet Client
	 * 
	 * @param ID
	 * @return un objet Client
	 */
	public static Client getClient(int ID) {
		return null;
	}

	/**
	 * Transforme un client de la bdd en objet Admin
	 * 
	 * @param ID
	 * @return un objet Admin
	 */
	public static Admin getAdmin(int ID) {
		return null;
	}

	/**
	 * Transforme une commande de la bdd en objet Order
	 * 
	 * @param ID
	 * @return un objet Order
	 */
	public static Order getOrder(int ID) {
		return null;
	}

}
