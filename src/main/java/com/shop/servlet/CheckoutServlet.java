package com.shop.servlet;

import com.shop.dao.OrderDAO;
import com.shop.dao.ProductDAO;
import com.shop.entity.Order;
import com.shop.entity.OrderDetail;
import com.shop.entity.Product;
import com.shop.entity.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Map;
import java.util.Properties;

public class CheckoutServlet extends HttpServlet {
    private String qrImageUrl;
    private String bankName;
    private String accountHolder;
    private String accountNumber;
    private String transferContent;

    @Override
    public void init() throws ServletException {
        try (InputStream input = getClass().getClassLoader().getResourceAsStream("config.properties")) {
            Properties prop = new Properties();
            if (input == null) {
                qrImageUrl = "https://via.placeholder.com/220x220?text=QR+Code";
                bankName = "Ngân hàng ABC";
                accountHolder = "Nguyễn Văn A";
                accountNumber = "0123456789";
                transferContent = "Thanh toan don hang #ORDER_ID";
            } else {
                prop.load(input);
                qrImageUrl = prop.getProperty("qr.image.url", "https://via.placeholder.com/220x220?text=QR+Code");
                bankName = prop.getProperty("bank.name", "Ngân hàng ABC");
                accountHolder = prop.getProperty("account.holder", "Nguyễn Văn A");
                accountNumber = prop.getProperty("account.number", "0123456789");
                transferContent = prop.getProperty("transfer.content", "Thanh toan don hang #ORDER_ID");
            }
        } catch (IOException ex) {
            ex.printStackTrace();
            qrImageUrl = "https://via.placeholder.com/220x220?text=QR+Code";
            bankName = "Ngân hàng ABC";
            accountHolder = "Nguyễn Văn A";
            accountNumber = "0123456789";
            transferContent = "Thanh toan don hang #ORDER_ID";
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        Map<Long, Integer> cart = (Map<Long, Integer>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        ProductDAO productDAO = new ProductDAO();
        double total = 0;
        for (Map.Entry<Long, Integer> entry : cart.entrySet()) {
            Product p = productDAO.findById(entry.getKey());
            if (p != null) {
                total += p.getPrice() * entry.getValue();
            }
        }

        if (user != null && user.getAddress() != null) {
            req.setAttribute("userAddress", user.getAddress());
        }

        req.setAttribute("total", total);
        req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        Map<Long, Integer> cart = (Map<Long, Integer>) session.getAttribute("cart");

        if (user == null || cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        String shippingAddress = req.getParameter("shippingAddress");
        if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập địa chỉ nhận hàng");
            req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra tồn kho trước khi tạo đơn
        ProductDAO productDAO = new ProductDAO();
        for (Map.Entry<Long, Integer> entry : cart.entrySet()) {
            Product p = productDAO.findById(entry.getKey());
            if (p == null) {
                req.setAttribute("error", "Sản phẩm không tồn tại: " + entry.getKey());
                req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
                return;
            }
            if (entry.getValue() > p.getStock()) {
                req.setAttribute("error", "Sản phẩm " + p.getName() + " chỉ còn " + p.getStock() + " sản phẩm. Vui lòng giảm số lượng.");
                req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
                return;
            }
        }

        Order order = new Order();
        order.setUser(user);
        order.setShippingAddress(shippingAddress);
        order.setPaymentMethod("QR");
        order.setStatus("PENDING");

        if (order.getOrderDetails() == null) {
            order.setOrderDetails(new ArrayList<>());
        }

        double total = 0;
        for (Map.Entry<Long, Integer> entry : cart.entrySet()) {
            Product p = productDAO.findById(entry.getKey());
            if (p != null) {
                total += p.getPrice() * entry.getValue();
                OrderDetail detail = new OrderDetail();
                detail.setOrder(order);
                detail.setProduct(p);
                detail.setQuantity(entry.getValue());
                detail.setPrice(p.getPrice());
                order.getOrderDetails().add(detail);
            }
        }
        order.setTotal(total);

        OrderDAO orderDAO = new OrderDAO();
        orderDAO.save(order);

        cart.clear();

        double deposit = total * 0.2;
        String finalTransferContent = transferContent.replace("#ORDER_ID", String.valueOf(order.getId()));

        req.setAttribute("orderId", order.getId());
        req.setAttribute("total", total);
        req.setAttribute("deposit", deposit);
        req.setAttribute("qrImageUrl", qrImageUrl);
        req.setAttribute("bankName", bankName);
        req.setAttribute("accountHolder", accountHolder);
        req.setAttribute("accountNumber", accountNumber);
        req.setAttribute("transferContent", finalTransferContent);
        req.setAttribute("userFullName", user.getFullName());

        req.getRequestDispatcher("/checkout-qr.jsp").forward(req, resp);
    }
}