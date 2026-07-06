package com.shop.servlet;

import com.shop.dao.ProductDAO;
import com.shop.entity.Product;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ProductDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null) { resp.sendRedirect(req.getContextPath() + "/"); return; }
        try {
            Long id = Long.parseLong(idParam);
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.findById(id);
            if (product == null) { resp.sendRedirect(req.getContextPath() + "/"); return; }
            req.setAttribute("product", product);
            req.getRequestDispatcher("/detail.jsp").forward(req, resp);
        } catch (NumberFormatException e) { resp.sendRedirect(req.getContextPath() + "/"); }
    }
}