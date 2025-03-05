package com.Retail.dao;

import com.Retail.model.CartItem;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class CartDAO {
    private final JdbcTemplate jdbcTemplate;

    public CartDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<CartItem> getCartItems() {
        return jdbcTemplate.query("SELECT * FROM cart", 
            (rs, rowNum) -> new CartItem(rs.getString("product_name"), rs.getDouble("price"), rs.getInt("quantity")));
    }

    public void addToCart(CartItem item) {
        jdbcTemplate.update("INSERT INTO cart (product_name, price, quantity) VALUES (?, ?, ?)", 
            item.getProductName(), item.getPrice(), item.getQuantity());
    }
}
