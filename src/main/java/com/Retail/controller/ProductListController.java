package com.Retail.controller;

import com.Retail.model.ProductList;
import com.Retail.service.ProductListService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/products-lists")
public class ProductListController {
    private final ProductListService productService;

    public ProductListController(ProductListService productService) {
        this.productService = productService;
    }

    @GetMapping
    public List<ProductList> getProducts() {
        return productService.getAllProducts();
    }
}
