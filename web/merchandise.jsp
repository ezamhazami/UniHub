<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Merchandise Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5faff;
            text-align: center;
            padding: 50px;
            margin: 0;
        }

        h2 {
            margin-bottom: 40px;
            font-size: 32px;
            color: #0d47a1;
        }

        .nav-buttons {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 40px;
        }

        .nav-buttons a {
            padding: 14px 28px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            font-size: 16px;
            transition: background-color 0.3s ease;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .nav-buttons a:hover {
            background-color: #388e3c;
        }

        .back-button {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 24px;
            background-color: #1976d2;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .back-button:hover {
            background-color: #0d47a1;
        }
    </style>
</head>
<body>

    <h2>🛍️ Merchandise Management</h2>

    <div class="nav-buttons">
        <a href="add_item.jsp">➕ Add Merchandise</a>
        <a href="edit_item.jsp">✏️ Edit Merchandise</a>
        <a href="delete_item.jsp">🗑️ Delete Merchandise</a>
    </div>

    <a href="club_dashboard.jsp" class="back-button">← Back to Club Dashboard</a>

</body>
</html>
