package com.mycompany.model;

import java.util.List;

public class Product {
    private int id;
    private String name;
    private double price; // Giá sau giảm
    private double originalPrice; // Giá gốc
    private String description;
    private String image;
    private int quantity;
    private String brand;
    private double averageRating;
    private int reviewCount;
    private List<String> images;

    public Product() {}

    public Product(int id, String name, double price, double originalPrice, String description, String image, int quantity) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.originalPrice = originalPrice;
        this.description = description;
        this.image = image;
        this.quantity = quantity;
    }

    // Getters and setters...
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public double getOriginalPrice() { return originalPrice; }
    public void setOriginalPrice(double originalPrice) { this.originalPrice = originalPrice; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }
    public double getAverageRating() { return averageRating; }
    public void setAverageRating(double averageRating) { this.averageRating = averageRating; }
    public int getReviewCount() { return reviewCount; }
    public void setReviewCount(int reviewCount) { this.reviewCount = reviewCount; }
    public List<String> getImages() { return images; }
    public void setImages(List<String> images) { this.images = images; }
    public String getImagesString() {
        return images != null ? String.join(",", images) : "";
    }

    // Tính phần trăm giảm giá
    public int getDiscountPercentage() {
        if (originalPrice > 0 && price < originalPrice) {
            return (int) Math.round(((originalPrice - price) / originalPrice) * 100);
        }
        return 0;
    }
}