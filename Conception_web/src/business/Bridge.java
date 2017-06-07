package business;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Bridge {
	private static Connection connection = null;

	private static void connect() throws Exception {
		Class.forName("org.postgresql.Driver");
		String url = "jdbc:postgresql://psqlserv/n2p1";
		String nom = "dujardir";
		String mdp = "moi";
		connection = DriverManager.getConnection(url, nom, mdp);
	}

	private static void disconnect() throws Exception {
		connection.close();
	}

	// Person ########## ########## ########## ########## ########## ########## ########## ########## ########## ########## 

	/**
	 * @return Client ou Admin correspondant a l'ID, null si non trouve. 
	 * @param id ID
	 */
	protected static Person getPerson(int id) {
		try {
			connect();

			String query = "SELECT * FROM person WHERE id=" + id + ";";

			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(query);

			if (rs.next()) {
				if (rs.getBoolean("is_admin")) {
					return new Admin(new Person(rs.getInt("id"), rs.getString("first_name"), rs.getString("last_name"),
							rs.getString("mail"), rs.getString("password"), rs.getString("default_adress"),
							rs.getString("phone")));
				} else {
					return new Client(
							new Person(rs.getInt("id"), rs.getString("first_name"), rs.getString("last_name"),
									rs.getString("mail"), rs.getString("password"), rs.getString("default_adress"),
									rs.getString("phone")),
							rs.getString("credit_card_number"), rs.getDate("credit_card_date"));
				}
			}
		} catch (	Exception ex)	{
			System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
		} finally	{
			try {
				disconnect();
			} catch (Exception ex) {
				System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
			}
		}

		return null;
	}

	/**
	 * @return Client ou Admin correspondant au Mail si le Mot de passe est correct, null si non trouve ou Mot de passe incorrect. 
	 * @param mail Mail
	 * @param password Mot de passe
	 */
	public static Person getPerson(String mail, String password) {
		try {
			connect();

			String query = "SELECT * FROM person WHERE mail=" + mail + ";";

			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(query);

			if (rs.getFetchSize() == 1) {
				rs.next();
				if (rs.getString("password").equals(password)) {
					if (rs.getBoolean("is_admin")) {
						return new Admin(new Person(rs.getInt("id"), rs.getString("first_name"),
								rs.getString("last_name"), rs.getString("mail"), rs.getString("password"),
								rs.getString("default_adress"), rs.getString("phone")));
					} else {
						return new Client(
								new Person(rs.getInt("id"), rs.getString("first_name"), rs.getString("last_name"),
										rs.getString("mail"), rs.getString("password"), rs.getString("default_adress"),
										rs.getString("phone")),
								rs.getString("credit_card_number"), rs.getDate("credit_card_date"));
					}
				}
			}
		} catch (	Exception ex) {
			System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
		} finally	{
			try {
				disconnect();
			} catch (Exception ex) {
				System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
			}
		}

		return null;
	}

	/**
	 * @return ArrayList contenant toutes les Clients et Admins correspondant au filtre
	 * @param filter Filtre ecrit en SQL
	 */
	protected static List<Person> getAllPersonsFILTERED(String filter) {
		ArrayList<Person> persons = new ArrayList<>();
		try {
			connect();

			String query = "SELECT * FROM person";
			if (filter != null) {
				query += filter;
			}
			query += ";";

			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(query);

			while (rs.next()) {
				if (rs.getBoolean("is_admin")) {
					persons.add(new Admin(new Person(rs.getInt("id"), rs.getString("first_name"),	rs.getString("last_name"), rs.getString("mail"), rs.getString("password"), rs.getString("default_adress"), rs.getString("phone"))));
				} else {
					persons.add(new Client(new Person(rs.getInt("id"), rs.getString("first_name"), rs.getString("last_name"), rs.getString("mail"), rs.getString("password"), rs.getString("default_adress"), rs.getString("phone")), rs.getString("credit_card_number"), rs.getDate("credit_card_date")));
				}
			}
		} catch (Exception ex) {
			System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
		} finally {
			try {
				disconnect();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}

		return persons;
	}

	/**
	 * @param id ID de la Person a modifier
	 * @param column Collone a modifier
	 * @param new_value Nouvelle valeur
	 */
	public static void updatePerson(int id, String column, String new_value) {
		try {
			connect();

			String query = "UPDATE person SET " + column + " = " + new_value + " WHERE id = " + id + ";" ;
			Statement statement = connection.createStatement();
			statement.executeQuery(query);
		} catch (

				Exception ex) {
			System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
		} finally

		{
			try {
				disconnect();
			} catch (Exception ex) {
				System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
			}
		}
	}


	// Article ########## ########## ########## ########## ########## ########## ########## ########## ########## ########## 


	/**
	 * @return Article correspondant a la Reference, null si non trouve. 
	 * @param reference Reference
	 */
	public static Article getArticle(int reference) {
		try {
			connect();

			String query = "SELECT * FROM article WHERE reference=" + reference + ";";
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(query);

			if (rs.next()) {
				return new Article(rs.getInt("reference"), rs.getString("name"), rs.getString("description"), rs.getString("image_url"), rs.getString("brand"), rs.getString("category"), rs.getDouble("price"), rs.getDouble("discount"), rs.getInt("quantity"));
			}
		} catch (

				Exception ex)

		{
			System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
		} finally

		{
			try {
				disconnect();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}

		return null;
	}

	public static boolean containsArticle(int reference, int quantity) {
		try {
			connect();

			String query = "SELECT * FROM article WHERE reference=" + reference + ";";
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(query);

			if (rs.next()) {
				if (rs.getInt("quantity") >= quantity) {
					return true;
				}
			}
		} catch (

				Exception ex)

		{
			System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
		} finally

		{
			try {
				disconnect();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}

		return false;
	}

	/**
	 * @return ArrayList contenant tout les Articles retournes par la recherche
	 * @param keyword Mot cle entre par l'utilisateur 
	 * @param searchByName Retourne les articles ou le nom correspond
	 * @param searchByBrand Retourne les articles  ou la marque correspond
	 * @param searchByCategory Retourne les articles  ou la categorie correspond
	 */
	protected static List<Article> searchArticles(String keyword, boolean searchByName, boolean searchByBrand, boolean searchByCategory) {
		if (searchByName == false && searchByBrand == false && searchByCategory == false) {
			return null;
		}

		String filter = " WHERE";

		if (searchByName) {
			filter += " name LIKE %" + keyword + "%";
		}
		if (searchByName && searchByBrand) {
			filter += " AND";
		}
		if (searchByBrand) {
			filter += " brand LIKE %" + keyword + "%;";
		}
		if ((searchByName || searchByBrand) && searchByCategory) {
			filter += " AND";
		}
		if (searchByBrand) {
			filter += " category LIKE %" + keyword + "%;";
		}
		filter += ";";

		return getAllArticlesFILTERED(filter);
	}

	/**
	 * @return ArrayList contenant tout les Articles
	 */
	public static List<Article> getAllArticles() {
		return getAllArticlesFILTERED(null);
	}

	/**
	 * @return ArrayList contenant tout les Articles tries
	 * @param column Collone
	 */
	public static List<Article> getAllArticlesSortedBy(String column) {
		return getAllArticlesFILTERED(" SORTED BY " + column);
	}

	/**
	 * @return ArrayList contenant tout les Articles correspondant au filtre
	 * @param filter Filtre ecrit en SQL
	 */
	protected static List<Article> getAllArticlesFILTERED(String filter) {
		ArrayList<Article> articles = new ArrayList<>();
		try {
			connect();

			String query = "SELECT * FROM article";
			if (filter != null) {
				query += filter;
			}
			query += ";";

			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(query);

			while (rs.next()) {
				articles.add(new Article(rs.getInt("reference"), rs.getString("name"), rs.getString("description"), rs.getString("image_url"), rs.getString("brand"), rs.getString("category"), rs.getDouble("price"), rs.getDouble("discount"), rs.getInt("quantity")));
			}
		} catch (Exception ex) {
			System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
		} finally {
			try {
				disconnect();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}

		return articles;
	}

	/**
	 * @return article Article a ajouter
	 */
	public static void addArticle(Article article) {
		try {
			connect();

			Statement statement = connection.createStatement();
			String query = "INSERT INTO brand(name) VALUES (" + article.getBrand() + ");";
			statement.executeUpdate(query);
			
			statement = connection.createStatement();
			query = "INSERT INTO category(name) VALUES (" + article.getCategory() + ");";
			statement.executeUpdate(query);

			statement = connection.createStatement();
			query = "INSERT INTO article(name, description, image_url, brand, category, price, discount, quantity) VALUES (" + article.getName() + ", " + article.getDescription() + ", " + article.getImage_url() + article.getBrand() + ", " + article.getCategory() + ", " + article.getPrice() + article.getDiscount() + ", " + article.getQuantity() + ");";
			statement.executeUpdate(query);
		} catch (	Exception ex) {
			System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
		} finally
		{
			try {
				disconnect();
			} catch (Exception ex) {
				System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
			}
		}
	}
	
	/**
	 * @param reference Reference de l'Article a modifier
	 * @param column Collone a modifier
	 * @param new_value Nouvelle valeur
	 */
	public static void updateArticle(int reference, String column, String new_value) {
		try {
			connect();

			String query = "UPDATE article SET " + column + " = " + new_value + " WHERE reference = " + reference + ";" ;
			Statement statement = connection.createStatement();
			statement.executeQuery(query);
		} catch (

				Exception ex) {
			System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
		} finally

		{
			try {
				disconnect();
			} catch (Exception ex) {
				System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
			}
		}
	}

	/**
	 * @param reference Reference de l'Article a modifier
	 * @param difference Quantite a ajouter ou retirer
	 */
	public static void updateArticleQuantity(int reference, int difference) {
		try {
			connect();

			String query = "SELECT * FROM article WHERE reference=" + reference + ";";
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(query);

			if (rs.next()) {
				updateArticle(reference, "quantity", Integer.valueOf(rs.getInt("quantity") + difference).toString());
			}

		} catch (

				Exception ex) {
			System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
		} finally

		{
			try {
				disconnect();
			} catch (Exception ex) {
				System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
			}
		}
	}
		

	// Brand and Category ########## ########## ########## ########## ########## ########## ########## ########## ########## ########## 


	/**
	 * @param name Nom de la marque
	 */
	public static void addBrand(String name) {
		try {
			connect();

			Statement statement = connection.createStatement();
			String query = "INSERT INTO brand(name) VALUES (" + name + ");";
			statement.executeUpdate(query);
		} catch (	Exception ex) {
			System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
		} finally
		{
			try {
				disconnect();
			} catch (Exception ex) {
				System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
			}
		}
	}
	
	/**
	 * @return ArrayList contenant toutes les marques
	 */
	protected static List<String> getAllBrands() {
		ArrayList<String> brands = new ArrayList<>();
		try {
			connect();

			String query = "SELECT * FROM brand;";

			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(query);

			while (rs.next()) {
				brands.add(rs.getString("name"));
			}
		} catch (Exception ex) {
			System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
		} finally {
			try {
				disconnect();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}

		return brands;
	}

	/**
	 * @param name Nom de la categorie
	 */
	public static void addCategory(String name) {
		try {
			connect();

			Statement statement = connection.createStatement();
			String query = "INSERT INTO category(name) VALUES (" + name + ");";
			statement.executeUpdate(query);
		} catch (	Exception ex) {
			System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
		} finally
		{
			try {
				disconnect();
			} catch (Exception ex) {
				System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
			}
		}
	}
	
	/**
	 * @return ArrayList contenant toutes les categories
	 */
	protected static List<String> getAllCategories() {
		ArrayList<String> categories = new ArrayList<>();
		try {
			connect();

			String query = "SELECT * FROM brand;";

			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(query);

			while (rs.next()) {
				categories.add(rs.getString("name"));
			}
		} catch (Exception ex) {
			System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
		} finally {
			try {
				disconnect();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}

		return categories;
	}
	

	// Order ########## ########## ########## ########## ########## ########## ########## ########## ########## ########## 

	
	/**
	 * @return Order correspondant a l'ID, null si non trouve
	 */
	public static Order getOrder(int id) {
		try {
			connect();

			Map<Integer, Integer> references_quantity = new HashMap<Integer, Integer>();

			String query = "SELECT * FROM xline WHERE id=" + id + ";";
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(query);

			while (rs.next()) {
				references_quantity.put(rs.getInt("reference"), rs.getInt("quantity"));
			}

			query = "SELECT * FROM order WHERE id=" + id + ";";

			statement = connection.createStatement();
			rs = statement.executeQuery(query);
			if (rs.next()) {
				return new Order(rs.getInt("id"), rs.getInt("client"), rs.getString("recipient"), rs.getString("address"), rs.getInt("status"), rs.getDate("xdate"), references_quantity);
			}

		} catch (

				Exception ex) {
			System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
		} finally

		{
			try {
				disconnect();
			} catch (Exception ex) {
				System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
			}
		}
		return null;
	}

	/**
	 * @param Order Commande a ajouter
	 */
	public static void addOrder(Order order) {
		try {
			connect();

			String query = "INSERT INTO xorder(person, recipient, address, status, xdate) VALUES (" + order.getPerson() + ", " + order.getRecipient() + ", " + order.getAddress() + ", " + order.getStatus()  + ", " + order.getDate() + ");";
			Statement statement = connection.createStatement();
			statement.executeUpdate(query);				

			query = "SELECT * FROM xorder WHERE id=(SELECT MAX(id) FROM xorder;);";
			ResultSet rs = statement.executeQuery(query);

			int id = 0;

			if (rs.next()) {
				id = rs.getInt("id");
			}

			for (int reference : order.getReferencesQuantity().keySet()){
				int quantity = order.getReferencesQuantity().get(reference) ;
				query = "INSERT INTO xline(id, reference, quantity) VALUES (" + id + ", " + reference + ", " + quantity + ");";
				statement.executeUpdate(query);				
				updateArticleQuantity(reference, quantity * -1);
			}
		} catch (	Exception ex) {
			System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
		} finally
		{
			try {
				disconnect();
			} catch (Exception ex) {
				System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
			}
		}
	}

	/**
	 * @param id ID de l'Order a modifier
	 * @param column Collone a modifier
	 * @param new_value Nouvelle valeur
	 */
	public static void updateOrder(int id, String column, String new_value) {
		try {
			connect();

			String query = "UPDATE xorder SET " + column + " = " + new_value + " WHERE id = " + id + ";" ;
			Statement statement = connection.createStatement();
			statement.executeQuery(query);	
		} catch (	Exception ex) {
			System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
		} finally
		{
			try {
				disconnect();
			} catch (Exception ex) {
				System.out.println("<h1>Oups ! (" + ex.getMessage() + ")</h1>");
			}
		}
	}
}
