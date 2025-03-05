package com.Retail.service;

import com.Retail.dao.CartDAO;
import com.Retail.model.CartItem;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CartService {
    private final CartDAO cartDAO;

    public CartService(CartDAO cartDAO) {
        this.cartDAO = cartDAO;
    }

    public List<CartItem> getCartItems() {
        return cartDAO.getCartItems();
    }

    public void addToCart(CartItem item) {
        cartDAO.addToCart(item);
    }
}
