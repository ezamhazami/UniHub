package controller;

import dao.MerchandiseDAO;
import model.bean.Merchandise;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class CatalogServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        MerchandiseDAO dao = new MerchandiseDAO();
        List<Merchandise> merchList = dao.getAllMerchandise();

        request.setAttribute("merchandiseList", merchList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Catalog.jsp");
        dispatcher.forward(request, response);
    }
}