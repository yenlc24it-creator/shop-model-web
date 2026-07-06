package com.shop.servlet;

import com.shop.dao.UserDAO;
import com.shop.entity.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Đảm bảo UTF-8
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");

        UserDAO userDAO = new UserDAO();

        if (userDAO.findByUsername(username) != null) {
            req.setAttribute("error", "Username đã tồn tại.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        if (userDAO.findByEmail(email) != null) {
            req.setAttribute("error", "Email đã được sử dụng.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(password); // Trong thực tế nên hash
        user.setEmail(email);
        user.setFullName(fullName);
        user.setPhone(phone);
        user.setAddress(address);
        user.setRole("user");

        userDAO.save(user);

        resp.sendRedirect(req.getContextPath() + "/login");
    }
}