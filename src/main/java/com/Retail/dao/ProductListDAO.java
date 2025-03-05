package com.Retail.dao;

import com.Retail.model.ProductList;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class ProductListDAO {
    private final JdbcTemplate jdbcTemplate;

    public ProductListDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<ProductList> getAllProducts() {
        String sql = "SELECT * FROM ProductList";
        return jdbcTemplate.query(sql, (rs, rowNum) -> 
            new ProductList(rs.getInt("ProductID"), 
                        rs.getString("ProductName"), 
                        rs.getDouble("Price"), 
                        rs.getInt("Quantity"), 
                        rs.getString("ExpireDate")));
    }
}
