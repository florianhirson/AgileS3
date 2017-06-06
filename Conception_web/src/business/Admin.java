package business;

public class Admin extends Person {

	public Admin(String first_name, String last_name, String mail, String phone, String password) {
		super(first_name, last_name, mail, phone, password, true);
	}
}
