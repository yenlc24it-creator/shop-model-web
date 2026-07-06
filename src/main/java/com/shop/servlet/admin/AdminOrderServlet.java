package com.shop.servlet.admin;

import com.shop.dao.OrderDAO;
import com.shop.dao.ProductDAO;
import com.shop.entity.Order;
import com.shop.entity.OrderDetail;
import com.shop.entity.Product;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class AdminOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        OrderDAO orderDAO = new OrderDAO();
        List<Order> orders = orderDAO.findAll();
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/admin/order-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String orderIdParam = req.getParameter("orderId");
        String status = req.getParameter("status");
        if (orderIdParam != null && status != null) {
            Long orderId = Long.parseLong(orderIdParam);
            OrderDAO orderDAO = new OrderDAO();

            if ("PROCESSING".equals(status)) {
                Order order = orderDAO.findByIdWithDetails(orderId);
                if (order != null && order.getOrderDetails() != null) {
                    ProductDAO productDAO = new ProductDAO();
                    for (OrderDetail detail : order.getOrderDetails()) {
                        Product product = detail.getProduct();
                        int newStock = product.getStock() - detail.getQuantity();
                        if (newStock < 0) newStock = 0;
                        product.setStock(newStock);
                        productDAO.save(product);
                    }
                }
            }

            orderDAO.updateStatus(orderId, status);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/orders");
    }
}