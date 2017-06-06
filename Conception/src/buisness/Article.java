package buisness;

public class Article {
	int reference;
	String name;
	String description;
	String image_url;
	String brand;
	String category;
	double price;
	double discount;

	public Article(String n, String d, String i, String b, String c, double p) {
		this.reference = (int) (Math.random() * 1000000);
		this.name = n;
		this.description = d;
		this.image_url = i;
		this.brand = b;
		this.category = c;
		this.price = p;
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
}
