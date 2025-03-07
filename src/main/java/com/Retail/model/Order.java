package com.Retail.model;

public class Order {
    private int id;
    private String productName;
    private double price;
    private int quantity;

    public Order(int id, String productName, double price, int quantity) {
        this.id = id;
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
    }

    public int getId() { return id; }
    public String getProductName() { return productName; }
    public double getPrice() { return price; }
    public int getQuantity() { return quantity; }
}
