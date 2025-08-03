package model.bean;

public class Merchandise {
    private int merchID;
    private String name;
    private String description;
    private String imageUrl;
    private double price;
    private int clubId;  // ✅ Add this field

    public int getMerchId() {
        return merchID;
    }
    public void setMerchId(int merchID) {
        this.merchID = merchID;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageUrl() {
        return imageUrl;
    }
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
    public int getClubId() {
        return clubId;
    }
    public void setClubId(int clubId) {
        this.clubId = clubId;
    }

   
}