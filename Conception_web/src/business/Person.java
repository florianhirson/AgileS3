package business;

public class Person {
	private final int id;
	private final String first_name;
	private final String last_name;
	private String mail;
	private String phone;
	private String password;
	private Boolean admin;

	public Person(String first_name, String last_name, String mail, String phone, String password, Boolean admin) {
		this.id = (int) (Math.random() * 1000000); // Remplacer par
													// getNewReference() dans
													// Bridge...
		this.first_name = first_name;
		this.last_name = last_name;
		this.mail = mail;
		this.phone = phone;
		this.password = password;
		this.admin = admin;
	}

	public String getFirst_name() {
		return first_name;
	}

	public String getLast_name() {
		return last_name;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String old_password, String new_password) throws Exception {
		if (this.password.equals(old_password)) {
			this.password = new_password;
		} else {
			throw new Exception("Mot de passe incorrect !");
		}
	}

	public int getId() {
		return id;
	}

	public Boolean getAdmin() {
		return admin;
	}

	public void setAdmin(Boolean admin) {
		this.admin = admin;
	}
}
