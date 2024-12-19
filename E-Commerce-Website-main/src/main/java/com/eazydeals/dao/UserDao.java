package com.eazydeals.dao;

import java.util.List;

import com.eazydeals.entities.User;

public interface UserDao {
	public boolean saveUser(User user);
	public User getUserByEmailPassword(String userEmail, String userPassword);
	public User getUserByEmail(String userEmail);
	public List<User> getAllUser();
	public void updateUserAddresss(User user);
	public boolean updateUserPasswordByEmail(String password, String mail);
	public void updateUser(User user);
	public int userCount();
	public String getUserAddress(int uid);
	public String getUserName(int uid);
	public String getUserEmail(int uid);
	public String getUserPhone(int uid);
	public void deleteUser(int uid);
	public List<String> getAllEmail();
	
	
}
