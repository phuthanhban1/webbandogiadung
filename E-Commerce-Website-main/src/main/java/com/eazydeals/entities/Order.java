package com.eazydeals.entities;

import java.sql.Date;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class Order {
	
	private int id;
	private String orderId;
	private byte status;
	private LocalDate date;
	private byte payementType;
	private int userId;
	private int totalPrice;
	public Order() {
		super();
	}

	public Order(String orderId, byte status, LocalDate date, byte payementType, int userId, int totalPrice) {
		super();
		this.orderId = orderId;
		this.status = status;
		this.date = date;
		this.payementType = payementType;
		this.userId = userId;
		this.totalPrice = totalPrice;
	}

	public Order(String orderId, byte status, byte payementType, int userId, int totalPrice) {
		super();
		this.orderId = orderId;
		this.status = status;
		this.payementType = payementType;
		this.userId = userId;
		this.totalPrice = totalPrice;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public byte getStatus() {
		return status;
	}
	public String getStatusString() {
		if (status == 0) {
			return "Đã đặt hàng";
		}if (status == 1) {
			return "Xác nhận đơn hàng";
		}if (status == 2) {
			return "Đang giao";
		}if (status == 3) {
			return "Đã giao";
		}
		return "";
	}

	public void setStatus(byte status) {
		this.status = status;
	}

	public LocalDate getDate() {
		return date;
	}

	public void setDate(LocalDate date) {
		this.date = date;
	}

	public byte getPayementType() {
		return payementType;
	}

	public String getPayementTypeString() {
		if (payementType == 0) {
			return "Thanh toán khi nhận hàng";
		}
		if (payementType == 1) {
			return "Thẻ tín dụng";
		}
		if (payementType == 2) {
			return "Thẻ ghi nợ";
		}
		if (payementType == 3) {
			return "Thẻ ATM";
		}
		return "";
	}
	public void setPayementType(byte payementType) {
		this.payementType = payementType;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	public static String listLongString(Map<Integer, Long> a) {
		StringBuilder s = new StringBuilder();
		s.append("[");
		for (Map.Entry<Integer, Long> x : a.entrySet()) {
			s.append(x.getValue() + ",");
		}
		s.deleteCharAt(s.length() - 1);
		s.append("]");
		return s.toString();
	}
	public static String listIntString(List<Integer> a) {
		StringBuilder s = new StringBuilder();
		s.append("[");
		for(int x: a) {
			s.append(x + ",");
		}
		s.deleteCharAt(s.length() - 1);
		s.append("]");
		return s.toString();
	}
	public static String listSetString(Map<Integer, Long> a) {
		StringBuilder s = new StringBuilder();
		s.append("[");
		for(int x: a.keySet()) {
			s.append(x + ",");
		}
		s.deleteCharAt(s.length() - 1);
		s.append("]");
		return s.toString();
	}
	public static String listArrayString(long[] a) {
		StringBuilder s = new StringBuilder();
		s.append("[");
		for(long x : a) {
			s.append(x + ",");
		}
		s.deleteCharAt(s.length() - 1);
		s.append("]");
		return s.toString();
	}
}
