package com.eazydeals.dao;

import java.util.List;

import com.eazydeals.entities.Admin;
import com.eazydeals.entities.Wishlist;

public interface WishlistDao {
	public boolean addToWishlist(Wishlist w);
	public boolean getWishlist(int uid, int pid);
	public List<Wishlist> getListByUserId(int uid);
	public void deleteWishlist(int uid, int pid);
	
	
}
