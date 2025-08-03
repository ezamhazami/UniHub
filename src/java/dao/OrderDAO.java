package dao;

import model.bean.Order;
import model.bean.OrderDetail;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;

public class OrderDAO {
    private Connection conn;

    public OrderDAO(Connection conn) {
        this.conn = conn;
    }

    // ---------- PLACE ORDER (Buy Now) ----------
    public int placeOrder(int userId, int merchId, int quantity, double total) throws SQLException {
        String insertOrderSQL = "INSERT INTO orders (USERID, total_amount, order_date) VALUES (?, ?, CURRENT_TIMESTAMP)";
        String insertDetailSQL = "INSERT INTO order_details (order_id, merch_id, quantity, subtotal) VALUES (?, ?, ?, ?)";

        try (
            PreparedStatement orderStmt = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS);
            PreparedStatement detailStmt = conn.prepareStatement(insertDetailSQL)
        ) {
            // Insert into orders
            orderStmt.setInt(1, userId);
            orderStmt.setDouble(2, total);
            orderStmt.executeUpdate();

            ResultSet rs = orderStmt.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // Insert into order_details
            detailStmt.setInt(1, orderId);
            detailStmt.setInt(2, merchId);
            detailStmt.setInt(3, quantity);
            detailStmt.setDouble(4, total);
            detailStmt.executeUpdate();

            return orderId;
        }
    }

    public void checkoutFromCart(int userId) throws SQLException, ServletException {
    // Step 1: Calculate total order amount
    String totalQuery = "SELECT SUM(c.quantity * m.price) AS total " +
                        "FROM cart c JOIN merchandise m ON c.merch_id = m.merch_id " +
                        "WHERE c.userid = ?";

    // Step 2: Insert into orders and get generated ID
    String insertOrder = "INSERT INTO orders (userid, total_amount, order_date) " +
                         "VALUES (?, ?, CURRENT_TIMESTAMP)";

    // Step 3: Get items from cart
    String fetchCart = "SELECT c.merch_id, c.quantity, m.price " +
                       "FROM cart c JOIN merchandise m ON c.merch_id = m.merch_id " +
                       "WHERE c.userid = ?";

    // Step 4: Insert order details
    String insertDetail = "INSERT INTO order_details (order_id, merch_id, quantity, subtotal) " +
                          "VALUES (?, ?, ?, ?)";

    // Step 5: Clear the user's cart
    String clearCart = "DELETE FROM cart WHERE userid = ?";

    conn.setAutoCommit(false);

    try (
        PreparedStatement psTotal = conn.prepareStatement(totalQuery);
        PreparedStatement psOrder = conn.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS);
        PreparedStatement psFetch = conn.prepareStatement(fetchCart);
        PreparedStatement psDetail = conn.prepareStatement(insertDetail);
        PreparedStatement psClear = conn.prepareStatement(clearCart)
    ) {
        // 1. Calculate total
        psTotal.setInt(1, userId);
        ResultSet rsTotal = psTotal.executeQuery();
        double total = 0;
        if (rsTotal.next()) {
            total = rsTotal.getDouble("total");
        }

        // 2. Insert order
        psOrder.setInt(1, userId);
        psOrder.setDouble(2, total);
        psOrder.executeUpdate();

        // 3. Get new order_id
        ResultSet rsOrderId = psOrder.getGeneratedKeys();
        int orderId = 0;
        if (rsOrderId.next()) {
            orderId = rsOrderId.getInt(1);
        }

        // 4. Fetch cart items
        psFetch.setInt(1, userId);
        ResultSet rsItems = psFetch.executeQuery();

        // 5. Insert each item into order_details
        while (rsItems.next()) {
            int merchId = rsItems.getInt("merch_id");
            int qty = rsItems.getInt("quantity");
            double price = rsItems.getDouble("price");
            double subtotal = qty * price;

            psDetail.setInt(1, orderId);
            psDetail.setInt(2, merchId);
            psDetail.setInt(3, qty);
            psDetail.setDouble(4, subtotal);
            psDetail.addBatch();
        }

        psDetail.executeBatch();

        // 6. Clear cart
        psClear.setInt(1, userId);
        psClear.executeUpdate();

        conn.commit();

    } catch (SQLException e) {
        conn.rollback();
        throw new ServletException("Order processing failed: " + e.getMessage(), e);
    } finally {
        conn.setAutoCommit(true);
    }
}


    // ---------- GET ALL ORDERS BY USER ----------
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE USERID = ? ORDER BY order_date DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                int orderId = rs.getInt("order_id");

                order.setId(orderId);
                order.setUserId(userId);
                order.setDate(rs.getTimestamp("order_date"));
                order.setTotal(rs.getDouble("total_amount"));

                order.setDetails(getOrderDetails(orderId));

                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // ---------- GET ORDER DETAILS ----------
    private List<OrderDetail> getOrderDetails(int orderId) {
        List<OrderDetail> details = new ArrayList<>();
        String sql = "SELECT O.*,M.NAME \n" +
                        "FROM ORDER_DETAILS O, MERCHANDISE M\n" +
                        "WHERE O.MERCH_ID=M.MERCH_ID\n" +
                        "AND O.ORDER_ID=?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderDetail detail = new OrderDetail();
                detail.setOrderId(orderId);
                detail.setMerchId(rs.getInt("merch_id"));
                detail.setMerchName(rs.getString("name"));
                detail.setQuantity(rs.getInt("quantity"));
                detail.setSubtotal(rs.getDouble("subtotal"));
                details.add(detail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return details;
    }
}