package com.eazydeals.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.eazydeals.entities.Product;
import com.eazydeals.helper.ConnectionPool;
import com.eazydeals.helper.ConnectionPoolImpl;

public class ProductDaoImpl implements ProductDao {
	private Connection con;
	private ConnectionPool cp;
	
	public ProductDaoImpl(ConnectionPool cp) {
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
	public boolean saveProduct(Product product) {
		boolean flag = false;
		try {
			String query = "insert into product(name, description, price, quantity, image, cid) values(?, ?, ?, ?, ?, ?)";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, product.getProductName());
			psmt.setString(2, product.getProductDescription());
			psmt.setInt(3, product.getProductPrice());
			psmt.setInt(4, product.getProductQuantity());
			psmt.setString(5, product.getProductImages());
			psmt.setInt(6, product.getCategoryId());

			flag = exe(psmt);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}

	@Override
	public List<Product> getAllProducts() {
		List<Product> list = new ArrayList<Product>();
		try {
			String query = "select * from product";
			PreparedStatement statement = this.con.prepareStatement(query);

			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				Product product = new Product();
				product.setProductId(rs.getInt("pid"));
				product.setProductName(rs.getString("name"));
				product.setProductDescription(rs.getString("description"));
				product.setProductPrice(rs.getInt("price"));
				product.setProductQunatity(rs.getInt("quantity"));
				product.setProductImages(rs.getString("image"));
				product.setCategoryId(rs.getInt("cid"));

				list.add(product);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Product> getAllLatestProducts() {
		List<Product> list = new ArrayList<Product>();
		try {
			String query = "select * from product order by pid desc";
			PreparedStatement statement = this.con.prepareStatement(query);

			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				Product product = new Product();
				product.setProductId(rs.getInt("pid"));
				product.setProductName(rs.getString("name"));
				product.setProductDescription(rs.getString("description"));
				product.setProductPrice(rs.getInt("price"));
				product.setProductQunatity(rs.getInt("quantity"));
				product.setProductImages(rs.getString("image"));
				product.setCategoryId(rs.getInt("cid"));

				list.add(product);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Product getProductsByProductId(int pid) {
		Product product = new Product();
		try {
			String query = "select * from product where pid = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, pid);
			ResultSet rs = psmt.executeQuery();
			rs.next();

			product.setProductId(rs.getInt("pid"));
			product.setProductName(rs.getString("name"));
			product.setProductDescription(rs.getString("description"));
			product.setProductPrice(rs.getInt("price"));
			product.setProductQunatity(rs.getInt("quantity"));
			product.setProductImages(rs.getString("image"));
			product.setCategoryId(rs.getInt("cid"));

		} catch (Exception e) {
			e.printStackTrace();
		}
		return product;
	}

	@Override
	public List<Product> getAllProductsByCategoryId(int catId) {
		List<Product> list = new ArrayList<Product>();
		try {
			String query = "select * from product where cid = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, catId);
			ResultSet rs = psmt.executeQuery();
			while (rs.next()) {
				Product product = new Product();
				product.setProductId(rs.getInt("pid"));
				product.setProductName(rs.getString("name"));
				product.setProductDescription(rs.getString("description"));
				product.setProductPrice(rs.getInt("price"));
				product.setProductQunatity(rs.getInt("quantity"));
				product.setProductImages(rs.getString("image"));
				product.setCategoryId(rs.getInt("cid"));
				list.add(product);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Product> getAllProductsBySearchKey(String search) {
		List<Product> list = new ArrayList<Product>();
		try {
			String query = "select * from product where lower(name) like ? or lower(description) like ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			search = "%" + search + "%";
			psmt.setString(1, search);
			psmt.setString(2, search);

			ResultSet rs = psmt.executeQuery();
			while (rs.next()) {
				Product product = new Product();
				product.setProductId(rs.getInt("pid"));
				product.setProductName(rs.getString("name"));
				product.setProductDescription(rs.getString("description"));
				product.setProductPrice(rs.getInt("price"));
				product.setProductQunatity(rs.getInt("quantity"));
				product.setProductImages(rs.getString("image"));
				product.setCategoryId(rs.getInt("cid"));
				list.add(product);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// Uncomment and update this method if needed
	// @Override
	// public List<Product> getDiscountedProducts() {
	// 	List<Product> list = new ArrayList<Product>();
	// 	try {
	// 		String query = "select * from product where discount >= 30 order by discount desc";
	// 		Statement statement = this.con.createStatement();
	// 		ResultSet rs = statement.executeQuery(query);
	// 		while (rs.next()) {
	// 			Product product = new Product();
	// 			product.setProductId(rs.getInt("pid"));
	// 			product.setProductName(rs.getString("name"));
	// 			product.setProductDescription(rs.getString("description"));
	// 			product.setProductPrice(rs.getInt("price"));
	// 			product.setProductQunatity(rs.getInt("quantity"));
	// 			// product.setProductDiscount(rs.getInt("discount"));
	// 			product.setProductImages(rs.getString("image"));
	// 			product.setCategoryId(rs.getInt("cid"));

	// 			list.add(product);
	// 		}
	// 	} catch (Exception e) {
	// 		e.printStackTrace();
	// 	}
	// 	return list;
	// }

	@Override
	public void updateProduct(Product product) {
		try {
			String query = "update product set name=?, description=?, price=?, quantity=?, image=? where pid=?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, product.getProductName());
			psmt.setString(2, product.getProductDescription());
			psmt.setInt(3, product.getProductPrice());
			psmt.setInt(4, product.getProductQuantity());
			psmt.setString(5, product.getProductImages());
			psmt.setInt(6, product.getProductId());

			exe(psmt);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateQuantity(int id, int qty) {
		try {
			String query = "update product set quantity = ? where pid = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, qty);
			psmt.setInt(2, id);

			exe(psmt);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteProduct(int pid) {
		try {
			String query = "delete from product where pid = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, pid);
			exe(psmt);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int productCount() {
		int count = 0;
		try {
			String query = "select count(*) from product";
			PreparedStatement stmt = con.prepareStatement(query);
			ResultSet rs = stmt.executeQuery();
			rs.next();
			count = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public int getProductPriceById(int pid) {
		int price = 0;
		try {
			String query = "select price from product where pid = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, pid);
			ResultSet rs = psmt.executeQuery();
			rs.next();
			price = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return price;
	}

	@Override
	public int getProductQuantityById(int pid) {
		int qty = 0;
		try {
			String query = "select quantity from product where pid = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, pid);
			ResultSet rs = psmt.executeQuery();
			rs.next();
			qty = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return qty;
	}
	
}
