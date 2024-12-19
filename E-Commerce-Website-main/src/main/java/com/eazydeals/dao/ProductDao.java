package com.eazydeals.dao;

import java.util.List;

import com.eazydeals.entities.Product;

public interface ProductDao {
	public boolean saveProduct(Product product);
	public List<Product> getAllProducts();
	public List<Product> getAllLatestProducts();
	public Product getProductsByProductId(int pid);
	public List<Product> getAllProductsByCategoryId(int catId);
	public List<Product> getAllProductsBySearchKey(String search);
	public void updateProduct(Product product);
	public void updateQuantity(int id, int qty);
	public void deleteProduct(int pid);
	public int productCount();
	public int getProductPriceById(int pid);
	public int getProductQuantityById(int pid);
	
}
