package com.tap.dao;

import java.util.List;
import com.tap.model.order_table;

public interface OrderTableDAO {

    int addOrder(order_table order);

    order_table getOrder(int order_id);

    void updateOrder(order_table order);

    void deleteOrder(int order_id);

    List<order_table> getAllOrder();

    List<order_table> getOrdersByUserId(int userId);


}

