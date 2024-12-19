package com.eazydeals.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.eazydeals.entities.Order;
import com.eazydeals.helper.ConnectionPool;
import com.eazydeals.helper.ConnectionPoolImpl;

public class OrderDaoImpl implements OrderDao {
	private Connection con;
	private ConnectionPool cp;
	
	public OrderDaoImpl(ConnectionPool cp) {
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
	public int insertOrder(Order order) {
		String insertSQL = "INSERT INTO `order` (orderid, status, paymentType, userId, date, totalPrice) VALUES (?, ?, ?, ?, ?, ?)";
        int orderId = 0;
        
        try (PreparedStatement preparedStatement = this.con.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS)) {
        	preparedStatement.setString(1, order.getOrderId()); // Example order ID
            preparedStatement.setByte(2, order.getStatus()); // Example status
            preparedStatement.setByte(3, order.getPayementType()); // Example payment type
            preparedStatement.setInt(4, order.getUserId()); // Example user ID
            
            LocalDate localDate = LocalDate.now();
            preparedStatement.setString(5, localDate.toString());
            preparedStatement.setInt(6, order.getTotalPrice());
            
            if (exe(preparedStatement)) {
                try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        orderId = generatedKeys.getInt(1);
                        System.out.println("Inserted order ID: " + orderId);
                    } else {
                        throw new SQLException("Failed to retrieve generated order ID.");
                    }
                }
            } else {
                throw new SQLException("Inserting order failed, no rows affected.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return orderId;
	}

//	//@Override
//	public int insertOrder(Order order) {
//String insertSQL = "INSERT INTO `order` (orderid, status, paymentType, userId, date) VALUES (?, ?, ?, ?, ?)";
//        
//        try {
//            PreparedStatement preparedStatement = this.con.prepareStatement(insertSQL);
//            
//            // Set the parameters
//            preparedStatement.setString(1, order.getOrderId()); // Example order ID
//            preparedStatement.setString(2, order.getStatus()); // Example status
//            preparedStatement.setString(3, order.getPayementType()); // Example payment type
//            preparedStatement.setInt(4, order.getUserId()); // Example user ID
//            
//            LocalDate localDate = LocalDate.now();
//            preparedStatement.setString(5, localDate.toString());
//            
//            // Execute the statement
//            exe(preparedStatement);
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//		return 0;
//	}
//	public static void main(String[] args) {
//		OrderDao od = new OrderDaoImpl(null);
//		List<Order> list = od.getAllOrder();
//		for(Order i : list) {
//			System.out.println(i.getDate());
//		}
////		Order order = new Order("aaa",(byte) 0, (byte) 0, 9);
////		od.insertOrder(order);
//	}
	
//	public static void main(String[] args) {
//        LocalDate date = LocalDate.now();
//        System.out.println("Current Date: " + date);
//    }
	
	@Override
	public List<Order> getAllOrderByUserId(int uid) {
		List<Order> list = new ArrayList<Order>();
		try {
			String query = "select * from `order` where userId = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, uid);
			ResultSet rs = psmt.executeQuery();
			while (rs.next()) {
				Order order = new Order();
				order.setId(rs.getInt("id"));
				order.setOrderId(rs.getString("orderid"));
				order.setStatus(rs.getByte("status"));
				order.setDate(rs.getDate("date").toLocalDate());
				order.setPayementType(rs.getByte("paymentType"));
				order.setUserId(uid);
				order.setTotalPrice(rs.getInt("totalPrice"));

				list.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Order getOrderById(int id) {
		Order order = new Order();
		try {
			String query = "select * from `order` where id = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, id);
			ResultSet rs = psmt.executeQuery();
			while (rs.next()) {
				order.setId(rs.getInt("id"));
				order.setOrderId(rs.getString("orderid"));
				order.setStatus(rs.getByte("status"));
				order.setDate(rs.getDate("date").toLocalDate());
				order.setPayementType(rs.getByte("paymentType"));
				order.setUserId(rs.getInt("userId"));
				order.setTotalPrice(rs.getInt("totalPrice"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return order;
	}

	@Override
	public List<Order> getAllOrder() {
		List<Order> list = new ArrayList<Order>();
		try {
			String query = "select * from `order`";
			Statement statement = this.con.createStatement();
			ResultSet rs = statement.executeQuery(query);
			while (rs.next()) {
				Order order = new Order();
				order.setId(rs.getInt("id"));
				order.setOrderId(rs.getString("orderid"));
				order.setStatus(rs.getByte("status"));
				order.setDate(rs.getDate("date").toLocalDate());
				order.setPayementType(rs.getByte("paymentType"));
				order.setUserId(rs.getInt("userId"));
				order.setTotalPrice(rs.getInt("totalPrice"));
				list.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void updateOrderStatus(int oid, byte status) {
		try {
			String query = "update `order` set status = ? where id = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setByte(1, status);
			psmt.setInt(2, oid);

			exe(psmt);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public LocalDate getDate() {
		// TODO Auto-generated method stub
		List<Order> li = this.getAllOrder();
		
		return null;
	}

	@Override
	public List<Order> getOrderByStatus() {
		// TODO Auto-generated method stub
		List<Order> list = new ArrayList<Order>();
		try {
			String query = "select date, totalPrice from `order` where status = 3";
			PreparedStatement statement = this.con.prepareStatement(query);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				Order order = new Order();
				
				order.setDate(rs.getDate("date").toLocalDate());
				order.setTotalPrice(rs.getInt("totalPrice"));
				list.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
		
	}
	
	
	@Override
	// doanh thu theo ngay
	public Map<LocalDate, Long> getOrderPricePerDayByStatus() {
		// TODO Auto-generated method stub
		Map<LocalDate, Long> map = new HashMap<>();
		try {
			String query = "select date, totalPrice from `order` where status = 3";
			PreparedStatement statement = this.con.prepareStatement(query);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				LocalDate date = rs.getDate("date").toLocalDate(); 
				Long price = (long) rs.getInt("totalPrice");
				
				if (map.containsKey(date)) {
		            // Nếu key đã tồn tại, cộng thêm giá trị mới vào giá trị hiện tại
		            Long currentValue = map.get(date);
		            map.put(date, currentValue + price);
		        } else {
		            // Nếu key chưa tồn tại, thêm key mới với giá trị valueToAdd
		            map.put(date, price);
		        }
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
// doanh thu theo thang
	@Override
	public Map<YearMonth, Long> getRevenueMonth(Map<LocalDate, Long> map) {
		// TODO Auto-generated method stub
		Map<YearMonth, Long> hash = new HashMap<>();
		for (Map.Entry<LocalDate, Long> entry : map.entrySet()) {

			YearMonth x = YearMonth.of(entry.getKey().getYear(), entry.getKey().getMonth());
			if (hash.containsKey(x)) {
	            // Nếu key đã tồn tại, cộng thêm giá trị mới vào giá trị hiện tại
	            Long currentValue = hash.get(x);
	            hash.put(x, currentValue + entry.getValue());
	        } else {
	            // Nếu key chưa tồn tại, thêm key mới với giá trị valueToAdd
	            hash.put(x, entry.getValue());
	        }
		}
		return hash;
	}
	
// doanh thu theo nam
	@Override
	public Map<Integer, Long> getRevenueYear(Map<YearMonth, Long> hash) {
		// TODO Auto-generated method stub
		Map<Integer, Long> result = new TreeMap<>();
		for (Map.Entry<YearMonth, Long> entry : hash.entrySet()) {

			//YearMonth x = YearMonth.of(entry.getKey().getYear(), entry.getKey().getMonth());
			int year = entry.getKey().getYear();
			if (result.containsKey(year)) {
	            // Nếu key đã tồn tại, cộng thêm giá trị mới vào giá trị hiện tại
	            Long currentValue = result.get(year);
	            result.put(year, currentValue + entry.getValue());
	        } else {
	            // Nếu key chưa tồn tại, thêm key mới với giá trị valueToAdd
	        	result.put(year, entry.getValue());
	        }
		}
		return result;
	}
	
	public String dayToString(Map<LocalDate, Long> map) {
		
		return "";
	}

	@Override
	public Map<Integer, String> getRevenue12Month(Map<Integer, Long> mapYear, Map<YearMonth, Long> mapMonth) {
		// TODO Auto-generated method stub
		
		Map<Integer, String> result = new TreeMap<>();
		for (int x: mapYear.keySet()) {
		   result.put(x, this.getMonthInYear(mapMonth, x));
		}
		return result;
	}
	@Override
	public String getMonthInYear(Map<YearMonth, Long> map, int nam) {
		// TODO Auto-generated method stub
		Long[] arr = new Long[12]; 
		for(int i = 0; i < 12; i++) {
			arr[i] = (long) 0;
		}
		for (Map.Entry<YearMonth, Long> entry : map.entrySet()) {
			System.out.println(entry.getKey() + " " + entry.getValue());
		   if(entry.getKey().getYear() == nam) {
			   arr[entry.getKey().getMonthValue() - 1] = entry.getValue();
		   }
		}
		StringBuilder s = new StringBuilder();
		s.append("[");
		for(long i: arr) {
			s.append(i + ",");
		}
		s.deleteCharAt(s.length() - 1);
		s.append("]");
		return s.toString();
	}

	public static void main(String[] args) {
		OrderDao od = new OrderDaoImpl(null);
		List<Order> li = od.getOrderByStatus();
		Map<LocalDate, Long> mapDay = od.getOrderPricePerDayByStatus();
		Map<YearMonth, Long> mapMonth = od.getRevenueMonth(mapDay);
		Map<Integer, Long> mapYear = od.getRevenueYear(mapMonth);
//		Map<Integer, String> getMonthOfYear = od.getRevenue12Month(mapYear, mapMonth);
//		StringBuilder s = new StringBuilder();
//		s.append("{");
//		for (Map.Entry<Integer, String> x : getMonthOfYear.entrySet()) {
//			s.append("\"" + x.getKey() + "\"" + " : " + x.getValue() + ", ");
//		}
//		s.delete(s.length() - 2, s.length() - 1);
//		s.append("}");
//		System.out.println(s.toString()); 
//		for (Map.Entry<Integer, Long> x : mapYear.entrySet()) {
//			System.out.println((x.getKey() + " " + x.getValue()));
//		}
		System.out.println(od.getMonthInYear(mapMonth, 2024));
		
	}
	
}
