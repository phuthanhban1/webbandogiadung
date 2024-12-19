package com.eazydeals.dao;

import java.util.List;

import com.eazydeals.entities.Cart;

public interface CartDao {
	public boolean addToCart(Cart cart);
	public List<Cart> getCartListByUserId(int uid);
	public int getQuantity(int uid, int pid);
	public int getQuantityById(int id);
	public void updateQuantity(int id, int qty);
	public void removeProduct(int cid);
	public void removeAllProduct();
	public int getIdByUserIdAndProductId(int uid, int pid);
	public int getCartCountByUserId(int uid);
	public int getProductId(int cid);
	
}
