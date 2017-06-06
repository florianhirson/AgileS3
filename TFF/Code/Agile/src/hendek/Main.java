package hendek;
import hendek.article.Article;
import hendek.utilisateur.User;

public class Main {

	public static void main(String args[]){
		Article article = Article.getInstance();
		
		System.out.println(article);
		
		User utilisateurs = User.getInstance();
		
		System.out.println(utilisateurs.toString4console());
		
	}
}
