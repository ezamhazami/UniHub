package model.bean;

public class CartItem {
    private int id; // Cart table ID
    private int userId;
    private int merchId;
    private String merchName;
    private String imageUrl;
    private int quantity;
    private double price;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getMerchId() {
        return merchId;
    }
    public void setMerchId(int merchId) {
        this.merchId = merchId;
    }

    public String getMerchName() {
        return merchName;
    }
    public void setMerchName(String merchName) {
        this.merchName = merchName;
    }

    public String getImageUrl() {
        return imageUrl;
    }
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }

    public double getSubtotal() {
        return price * quantity;
    }
}