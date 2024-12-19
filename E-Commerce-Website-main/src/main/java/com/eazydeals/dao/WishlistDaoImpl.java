package com.eazydeals.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.eazydeals.entities.Wishlist;
import com.eazydeals.helper.ConnectionPool;
import com.eazydeals.helper.ConnectionPoolImpl;

public class WishlistDaoImpl implements WishlistDao {
	private Connection con;
	private ConnectionPool cp;
	public WishlistDaoImpl(ConnectionPool cp) {
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
	public boolean addToWishlist(Wishlist w) {
		// TODO Auto-generated method stub
		boolean flag = false;
		try {
			String query = "insert into wishlist(iduser, idproduct) values(?,?)";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, w.getUserId());
			psmt.setInt(2, w.getProductId());
			
			flag = exe(psmt);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean getWishlist(int uid, int pid) {
		// TODO Auto-generated method stub
		boolean flag = false;
		try {
			String query = "select * from wishlist where iduser = ? and idproduct = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, uid);
			psmt.setInt(2, pid);
			
			ResultSet rs = psmt.executeQuery();
			while (rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public List<Wishlist> getListByUserId(int uid) {
		// TODO Auto-generated method stub
		List<Wishlist> list = new ArrayList<Wishlist>();
		try {
			String query = "select * from wishlist where iduser = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, uid);
			
			ResultSet rs = psmt.executeQuery();
			while (rs.next()) {
				Wishlist wishlist = new Wishlist();
				wishlist.setWishlistId(rs.getInt("idwishlist"));
				wishlist.setUserId(rs.getInt("iduser"));
				wishlist.setProductId(rs.getInt("idproduct"));
				
				list.add(wishlist);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void deleteWishlist(int uid, int pid) {
		// TODO Auto-generated method stub
		try {
			String query = "delete from wishlist where iduser = ? and idproduct = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, uid);
			psmt.setInt(2, pid);
			
			exe(psmt);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
