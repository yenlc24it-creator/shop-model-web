package com.shop.servlet;

import com.shop.dao.OrderDAO;
import com.shop.entity.Order;
import com.shop.entity.User;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class OrderHistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) { resp.sendRedirect(req.getContextPath() + "/login"); return; }
        OrderDAO orderDAO = new OrderDAO();
        List<Order> orders = orderDAO.findByUserId(user.getId());
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/order-history.jsp").forward(req, resp);
    }
}