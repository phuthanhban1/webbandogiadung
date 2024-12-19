package com.eazydeals.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.eazydeals.entities.Admin;
import com.eazydeals.helper.ConnectionPool;
import com.eazydeals.helper.ConnectionPoolImpl;

public class AdminDaoImpl implements AdminDao {
	private Connection con;
	private ConnectionPool cp;
	
	public AdminDaoImpl(ConnectionPool cp) {
		if (cp == null) {
			this.cp = new ConnectionPoolImpl();
		} else {
			this.cp = cp;
		}

		// Xin kết nối
		try {
			this.con = this.cp.getConnection("User");

			// Kiểm tra và chấm dứt chế độ thực thi tự động của kết nối
			if (this.con.getAutoCommit()) {
				this.con.setAutoCommit(false);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private boolean exe(PreparedStatement pre) {
		// pre đã đượcc biên dịch và truyền đầy đủ giá trị cho các tham số
		if (pre != null) {
			try {
				int results = pre.executeUpdate();

				if (results == 0) {
					this.con.rollback();
					return false;
				}

				// Xác nhận thực thi sau cùng
				this.con.commit();
				return true;

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				try {
					this.con.rollback();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			} finally {
				pre = null;
			}
		}
		return false;
	}
	@Override
	public boolean saveAdmin(Admin admin) {
		// TODO Auto-generated method stub
		boolean flag = false;

		try {
			String query = "insert into admin(name, email, password, phone) values(?, ?, ?, ?)";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, admin.getName());
			psmt.setString(2, admin.getEmail());
			psmt.setString(3, admin.getPassword());
			psmt.setString(4, admin.getPhone());

			flag = exe(psmt);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public Admin getAdminByEmailPassword(String email, String password) {
		// TODO Auto-generated method stub
		Admin admin = null;
		try {
			String query = "select * from admin where email = ? and password = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, email);
			psmt.setString(2, password);

			ResultSet set = psmt.executeQuery();
			while (set.next()) {
				admin = new Admin();
				admin.setId(set.getInt("id"));
				admin.setName(set.getString("name"));
				admin.setEmail(set.getString("email"));
				admin.setPassword(set.getString("password"));
				admin.setPhone(set.getString("phone"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return admin;
	}

	@Override
	public List<Admin> getAllAdmin() {
		// TODO Auto-generated method stub
		List<Admin> list = new ArrayList<Admin>();
		try {
			
			String query = "select * from admin";
			PreparedStatement statement = this.con.prepareStatement(query);
			ResultSet rs = statement.executeQuery(query);
			while (rs.next()) {
				Admin admin = new Admin();
				admin.setId(rs.getInt("id"));
				admin.setName(rs.getString("name"));
				admin.setEmail(rs.getString("email"));
				admin.setPhone(rs.getString("phone"));
				admin.setPassword(rs.getString("password"));
				
				list.add(admin);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public boolean deleteAdmin(int id) {
		// TODO Auto-generated method stub
		boolean flag = false;
		try {
			String query = "delete from admin where id = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, id);
			flag = exe(psmt);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

}
