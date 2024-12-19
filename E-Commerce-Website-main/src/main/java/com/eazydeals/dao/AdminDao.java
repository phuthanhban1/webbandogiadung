package com.eazydeals.dao;

import java.util.List;

import com.eazydeals.entities.Admin;

public interface AdminDao {
	public boolean saveAdmin(Admin admin);
	public Admin getAdminByEmailPassword(String email, String password);
	public List<Admin> getAllAdmin();
	public boolean deleteAdmin(int id);
}
