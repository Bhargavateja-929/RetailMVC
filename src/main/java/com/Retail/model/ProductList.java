package com.Retail.model;

public class ProductList {
    private int productId;
    private String productName;
    private double price;
    private int quantity;
    private String expireDate;

    public ProductList(int productId, String productName, double price, int quantity, String expireDate) {
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
        this.expireDate = expireDate;
    }

    public int getProductId() { return productId; }
    public String getProductName() { return productName; }
    public double getPrice() { return price; }
    public int getQuantity() { return quantity; }
    public String getExpireDate() { return expireDate; }
}
