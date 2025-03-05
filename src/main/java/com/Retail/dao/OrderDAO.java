package com.Retail.dao;

import com.Retail.model.Order;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class OrderDAO {
    private final JdbcTemplate jdbcTemplate;

    public OrderDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Order> getOrders() {
        return jdbcTemplate.query("SELECT * FROM orders", 
            (rs, rowNum) -> new Order(rs.getInt("id"), rs.getString("product_name"), rs.getDouble("price"), rs.getInt("quantity")));
    }
}
