package com.Retail.service;

import com.Retail.dao.OrderDAO;
import com.Retail.model.Order;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class OrderService {
    private final OrderDAO orderDAO;

    public OrderService(OrderDAO orderDAO) {
        this.orderDAO = orderDAO;
    }

    public List<Order> getOrders() {
        return orderDAO.getOrders();
    }
}
