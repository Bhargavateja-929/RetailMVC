package com.Retail.service;

import com.Retail.dao.ProductDAO;
import com.Retail.model.Product;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ProductService {
    private final ProductDAO productDAO;

    public ProductService(ProductDAO productDAO) {
        this.productDAO = productDAO;
    }

    public List<Product> getProducts() {
        return productDAO.getProducts();
    }
}
