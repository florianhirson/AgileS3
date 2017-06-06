package business;

public class Article {
	int reference;
	String name;
	String description;
	String image_url;
	String brand;
	
	String category;
	double price;
	double discount;

	public Article(String name, String description, String image_url, String brand, String category, double price) {
		this.reference = (int) (Math.random() * 1000000); // Remplacer par getNewReference() dans Bridge...
		this.name = name;
		this.description = description;
		this.image_url = image_url;
		this.brand = brand;
		this.category = category;
		this.price = price;
		this.discount = 0.0;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImage_url() {
		return image_url;
	}

	public void setImage_url(String image_url) {
		this.image_url = image_url;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getDiscount() {
		return discount;
	}

	public void setDiscount(double discount) {
		if (discount > 0 && discount < 1)
		this.discount = discount;
	}

	public int getReference() {
		return reference;
	}

	public String getName() {
		return name;
	}

	public String getBrand() {
		return brand;
	}

	public String toString() {
		String temp = "reference: " + this.reference;
		temp += "\nname: " + this.name;
		temp += "\ndescription: " + this.description;
		temp += "\nimage_url: " + this.image_url;
		temp += "\nbrand" + this.brand;
		temp += "\ncategory: " + this.category;
		temp += "\nprice: " + this.price;
		temp += "\ndiscount: " + this.discount;
		return temp;
	}
}
