package com.eazydeals.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.eazydeals.entities.Cart;
import com.eazydeals.helper.ConnectionPool;
import com.eazydeals.helper.ConnectionPoolImpl;

public class CartDaoImpl implements CartDao {
	private Connection con;
	private ConnectionPool cp;
	
	public CartDaoImpl(ConnectionPool cp) {
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
	public boolean addToCart(Cart cart) {
		boolean flag = false;
		try {
			String query = "insert into cart(uid, pid, quantity) values(?,?,?)";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, cart.getUserId());
			psmt.setInt(2, cart.getProductId());
			psmt.setInt(3, cart.getQuantity());

			flag = exe(psmt);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public List<Cart> getCartListByUserId(int uid) {
		List<Cart> list = new ArrayList<Cart>();
		try {
			String query = "select * from cart where uid = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, uid);

			ResultSet rs = psmt.executeQuery();
			while (rs.next()) {
				Cart cart = new Cart();
				cart.setCartId(rs.getInt("id"));
				cart.setUserId(rs.getInt("uid"));
				cart.setProductId(rs.getInt("pid"));
				cart.setQuantity(rs.getInt("quantity"));

				list.add(cart);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int getQuantity(int uid, int pid) {
		int qty = 0;
		try {
			String query = "select * from cart where uid = ? and pid = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, uid);
			psmt.setInt(2, pid);

			ResultSet rs = psmt.executeQuery();
			while (rs.next()) {
				qty = rs.getInt("quantity");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return qty;
	}

	@Override
	public int getQuantityById(int id) {
		int qty = 0;
		try {
			String query = "select * from cart where id = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, id);
			ResultSet rs = psmt.executeQuery();
			while (rs.next()) {
				qty = rs.getInt("quantity");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return qty;
	}

	@Override
	public void updateQuantity(int id, int qty) {
		try {
			String query = "update cart set quantity = ? where id = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, qty);
			psmt.setInt(2, id);

			exe(psmt);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void removeProduct(int cid) {
		try {
			String query = "delete from cart where id = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, cid);

			exe(psmt);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void removeAllProduct() {
		try {
			String query = "delete from cart";
			PreparedStatement psmt = this.con.prepareStatement(query);
			exe(psmt);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int getIdByUserIdAndProductId(int uid, int pid) {
		int cid = 0;
		try {
			String query = "select * from cart where uid = ? and pid = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, uid);
			psmt.setInt(2, pid);

			ResultSet rs = psmt.executeQuery();
			while (rs.next()) {
				cid = rs.getInt("id");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cid;
	}

	@Override
	public int getCartCountByUserId(int uid) {
		int count = 0;
		try {
			String query = "select count(*) from cart where uid=?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, uid);

			ResultSet rs = psmt.executeQuery();
			rs.next();
			count = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public int getProductId(int cid) {
		int pid = 0;
		try {
			String query = "select pid from cart where id=?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, cid);
			ResultSet rs = psmt.executeQuery();
			rs.next();
			pid = rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pid;
	}



}
