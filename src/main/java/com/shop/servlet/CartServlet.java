package com.shop.servlet;

import com.shop.dao.ProductDAO;
import com.shop.entity.Product;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class CartServlet extends HttpServlet {
    private Map<Long, Integer> getCart(HttpSession session) {
        Map<Long, Integer> cart = (Map<Long, Integer>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        HttpSession session = req.getSession();
        Map<Long, Integer> cart = getCart(session);

        if (path == null || path.equals("/")) {
            // Hiển thị giỏ hàng
            ProductDAO productDAO = new ProductDAO();
            Map<Product, Integer> cartItems = new HashMap<>();
            double total = 0;
            for (Map.Entry<Long, Integer> entry : cart.entrySet()) {
                Product p = productDAO.findById(entry.getKey());
                if (p != null) {
                    cartItems.put(p, entry.getValue());
                    total += p.getPrice() * entry.getValue();
                }
            }
            req.setAttribute("cartItems", cartItems);
            req.setAttribute("total", total);
            req.getRequestDispatcher("/cart.jsp").forward(req, resp);
            return;
        }

        if (path.startsWith("/add")) {
            String idParam = req.getParameter("id");
            int quantity = 1;
            try { quantity = Integer.parseInt(req.getParameter("quantity")); } catch (NumberFormatException ignored) {}

            if (idParam != null) {
                Long id = Long.parseLong(idParam);
                ProductDAO productDAO = new ProductDAO();
                Product product = productDAO.findById(id);

                if (product != null) {
                    int currentQty = cart.getOrDefault(id, 0);
                    int newQty = currentQty + quantity;

                    if (newQty > product.getStock()) {
                        String referer = req.getHeader("Referer");
                        if (referer != null && !referer.isEmpty()) {
                            if (referer.contains("?")) {
                                referer += "&error=stock";
                            } else {
                                referer += "?error=stock";
                            }
                            resp.sendRedirect(referer);
                            return;
                        } else {
                            resp.sendRedirect(req.getContextPath() + "/?error=stock");
                            return;
                        }
                    }
                    cart.put(id, newQty);
                }
            }

            String referer = req.getHeader("Referer");
            if (referer != null && !referer.isEmpty()) {
                resp.sendRedirect(referer);
            } else {
                resp.sendRedirect(req.getContextPath() + "/");
            }
            return;
        }

        if (path.startsWith("/remove/")) {
            String idParam = path.substring("/remove/".length());
            if (idParam != null && !idParam.isEmpty()) {
                Long id = Long.parseLong(idParam);
                cart.remove(id);
            }
            resp.sendRedirect(req.getContextPath() + "/cart");
        } else if (path.equals("/update")) {
            String idParam = req.getParameter("id");
            String qtyParam = req.getParameter("quantity");
            if (idParam != null && qtyParam != null) {
                Long id = Long.parseLong(idParam);
                int qty = Integer.parseInt(qtyParam);

                ProductDAO productDAO = new ProductDAO();
                Product product = productDAO.findById(id);
                if (product != null && qty > product.getStock()) {
                    qty = product.getStock();
                }

                if (qty <= 0) cart.remove(id);
                else cart.put(id, qty);
            }
            resp.sendRedirect(req.getContextPath() + "/cart");
        } else if (path.equals("/clear")) {
            cart.clear();
            resp.sendRedirect(req.getContextPath() + "/cart");
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}