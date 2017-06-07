package hendek;
import hendek.achat.Panier;
import hendek.article.Article;
import hendek.utilisateur.User;

public class Main {

	public static void main(String args[]){
		Article article = Article.getInstance();
		
		System.out.println(article);
		
		User utilisateurs = User.getInstance();
		
		System.out.println(utilisateurs.toString4console());
		
		Panier myPan = new Panier("Faunus","123456");
		
		//myPan.addPanier(1, 10);
		
	}
}