package business;

import java.util.HashMap;
import java.util.Map;

public class Cart {

	Map<Integer, Article> cartMap;
			
	public Cart(){
		cartMap = new HashMap<Integer, Article>();
	}
	
	public double getTotalPrice(){
		double total = 0.0;
		for(Article a : cartMap.values()){
			total =+ a.getPrice();
		}
		return total;
	}
	
	public boolean Remove(int ref){
		for(Article a : cartMap.values()){
			if(a.getReference()==ref){
				cartMap.remove(ref);
				return true;
			}
		}
		return false;
	}
}
