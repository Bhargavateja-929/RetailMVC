package com.Retail.dao;

import com.Retail.model.Product;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class ProductDAO {
    private final JdbcTemplate jdbcTemplate;

    public ProductDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // RowMapper for Product
    private static final RowMapper<Product> productRowMapper = (rs, rowNum) -> new Product(
        rs.getInt("id"),
        rs.getString("name"),
        rs.getDouble("price"),
        rs.getString("image_url") // Now correctly mapping image_url
    );

    // Fetch all products
    public List<Product> getProducts() {
        String sql = "SELECT id, name, price, image_url FROM products";
        return jdbcTemplate.query(sql, productRowMapper);
    }
}
