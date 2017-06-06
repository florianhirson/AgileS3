package user;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class User {

	private String login,password,nom,prenom,mail;
	private int droit;
	private Scanner sc=new Scanner(System.in);
	
	private Map<String,String> log = new HashMap<>();
	
	
	public User(){
		boolean check=false;
		log.put("Faunus","123456");
		log.put("Nain","789");
		log.put("admin","helloworld");
		while(check){
			System.out.println("Login :");
			login=sc.nextLine();
		
			for(String key:log.keySet()){
				if(login.equals(key)){
					check=true;
				}
			}
		}
		
		check=false;
		while(check){
			System.out.print("Mot de passe : ");
			password=sc.nextLine();
			if(log.get(login).equals(password)){
				check=true;
			}
		}
	}
	
	public 
	
}
