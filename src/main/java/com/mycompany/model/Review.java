
package com.mycompany.model;

import java.util.Date;

public class Review {
    private int id;
    private int productId;
    private int userId;
    private int rating;
    private String comment;
    private Date createdDate;
    
    private String username;

    public Review() {}

    public Review(int id, int productId, int userId, int rating, String comment, Date createdDate) {
        this.id = id;
        this.productId = productId;
        this.userId = userId;
        this.rating = rating;
        this.comment = comment;
        this.createdDate = createdDate;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }
    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
    public String getUsername() { return username; }
public void setUsername(String username) { this.username = username; }
}