package com.eazydeals.entities;

import java.text.NumberFormat;
import java.util.Locale;

public class Product {

	private int productId;
	private String productName;
	private String productDescription;
	private int productPrice;
	private int productQuantity;
	private String productImages;
	private int categoryId;

	public Product() {
		super();
	}

	public Product(int productId, String productName, String productDescription, int productPrice,
			int productQuantity, String productImages, int categoryId) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.productDescription = productDescription;
		this.productPrice = productPrice;
		this.productQuantity = productQuantity;
		this.productImages = productImages;
		this.categoryId = categoryId;
	}

	public Product(String productName, String productDescription, int productPrice,
			int productQunatity, String productImages) {
		super();
		this.productName = productName;
		this.productDescription = productDescription;
		this.productPrice = productPrice;
		this.productQuantity = productQunatity;
		this.productImages = productImages;
	}

	public Product(String productName, String productDescription, int productPrice,
			int productQunatity, String productImages, int categoryId) {
		super();
		this.productName = productName;
		this.productDescription = productDescription;
		this.productPrice = productPrice;
		this.productQuantity = productQunatity;
		this.productImages = productImages;
		this.categoryId = categoryId;
	}

	public Product(int productId, String productName, int productPrice, int productQunatity) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.productPrice = productPrice;
		this.productQuantity = productQunatity;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductDescription() {
		return productDescription;
	}

	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}

	public int getProductPrice() {
		return productPrice;
	}
	
	public String getProductPriceFormat() {
		NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
		return format.format(productPrice);
	}
	public static String formatMoney(int a) {
		NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
		return format.format(a);
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public int getProductQuantity() {
		return productQuantity;
	}

	public void setProductQunatity(int productQunatity) {
		if(productQunatity < 0) {
			throw new IllegalArgumentException("Số lượng sản phẩm không được nhỏ hơn 0.");
		} else {
			this.productQuantity = productQunatity;
		}
		
	}

	public String getProductImages() {
		return productImages;
	}

	public void setProductImages(String productImages) {
		this.productImages = productImages;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	// calculate price of product by applying discount
//    public int getProductPriceAfterDiscount(){
//        int discount = (int) ((this.getProductDiscount()/100.0) * this.getProductPrice());
//        return (int) (this.getProductPrice() - discount);
//    }

	@Override
	public String toString() {
		return "Product [productId=" + productId + ", productName=" + productName + ", productDescription="
				+ productDescription + ", productPrice=" + productPrice + ", productQunatity=" + productQuantity
				+ ", productImages=" + productImages + ", categoryId=" + categoryId + "]";
	}

}
