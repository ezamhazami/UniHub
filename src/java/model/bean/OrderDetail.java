package model.bean;

public class OrderDetail {
    private int orderId;
    private int merchId;
    private String merchName;
    private int quantity;
    private double unitPrice;
    private double subtotal;
    
    // Default constructor
    public OrderDetail() {
    }

    // Constructor with all fields (optional)
    public OrderDetail(int orderId, int merchId, String merchName, int quantity, double unitPrice, double subtotal) {
        this.orderId = orderId;
        this.merchId = merchId;
        this.merchName = merchName;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.subtotal = subtotal;
    }

    public int getOrderId() {
        return orderId;
    }
    public void setOrderId(int orderId) {
        this.orderId = orderId;
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

    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getUnitPrice() {
        return unitPrice;
    }
    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public double getSubtotal() {
        return subtotal;
    }
    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }
}