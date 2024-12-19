package com.eazydeals.dao;

import java.sql.Date;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;
import java.util.Map;

import com.eazydeals.entities.Order;

public interface OrderDao {
	public int insertOrder(Order order);
	public List<Order> getAllOrderByUserId(int uid);
	public Order getOrderById(int id);
	public List<Order> getAllOrder();
	public void updateOrderStatus(int oid, byte status);
	public LocalDate getDate();
	public List<Order> getOrderByStatus();
	public Map<LocalDate, Long> getOrderPricePerDayByStatus();
	// tính doanh thu của 1 ngày
//	public long getRevenueDay(LocalDate d);
	// tính doanh thu của 12 tháng
	public Map<YearMonth, Long> getRevenueMonth(Map<LocalDate, Long> map);
	// tính doanh thu của 1 năm
	public Map<Integer, Long> getRevenueYear(Map<YearMonth, Long> hash);
	
	public Map<Integer, String> getRevenue12Month(Map<Integer, Long> mapYear, Map<YearMonth, Long> mapMonth);
	public String getMonthInYear(Map<YearMonth, Long> map, int nam);
}
