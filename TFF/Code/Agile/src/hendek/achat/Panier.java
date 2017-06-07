package hendek.achat;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

import hendek.article.Article;
import hendek.utilisateur.Me;
import hendek.utilisateur.User;

public class Panier {


	private Map<String,Integer> produits ;
	private Map<String,String> lib;
	private Map<String,Double> price; 
	private int nbArticle=0;
	private Me myAccount;

	public Panier(String login,String password){
		myAccount=User.getInstance().signIn(login, password);
		produits=new HashMap<>();
		lib=new HashMap<>();
		price= new HashMap<>();
		Connection con = null;

		try{

		    Class.forName("org.postgresql.Driver");
			String url = "jdbc:postgresql://psqlserv/n2p1";
			String nom = "barbetf";
			String mdp = "moi";
			con = DriverManager.getConnection(url,nom,mdp);

			Statement stmt = con.createStatement();
			stmt = con.createStatement();

			String query = "select libelle,prix,idart from article";
			ResultSet rs = stmt.executeQuery(query);
			
			while(rs.next()){
				lib.put(rs.getString("idart"),rs.getString("libelle"));
				price.put(rs.getString("idart"),rs.getDouble("prix"));
				nbArticle++;
			}
			
		}catch (Exception e) {
			System.out.println("[ERROR]pan "+e.getMessage()+"");
		}finally{	  
			try{
				con.close();
			}catch(Exception e){
				System.out.println("[ERROR]closep"+e.getMessage()+"");
			}
		}


	}

	public void addPanier(String id,int count){
		produits.put(id,count);

	}

	public Integer getCount(String id){
		return produits.get(id);
	}

	public Integer getLib(String id){
		return produits.get(id);
	}
	
	public double calculPrix(){
			double prixTT=0;
			for(String id : produits.keySet()){
							if(produits.get(id)!=null&&price.get(id)!=null)
					prixTT+=price.get(id)*produits.get(id);		
						
			}
		if(prixTT>=0){
		return (double) Math.round(prixTT * 100) / 100 ;
		}else{
		return 0;
		}
	}


	public int getNbArticle(){
		return nbArticle;
	}


	public void sauver(){
		Connection con=null;
		try{

		    Class.forName("org.postgresql.Driver");
			String url = "jdbc:postgresql://psqlserv/n2p1";
			String nom = "barbetf";
			String mdp = "moi";
			con = DriverManager.getConnection(url,nom,mdp);

			Statement stmt = con.createStatement();
			stmt = con.createStatement();

			for(String key:produits.keySet()){
				String query = "INSERT INTO lignefact(login,idart,qte) VALUES ";
				query+="("+myAccount.getLogin()+","+Integer.parseInt(key)+","+produits.get(key)+");";

				stmt.executeUpdate(query);
				
				Article.getInstance().setStock(Integer.parseInt(key),Article.getInstance().getStock(Integer.parseInt(key))-produits.get(key));
			}
			
			
			
		}catch (Exception e) {
			System.out.println("[ERROR]"+e.getMessage()+"");
		}finally{	  
			try{
				con.close();
			}catch(Exception e){
				System.out.println("[ERROR]"+e.getMessage()+"");
			}
		}

	}

	public String toString(){//c'est le toHTML()

		String ret="";

		for(String id : produits.keySet()){
			ret+= "<tr><td>"+lib.get(id)+"</td><td>"+produits.get(id)+"</td></tr>";

	
						
		}

		ret+="<tr><td>Votre facture est de :</td><td>"+this.calculPrix()+" €</td></tr>";
		return ret;
	}

	
}