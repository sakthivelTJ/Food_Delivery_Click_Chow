package com.tap.dao;

import java.util.List;

import com.tap.model.order_item;

public interface OrderItemDAO {

    void addOrderItem(order_item orderItem);

    order_item getOrderItem(int orderItem_id);

    void updateOrderItem(order_item orderItem);

    void deleteOrderItem(int orderItem_id);

    List<order_item> getAllOrderItem();

    List<order_item> getOrderItemsByOrderId(int orderId);

}



