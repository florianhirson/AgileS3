package business;

public class Admin extends Person {

	public Admin(String first_name, String last_name, String mail, String password, String default_adress,
			String phone) {
		super(first_name, last_name, mail, password, default_adress, phone, true);
	}
}
