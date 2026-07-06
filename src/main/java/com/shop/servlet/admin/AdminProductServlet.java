package com.shop.servlet.admin;

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

public class AdminProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null || path.equals("/")) {
            ProductDAO productDAO = new ProductDAO();
            List<Product> products = productDAO.findAll(1, 100, null);
            req.setAttribute("products", products);
            req.getRequestDispatcher("/admin/product-list.jsp").forward(req, resp);
        } else if (path.equals("/add")) {
            CategoryDAO categoryDAO = new CategoryDAO();
            req.setAttribute("categories", categoryDAO.findAll());
            req.getRequestDispatcher("/admin/product-add.jsp").forward(req, resp);
        } else if (path.startsWith("/edit/")) {
            String idParam = path.substring("/edit/".length());
            if (idParam != null && !idParam.isEmpty()) {
                Long id = Long.parseLong(idParam);
                ProductDAO productDAO = new ProductDAO();
                Product product = productDAO.findById(id);
                if (product != null) {
                    CategoryDAO categoryDAO = new CategoryDAO();
                    req.setAttribute("product", product);
                    req.setAttribute("categories", categoryDAO.findAll());
                    req.getRequestDispatcher("/admin/product-edit.jsp").forward(req, resp);
                    return;
                }
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        } else if (path.startsWith("/delete/")) {
            String idParam = path.substring("/delete/".length());
            if (idParam != null && !idParam.isEmpty()) {
                Long id = Long.parseLong(idParam);
                ProductDAO productDAO = new ProductDAO();
                Product product = productDAO.findById(id);
                if (product != null) productDAO.delete(product);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null) { resp.sendRedirect(req.getContextPath() + "/admin/products"); return; }
        ProductDAO productDAO = new ProductDAO();
        Product product = new Product();
        String name = req.getParameter("name");
        String priceStr = req.getParameter("price");
        String description = req.getParameter("description");
        String stockStr = req.getParameter("stock");
        String imageUrl = req.getParameter("imageUrl");
        String categoryIdStr = req.getParameter("categoryId");
        product.setName(name);
        product.setPrice(Double.parseDouble(priceStr));
        product.setDescription(description);
        product.setStock(Integer.parseInt(stockStr));
        product.setImageUrl(imageUrl);
        CategoryDAO categoryDAO = new CategoryDAO();
        Category category = categoryDAO.findById(Long.parseLong(categoryIdStr));
        product.setCategory(category);
        if (path.equals("/add")) {
            productDAO.save(product);
        } else if (path.startsWith("/edit/")) {
            String idParam = path.substring("/edit/".length());
            if (idParam != null && !idParam.isEmpty()) {
                Long id = Long.parseLong(idParam);
                product.setId(id);
                productDAO.save(product);
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }
}