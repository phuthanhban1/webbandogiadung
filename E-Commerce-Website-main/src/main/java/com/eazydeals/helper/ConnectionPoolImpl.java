package com.eazydeals.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Stack;

public class ConnectionPoolImpl implements ConnectionPool {

	private String driver;
	private String username;
	private String password;
	private String url;
	
	private Stack<Connection> pool;
	
	public ConnectionPoolImpl() {
		//Xác định trình điều khiển
		this.driver = "com.mysql.cj.jdbc.Driver";
		
		//Nạp trình điều khiển
		// 1 try nhiều catch là cách viết của java cũ trước java 7 còn catch(abc | abss | dd) là java 7
		try {
			Class.forName(this.driver);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//Xác định tài khoản làm việc
		this.username = "exam1";
		this.password = "123456";
		
		//Xác định đường dẫn thực thi
		this.url = "jdbc:mysql://localhost:3306/gfshop";
		
		//Cấp phát bộ nhớ cho pool
		this.pool = new Stack<>();
	}

	@Override
	public Connection getConnection(String objectName) throws SQLException {
		// TODO Auto-generated method stub
		
		//Nếu trong bộ quản lý kết nối có kết nối thì xin kết nối luôn
		if(this.pool.isEmpty()) {
			System.out.println(objectName + " đã khởi tạo một kết nối mới.");
			return DriverManager.getConnection(this.url, this.username, this.password);
		}else {
			System.out.println(objectName + " đã lấy ra một kết nối.");
			return this.pool.pop();
		}
	}

	@Override
	public void releaseConnection(Connection con, String objectName) throws SQLException {
		// TODO Auto-generated method stub
		System.out.println(objectName + " đã thu hồi một kết nối mới.");
		this.pool.push(con);
	}
	
	protected void finalize() throws Throwable{
		this.pool.clear();
		this.pool = null;
		
		System.out.println("ConnectionPool đã kết thúc để ConnectionPool mới ra đời.");
	}

}
