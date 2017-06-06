package hendek.article;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

public class Article {

		private HashMap<Integer,String> desc;
		private HashMap<Integer,String> lib;
		private HashMap<Integer,Double> prix;
		private HashMap<Integer,String> img;
		private HashMap<Integer,String> vendeur;
		private int nbArticle=0;
		
		
		public Article(){
			prix = new HashMap<>();
			desc = new HashMap<>();
			lib = new HashMap<>();
			img = new HashMap<>();
			vendeur = new HashMap<>();
			
			Connection con=null;
			
			try{

			    Class.forName("org.postgresql.Driver");
				String url = "jdbc:postgresql://psqlserv/n2p1";
				String nom = "barbetf";
				String mdp = "moi";
				con = DriverManager.getConnection(url,nom,mdp);

				Statement stmt = con.createStatement();
				stmt = con.createStatement();

				String query = "select * from article";
				ResultSet rs = stmt.executeQuery(query);
				
				while(rs.next()){
					desc.put(rs.getInt("idart"),rs.getString("description"));
					lib.put(rs.getInt("idart"),rs.getString("libelle"));
					prix.put(rs.getInt("idart"),rs.getDouble("prix"));
					img.put(rs.getInt("idart"),rs.getString("image"));
					nbArticle++;
				}
				
				rs=stmt.executeQuery("select * from infoart");
				while(rs.next())
					vendeur.put(rs.getInt("idart"), rs.getString("entreprise"));
				
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
		
		public String toString(){
			String ret="Nombre d'articles : "+nbArticle+"\n--->\n";
			
			for(int key:lib.keySet()){
				
				ret+="Article "+key+" :\n";
				ret+=lib.get(key)+"\nprix : "+prix.get(key)+" €\n";
				ret+="Description : "+desc.get(key)+"\nVendu par : "+vendeur.get(key);
				ret+="\nAperçu : "+img.get(key)+" ";
				ret+="\n------------------------------------------\n";
			}
			
			
			return ret;
			
		}
		
		public String getVendeur(int id){
			for(Integer key:vendeur.keySet())
				if(key==id)
					return vendeur.get(key);
			return null;
		}
		
		public String getImage(int id){
			for(Integer key:img.keySet())
				if(key==id)
					return img.get(key);
			return null;
		}
		
		public Double getPrix(int id){
			for(Integer key:prix.keySet())
				if(key==id)
					return prix.get(key);
			return null;
		}
		
		public String getLibelle(int id){
			for(Integer key:lib.keySet())
				if(key==id)
					return lib.get(key);
			return null;
		}
		
		public String getDescription(int id){
			for(Integer key:desc.keySet())
				if(key==id)
					return desc.get(key);
			return null;
		}
		
		public int getNbArticle(){
			return nbArticle;
		}
		
		public Map<Integer,String> getAllVendeur(){
			return vendeur;
		}
		
		public Map<Integer,String> getAllImage(){
			return img;
		}
		
		public Map<Integer,Double> getAllPrix(){
			return prix;
		}
		
		public Map<Integer,String> getAllDescription(){
			return desc;
		}
		
		public Map<Integer,String> getAllLibelle(){
			return lib;
		}
		
		
}
