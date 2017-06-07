package metier;
import java.util.*;
import java.sql.*;

public class Panier{
	
	private Map<String,Integer> produits ;
	private Map<String,String> lib;
	private Map<String,Double> price; 
	private int nbArticle=0;


	public Panier(){
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

			String query = "select lib,prix,reference from article";
			ResultSet rs = stmt.executeQuery(query);
			
			while(rs.next()){
				lib.put(rs.getString("reference"),rs.getString("produit"));
				price.put(rs.getString("reference"),rs.getDouble("prix"));
				nbArticle++;
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
				String query = "INSERT INTO facture(nopanier,qte,idclient,reference) VALUES ";
				query+="("+Integer.parseInt(key)+","+produits.get(key)+");";

				stmt.executeUpdate(query);
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



