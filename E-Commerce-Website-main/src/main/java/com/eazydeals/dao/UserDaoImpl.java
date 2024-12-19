package com.eazydeals.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.eazydeals.entities.User;
import com.eazydeals.helper.ConnectionPool;
import com.eazydeals.helper.ConnectionPoolImpl;

public class UserDaoImpl implements UserDao {
	private Connection con;
	private ConnectionPool cp;
	
	public UserDaoImpl(ConnectionPool cp) {
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
	public boolean saveUser(User user) {
		boolean flag = false;
		try {
			String query = "insert into user(name, email, password, phone, gender, address, pincode) values(?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, user.getUserName());
			psmt.setString(2, user.getUserEmail());
			psmt.setString(3, user.getUserPassword());
			psmt.setString(4, user.getUserPhone());
			psmt.setString(5, user.getUserGender());
			psmt.setString(6, user.getUserAddress());
			psmt.setString(7, user.getUserPincode());

			flag = exe(psmt);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public User getUserByEmailPassword(String userEmail, String userPassword) {
		User user = null;
		try {
			String query = "select * from user where email = ? and password = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, userEmail);
			psmt.setString(2, userPassword);

			ResultSet set = psmt.executeQuery();
			while (set.next()) {
				user = new User();

				user.setUserId(set.getInt("userid"));
				user.setUserName(set.getString("name"));
				user.setUserEmail(set.getString("email"));
				user.setUserPassword(set.getString("password"));
				user.setUserPhone(set.getString("phone"));
				user.setUserGender(set.getString("gender"));
				user.setDateTime(set.getTimestamp("registerdate"));
				user.setUserAddress(set.getString("address"));
				user.setUserPincode(set.getString("pincode"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return user;
	}

	@Override
	public User getUserByEmail(String userEmail) {
		User user = null;
		try {
			String query = "select * from user where email = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, userEmail);

			ResultSet set = psmt.executeQuery();
			while (set.next()) {
				user = new User();

				user.setUserId(set.getInt("userid"));
				user.setUserName(set.getString("name"));
				user.setUserEmail(set.getString("email"));
				user.setUserPassword(set.getString("password"));
				user.setUserPhone(set.getString("phone"));
				user.setUserGender(set.getString("gender"));
				user.setDateTime(set.getTimestamp("registerdate"));
				user.setUserAddress(set.getString("address"));
				user.setUserPincode(set.getString("pincode"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return user;
	}

	@Override
	public List<User> getAllUser() {
		List<User> list = new ArrayList<User>();
		try {
			String query = "select * from user";
			PreparedStatement statement = this.con.prepareStatement(query);
			ResultSet set = statement.executeQuery();
			while (set.next()) {
				User user = new User();
				user.setUserId(set.getInt("userid"));
				user.setUserName(set.getString("name"));
				user.setUserEmail(set.getString("email"));
				user.setUserPassword(set.getString("password"));
				user.setUserPhone(set.getString("phone"));
				user.setUserGender(set.getString("gender"));
				user.setDateTime(set.getTimestamp("registerdate"));
				user.setUserAddress(set.getString("address"));
				user.setUserPincode(set.getString("pincode"));

				list.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void updateUserAddresss(User user) {
		try {
			String query = "update user set address = ?, pincode = ? where userid = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, user.getUserAddress());
			psmt.setString(2, user.getUserPincode());
			psmt.setInt(3, user.getUserId());

			exe(psmt);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean updateUserPasswordByEmail(String password, String mail) {
		try {
			String query = "update user set password = ? where email = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, password);
			psmt.setString(2, mail);

			return exe(psmt);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public void updateUser(User user) {
	    try {
	        String query = "update user set name = ?, email = ?, phone = ?, gender = ?, address = ?, pincode = ? where userid = ?";
	        PreparedStatement psmt = this.con.prepareStatement(query);
	        psmt.setString(1, user.getUserName());
	        psmt.setString(2, user.getUserEmail());
	        psmt.setString(3, user.getUserPhone());
	        psmt.setString(4, user.getUserGender());
	        psmt.setString(5, user.getUserAddress());
	        psmt.setString(6, user.getUserPincode());
	        psmt.setInt(7, user.getUserId());

	        exe(psmt);

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

	@Override
	public int userCount() {
	    int count = 0;
	    try {
	        String query = "select count(*) from user";
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
	public String getUserAddress(int uid) {
	    String address = "";
	    try {
	        String query = "select address from user where userid = ?";
	        PreparedStatement psmt = this.con.prepareStatement(query);
	        psmt.setInt(1, uid);

	        ResultSet rs = psmt.executeQuery();
	        rs.next();
	        address = rs.getString(1);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return address;
	}

	@Override
	public String getUserName(int uid) {
	    String name = "";
	    try {
	        String query = "select name from user where userid = ?";
	        PreparedStatement psmt = this.con.prepareStatement(query);
	        psmt.setInt(1, uid);

	        ResultSet rs = psmt.executeQuery();
	        rs.next();
	        name = rs.getString(1);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return name;
	}

	@Override
	public String getUserEmail(int uid) {
	    String email = "";
	    try {
	        String query = "select email from user where userid = ?";
	        PreparedStatement psmt = this.con.prepareStatement(query);
	        psmt.setInt(1, uid);

	        ResultSet rs = psmt.executeQuery();
	        rs.next();
	        email = rs.getString(1);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return email;
	}

	@Override
	public String getUserPhone(int uid) {
	    String phone = "";
	    try {
	        String query = "select phone from user where userid = ?";
	        PreparedStatement psmt = this.con.prepareStatement(query);
	        psmt.setInt(1, uid);

	        ResultSet rs = psmt.executeQuery();
	        rs.next();
	        phone = rs.getString(1);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return phone;
	}

	@Override
	public void deleteUser(int uid) {
	    try {
	        String query = "delete from user where userid = ?";
	        PreparedStatement psmt = this.con.prepareStatement(query);
	        psmt.setInt(1, uid);
	        exe(psmt);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	@Override
	public List<String> getAllEmail() {
	    List<String> list = new ArrayList<>();
	    try {
	        String query = "select email from user";
	        PreparedStatement statement = this.con.prepareStatement(query);
	        ResultSet set = statement.executeQuery();
	        while (set.next()) {
	            list.add(set.getString(1));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	
}
