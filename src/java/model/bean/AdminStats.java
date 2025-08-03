package model.bean;

public class AdminStats {
    private int totalEvents;
    private int totalClubs;
    private int totalUsers;
    private double totalRevenue;

    // Getters and Setters
    public int getTotalEvents() { return totalEvents; }
    public void setTotalEvents(int totalEvents) { this.totalEvents = totalEvents; }

    public int getTotalClubs() { return totalClubs; }
    public void setTotalClubs(int totalClubs) { this.totalClubs = totalClubs; }

    public int getTotalUsers() { return totalUsers; }
    public void setTotalUsers(int totalUsers) { this.totalUsers = totalUsers; }

    public double getTotalRevenue() { return totalRevenue; }
    public void setTotalRevenue(double totalRevenue) { this.totalRevenue = totalRevenue; }
}
