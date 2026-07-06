package com.shop.servlet;

import com.shop.dao.CategoryDAO;
import com.shop.dao.ProductDAO;
import com.shop.entity.Category;
import com.shop.entity.Product;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class HomeServlet extends HttpServlet {
    private static final int PAGE_SIZE = 8; // 👈 Đã đổi từ 6 thành 8

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("=== HomeServlet invoked ===");

        String keyword = req.getParameter("keyword");
        String categoryIdParam = req.getParameter("categoryId");
        Long categoryId = null;
        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            try {
                categoryId = Long.parseLong(categoryIdParam);
            } catch (NumberFormatException ignored) {}
        }

        int page = 1;
        try {
            page = Integer.parseInt(req.getParameter("page"));
        } catch (NumberFormatException ignored) {}

        ProductDAO productDAO = new ProductDAO();
        // 👇 Chỉ lấy sản phẩm còn hàng (stock > 0)
        List<Product> products = productDAO.findAll(page, PAGE_SIZE, keyword, categoryId, true);
        long total = productDAO.count(keyword, categoryId, true);
        int totalPages = (int) Math.ceil((double) total / PAGE_SIZE);

        System.out.println("Products size: " + products.size());
        System.out.println("Total: " + total);

        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categories = categoryDAO.findAll();

        req.setAttribute("products", products);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("keyword", keyword);
        req.setAttribute("categoryId", categoryId);
        req.setAttribute("categories", categories);

        req.getRequestDispatcher("/home.jsp").forward(req, resp);
    }
}