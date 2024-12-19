package com.eazydeals.entities;

import java.sql.Array;

public class Admin {
	private int id;
	private String name;
	private String email;
	private String phone;
	private String password;
	
	public Admin() {
		super();
	}

	public Admin(String name, String email, String phone, String password) {
		super();
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.password = password;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public void setPassword(String password) {
		this.password = password;
	}
	public static void main(String[] args) {
		int a[] = {10, 41, 35, 51, 49, 62, 69, 91, 148, 10, 56, 12}; 
		System.out.println(a);
	}
	
}
