package com.Retail.controller;

import com.Retail.model.CartItem;
import com.Retail.service.CartService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/cart")
public class CartController {
    private final CartService cartService;

    public CartController(CartService cartService) {
        this.cartService = cartService;
    }

    @GetMapping
    public List<CartItem> getCart() {
        return cartService.getCartItems();
    }

    @PostMapping
    public String addToCart(@RequestBody CartItem item) {
        cartService.addToCart(item);
        return "Item added to cart successfully";
    }
}
