package business;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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
	public static ArrayList<Article> getArticles(int... ref) {
		ArrayList<Article> want = new ArrayList<>();
		Connection con=null;
		try{

			Class.forName("org.postgresql.Driver");
			String url = "jdbc:postgresql://psqlserv/n2p1";
			String nom = "barbetf";
			String mdp = "moi"; 
			con = DriverManager.getConnection(url,nom,mdp);
			String tmp = "";

			String requete = "select *  from article";

			Statement stmt = con.createStatement();
			stmt = con.createStatement();

			ResultSet rs = stmt.executeQuery(requete);
			while (rs.next())       {
				for(int i=0;i<ref.length;i++)
				if(rs.getInt("reference") == ref[i]){
					want.add(new Article(rs.getString("produit"), rs.getString("lib"), rs.getString("image"), rs.getString("marque"), rs.getString("reference"), rs.getDouble("prix")));
				}
			}


		}
		catch (Exception e) {
			System.out.println("<h1>Oups ! (" + e.getMessage() + ")</h1>");
		}
		finally {	  
			try{
				con.close();	  
			}catch (Exception e) {
				System.out.println("<h1>Oups ! (" + e.getMessage() + ")</h1>");
			}
		}
		
		return want;
	}

	public static ArrayList<Article> getAllArticles() {
		ArrayList<Article> want = new ArrayList<>();
		Connection con=null;
		try{

			Class.forName("org.postgresql.Driver");
			String url = "jdbc:postgresql://psqlserv/n2p1";
			String nom = "barbetf";
			String mdp = "moi"; 
			con = DriverManager.getConnection(url,nom,mdp);
			String tmp = "";

			String requete = "select *  from article";

			Statement stmt = con.createStatement();
			stmt = con.createStatement();

			ResultSet rs = stmt.executeQuery(requete);
			while (rs.next())       {
				want.add(new Article(rs.getString("produit"), rs.getString("lib"), rs.getString("image"), rs.getString("marque"), rs.getString("reference"), rs.getDouble("prix")));
			}


		}
		catch (Exception e) {
			System.out.println("<h1>Oups ! (" + e.getMessage() + ")</h1>");
		}
		finally {	  
			try{
				con.close();	  
			}catch (Exception e) {
				System.out.println("<h1>Oups ! (" + e.getMessage() + ")</h1>");
			}
		}
		
		return want;
	}

	/**
	 * Transforme un client de la bdd en objet Client
	 * 
	 * @param ID
	 * @return un objet Client
	 */
	public static Client getClient(int ID) {
		Client my=null;
		Connection con=null;
		
		try{

			Class.forName("org.postgresql.Driver");
			String url = "jdbc:postgresql://psqlserv/n2p1";
			String nom = "barbetf";
			String mdp = "moi"; 
			con = DriverManager.getConnection(url,nom,mdp);
			String tmp = "";

			String requete = "select *  from personne";

			Statement stmt = con.createStatement();
			stmt = con.createStatement();

			ResultSet rs = stmt.executeQuery(requete);
			while(rs.next()){
				if(rs.getInt("idpersonne") == ID)
					my = new Client(rs.getString("nom"), rs.getString("prenom"), rs.getString("mail"), "null", rs.getString("mdp"), rs.getString("phone"));
			}


		}
		catch (Exception e) {
			System.out.println("<h1>Oups ! (" + e.getMessage() + ")</h1>");
		}
		finally {	  
			try{
				con.close();	  
			}catch (Exception e) {
				System.out.println("<h1>Oups ! (" + e.getMessage() + ")</h1>");
			}
		}
		
		return my;
	}

	/**
	 * Transforme un client de la bdd en objet Admin
	 * 
	 * @param ID
	 * @return un objet Admin
	 */
	public static Admin getAdmin(int ID) {
		
		Admin my = null;
		Connection con=null;
		try{

			Class.forName("org.postgresql.Driver");
			String url = "jdbc:postgresql://psqlserv/n2p1";
			String nom = "barbetf";
			String mdp = "moi"; 
			con = DriverManager.getConnection(url,nom,mdp);
			String tmp = "";

			String requete = "select *  from personne";

			Statement stmt = con.createStatement();
			stmt = con.createStatement();

			ResultSet rs = stmt.executeQuery(requete);
			while(rs.next()){
				if(rs.getInt("idpersonne") == ID)
					my=new Admin(rs.getString("nom"), rs.getString("prenom"), rs.getString("mail"), "null", rs.getString("mdp"), rs.getString("phone"));
			}


		}
		catch (Exception e) {
			System.out.println("<h1>Oups ! (" + e.getMessage() + ")</h1>");
		}
		finally {	  
			try{
				con.close();	  
			}catch (Exception e) {
				System.out.println("<h1>Oups ! (" + e.getMessage() + ")</h1>");
			}
		}
		
		return my;
		
		
		
	}

	/**
	 * Transforme une commande de la bdd en objet Order
	 * 
	 * @param ID
	 * @return un objet Order
	 */
	public static Order getOrder(int ID) {
		Order my = null;
		Map<Integer, Integer> ref_qte=new HashMap<>();
		Connection con=null;
		
		String receveur = null,ref = null;
		Integer nop = null;
		int idclient = 0,status = 0;
		
		
		try{

			Class.forName("org.postgresql.Driver");
			String url = "jdbc:postgresql://psqlserv/n2p1";
			String nom = "barbetf";
			String mdp = "moi"; 
			con = DriverManager.getConnection(url,nom,mdp);
			String tmp = "";

			String requete = "select *  from facture";

			Statement stmt = con.createStatement();
			stmt = con.createStatement();

			ResultSet rs = stmt.executeQuery(requete);
			
			
			
			while(rs.next()){
				if(rs.getInt("nopanier") == ID){
					ref_qte.put(rs.getInt("reference"), rs.getInt("qte"));
					nop = rs.getInt("nopanier");
					idclient=rs.getInt("idclient"); receveur=rs.getString("receveur"); ref=rs.getString("reference");
					status=rs.getInt("status");
					
				}
			}
			my=new Order(nop,idclient, receveur, ref, status,ref_qte);

		}
		catch (Exception e) {
			System.out.println("<h1>Oups ! (" + e.getMessage() + ")</h1>");
		}
		finally {	  
			try{
				con.close();	  
			}catch (Exception e) {
				System.out.println("<h1>Oups ! (" + e.getMessage() + ")</h1>");
			}
		}
		return my;
	}

}
