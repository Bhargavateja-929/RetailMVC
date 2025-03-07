package com.Retail.service;


import com.Retail.dao.ProductListDAO;
import com.Retail.model.ProductList;

import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ProductListService {
    private final ProductListDAO productDAO;

    public ProductListService(ProductListDAO productDAO) {
        this.productDAO = productDAO;
    }

    public List<ProductList> getAllProducts() {
        return productDAO.getAllProducts();
    }
}
