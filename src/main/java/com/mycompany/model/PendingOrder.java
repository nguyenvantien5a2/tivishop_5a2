package com.mycompany.model;

import java.util.Date;
import java.util.List;

public class PendingOrder {
    private int userId;
    private double totalAmount;
    private String status;
    private Date createdDate;
    private String address;
    private String billingName;
    private String billingPhone;
    private String billingEmail;
    private List<CartItem> cartItems; // Lưu giỏ hàng tạm thời

    public PendingOrder() {}

    public PendingOrder(int userId, double totalAmount, String status, Date createdDate, String address,
                        String billingName, String billingPhone, String billingEmail, List<CartItem> cartItems) {
        this.userId = userId;
        this.totalAmount = totalAmount;
        this.status = status;
        this.createdDate = createdDate;
        this.address = address;
        this.billingName = billingName;
        this.billingPhone = billingPhone;
        this.billingEmail = billingEmail;
        this.cartItems = cartItems;
    }

    // Getters and Setters...
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getBillingName() { return billingName; }
    public void setBillingName(String billingName) { this.billingName = billingName; }
    public String getBillingPhone() { return billingPhone; }
    public void setBillingPhone(String billingPhone) { this.billingPhone = billingPhone; }
    public String getBillingEmail() { return billingEmail; }
    public void setBillingEmail(String billingEmail) { this.billingEmail = billingEmail; }
    public List<CartItem> getCartItems() { return cartItems; }
    public void setCartItems(List<CartItem> cartItems) { this.cartItems = cartItems; }
}