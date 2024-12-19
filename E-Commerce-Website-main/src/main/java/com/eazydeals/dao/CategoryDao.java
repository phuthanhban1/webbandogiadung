package com.eazydeals.dao;

import java.util.List;

import com.eazydeals.entities.Category;

public interface CategoryDao {
	public boolean saveCategory(Category category);
	public List<Category> getAllCategories();
	public Category getCategoryById(int cid);
	public String getCategoryName(int catId);
	public void updateCategory(Category cat);
	public void deleteCategory(int cid);
	public int categoryCount();
}
