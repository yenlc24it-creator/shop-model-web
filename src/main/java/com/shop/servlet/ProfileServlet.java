package com.shop.servlet;

import com.shop.dao.UserDAO;
import com.shop.entity.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.setAttribute("user", user);
        req.getRequestDispatcher("/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String email = req.getParameter("email");

        // Cập nhật thông tin
        user.setFullName(fullName);
        user.setPhone(phone);
        user.setAddress(address);
        user.setEmail(email);

        try {
            UserDAO userDAO = new UserDAO();
            userDAO.save(user); // saveOrUpdate
            session.setAttribute("user", user);
            req.setAttribute("message", "Cập nhật thông tin thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra khi cập nhật: " + e.getMessage());
        }

        req.setAttribute("user", user);
        req.getRequestDispatcher("/profile.jsp").forward(req, resp);
    }
}