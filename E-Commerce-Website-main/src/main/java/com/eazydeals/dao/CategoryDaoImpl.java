package com.eazydeals.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.eazydeals.entities.Category;
import com.eazydeals.helper.ConnectionPool;
import com.eazydeals.helper.ConnectionPoolImpl;

public class CategoryDaoImpl implements CategoryDao {
	private Connection con;
	private ConnectionPool cp;
	
	public CategoryDaoImpl(ConnectionPool cp) {
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
	public boolean saveCategory(Category category) {
		boolean flag = false;

		try {
			String query = "insert into category(name, image) values(?, ?)";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, category.getCategoryName());
			psmt.setString(2, category.getCategoryImage());

			flag = exe(psmt);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public List<Category> getAllCategories() {

		List<Category> list = new ArrayList<>();
		try {

			String query = "select * from category";
			PreparedStatement statement = this.con.prepareStatement(query);

			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				Category category = new Category();
				category.setCategoryId(rs.getInt("cid"));
				category.setCategoryName(rs.getString("name"));
				category.setCategoryImage(rs.getString("image"));

				list.add(category);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public Category getCategoryById(int cid) {
		Category category = new Category();
		try {
			String query = "select * from category where cid = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, cid);
			ResultSet rs = psmt.executeQuery();
			while (rs.next()) {
				category.setCategoryId(rs.getInt("cid"));
				category.setCategoryName(rs.getString("name"));
				category.setCategoryImage(rs.getString("image"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return category;
	}

	@Override
	public String getCategoryName(int catId) {
		String category = "";
		try {
			String query = "select * from category where cid = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, catId);
			ResultSet rs = psmt.executeQuery();
			while (rs.next()) {
				category = rs.getString("name");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return category;
	}
	
	@Override
	public void updateCategory(Category cat) {
		try {
			String query = "update category set name=?, image=? where cid=?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, cat.getCategoryName());
			psmt.setString(2, cat.getCategoryImage());
			psmt.setInt(3, cat.getCategoryId());
			
			exe(psmt);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void deleteCategory(int cid) {
		try {
			String query = "delete from category where cid = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, cid);
			
			exe(psmt);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int categoryCount() {
		int count = 0;
		try {
			String query = "select count(*) from category";
			PreparedStatement stmt = con.prepareStatement(query);
			ResultSet rs = stmt.executeQuery();
			rs.next();
			count = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

}
