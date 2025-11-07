package com.mycompany.model;

public class Payment {
    private int id;
    private int orderId;
    private double amount;
    private String transactionId;
    private String status;

    public Payment() {}

    public Payment(int id, int orderId, double amount, String transactionId, String status) {
        this.id = id;
        this.orderId = orderId;
        this.amount = amount;
        this.transactionId = transactionId;
        this.status = status;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
    public String getTransactionId() { return transactionId; }
    public void setTransactionId(String transactionId) { this.transactionId = transactionId; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
