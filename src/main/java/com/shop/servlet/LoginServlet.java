package com.shop.servlet;

import com.shop.dao.UserDAO;
import com.shop.entity.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ username và password.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.findByUsername(username.trim());

        if (user == null) {
            req.setAttribute("error", "Tên đăng nhập không tồn tại.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        if (!user.getPassword().equals(password.trim())) {
            req.setAttribute("error", "Mật khẩu không chính xác.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession();
        session.setAttribute("user", user);

        if ("admin".equals(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        } else {
            resp.sendRedirect(req.getContextPath() + "/");
        }
    }
}