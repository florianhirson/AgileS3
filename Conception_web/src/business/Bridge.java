package business;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class Bridge {
	private static Connection connection = null;

	private static void connect() throws Exception {
		Class.forName("org.postgresql.Driver");
		String url = "jdbc:postgresql://psqlserv/n2p1";
		String nom = "barbetf";
		String mdp = "moi";
		connection = DriverManager.getConnection(url, nom, mdp);
	}

	private static void disconnect() throws Exception {
		connection.close();
	}

	public static ArrayList<Article> getArticles(int... references) {
		ArrayList<Article> articles = new ArrayList<>();
		try {
			connect();

			String query = "SELECT * FROM article;";
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(query);
			while (rs.next()) {
				for (int i = 0; i < references.length; i++) {
					if (rs.getInt("reference") == references[i]) {
						articles.add(new Article(rs.getString("name"), rs.getString("description"),
								rs.getString("image_url"), rs.getString("brand"), rs.getString("category"),
								rs.getDouble("price"), rs.getInt("quantity")));
					}
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

		return articles;
	}

	public static ArrayList<Article> searchArticles(String keyword, boolean searchByName, boolean searchByBrand,
			boolean searchByCategory) {
		ArrayList<Article> articles = new ArrayList<>();
		try {
			connect();

			if (searchByName == false && searchByBrand == false && searchByCategory == false) {
				return null;
			}

			String query = "SELECT * FROM article WHERE";

			if (searchByName) {
				query += " name LIKE '%" + keyword + "%'";
			}

			if (searchByName && searchByBrand) {
				query += " AND";
			}

			if (searchByBrand) {
				query += " brand LIKE '%" + keyword + "%';";
			}

			if ((searchByName || searchByBrand) && searchByCategory) {
				query += " AND";
			}

			if (searchByBrand) {
				query += " category LIKE '%" + keyword + "%';";
			}

			query += ";";

			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(query);
			while (rs.next()) {
				articles.add(new Article(rs.getString("name"), rs.getString("description"), rs.getString("image_url"),
						rs.getString("brand"), rs.getString("category"), rs.getDouble("price"), rs.getInt("quantity")));
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

	protected static Person getPerson(int id) {
		try {
			connect();

			String query = "SELECT * FROM person WHERE id='" + id + "';";

			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(query);
			if (rs.getFetchSize() == 1) {
				rs.next();
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
		} catch (

		Exception ex)

		{
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

	public static Person getPerson(String mail, String password) {
		try {
			connect();

			String query = "SELECT * FROM person WHERE mail='" + mail + "';";

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
		} catch (

		Exception ex)

		{
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

	public static Order getOrder(int id) {
		try {
			connect();

			Map<Integer, Integer> references_quantity = new HashMap<Integer, Integer>();

			String query = "SELECT * FROM xline WHERE id='" + id + "';";
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(query);
			while (rs.next()) {
				references_quantity.put(rs.getInt("reference"), rs.getInt("quantity"));
			}

			query = "SELECT * FROM order WHERE id='" + id + "';";

			statement = connection.createStatement();
			rs = statement.executeQuery(query);
			if (rs.getFetchSize() == 1) {
				rs.next();
				return new Order(rs.getInt("id"), rs.getInt("client"), rs.getString("address"),
						rs.getString("recipient"), rs.getInt("status"), rs.getDate("xdate"), references_quantity);
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
}
