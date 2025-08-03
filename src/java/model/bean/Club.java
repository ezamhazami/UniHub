package model.bean;

public class Club {
    private int clubId;
    private String clubName;
    private String description;
    private int userID;

    // Getters and Setters
    public int getClubId() { return clubId; }
    public void setClubId(int clubId) { this.clubId = clubId; }

    public String getClubName() { return clubName; }
    public void setClubName(String clubName) { this.clubName = clubName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getUserID() { return userID; }
    public void setUserID(int userID) {this.userID = userID;}

}