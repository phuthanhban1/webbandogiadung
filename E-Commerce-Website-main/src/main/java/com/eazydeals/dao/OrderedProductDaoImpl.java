package com.eazydeals.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.eazydeals.entities.OrderedProduct;
import com.eazydeals.helper.ConnectionPool;
import com.eazydeals.helper.ConnectionPoolImpl;

public class OrderedProductDaoImpl implements OrderedProductDao {
	private Connection con;
	private ConnectionPool cp;
	
	public OrderedProductDaoImpl(ConnectionPool cp) {
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
	public boolean insertOrderedProduct(OrderedProduct ordProduct) {
		// TODO Auto-generated method stub
		try {
			String query = "insert into ordered_product(name, quantity, price, image, orderid) values(?, ?, ?, ?, ?)";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, ordProduct.getName());
			psmt.setInt(2, ordProduct.getQuantity());
			psmt.setFloat(3,ordProduct.getPrice());
			psmt.setString(4, ordProduct.getImage());
			psmt.setInt(5, ordProduct.getOrderId());

			return exe(psmt);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public List<OrderedProduct> getAllOrderedProduct(int oid) {
		// TODO Auto-generated method stub
		List<OrderedProduct> list = new ArrayList<OrderedProduct>();
		try {
			String query = "select * from ordered_product where orderid = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, oid);
			ResultSet rs = psmt.executeQuery();
			while (rs.next()) {
				OrderedProduct orderProd = new OrderedProduct();
				orderProd.setName(rs.getString("name"));
				orderProd.setQuantity(rs.getInt("quantity"));
				orderProd.setPrice(rs.getInt("price"));
				orderProd.setImage(rs.getString("image"));
				orderProd.setOrderId(oid);

				list.add(orderProd);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
