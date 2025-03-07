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
        // Check if the item already exists in the cart
        String checkSql = "SELECT COUNT(*) FROM cart WHERE product_name = ?";
        Integer count = jdbcTemplate.queryForObject(checkSql, Integer.class, item.getProductName());

        if (count != null && count > 0) {
            // If exists, update quantity
            String updateSql = "UPDATE cart SET quantity = quantity + ? WHERE product_name = ?";
            jdbcTemplate.update(updateSql, item.getQuantity(), item.getProductName());
        } else {
            // Otherwise, insert as a new item
            String insertSql = "INSERT INTO cart (product_name, price, quantity) VALUES (?, ?, ?)";
            jdbcTemplate.update(insertSql, item.getProductName(), item.getPrice(), item.getQuantity());
        }
    }
    
    public void clearCart() {
        String deleteSql = "DELETE FROM cart";
        jdbcTemplate.update(deleteSql);
    }
}
