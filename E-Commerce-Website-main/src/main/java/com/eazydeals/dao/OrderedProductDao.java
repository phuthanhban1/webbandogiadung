package com.eazydeals.dao;

import java.util.List;

import com.eazydeals.entities.OrderedProduct;

public interface OrderedProductDao {
	public boolean insertOrderedProduct(OrderedProduct ordProduct);
	public List<OrderedProduct> getAllOrderedProduct(int oid);
}
