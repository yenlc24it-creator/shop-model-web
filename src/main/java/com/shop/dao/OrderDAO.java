package com.shop.dao;

import com.shop.entity.Order;
import com.shop.entity.OrderDetail;
import com.shop.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class OrderDAO {

    public void save(Order order) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.save(order);
            for (OrderDetail detail : order.getOrderDetails()) {
                session.save(detail);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }

    public Order findById(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Order.class, id);
        }
    }

    public Order findByIdWithDetails(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Order> query = session.createQuery(
                    "select o from Order o left join fetch o.orderDetails where o.id = :id", Order.class);
            query.setParameter("id", id);
            return query.uniqueResult();
        }
    }

    public List<Order> findByUserId(Long userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Order> query = session.createQuery(
                    "from Order where user.id = :userId order by orderDate desc", Order.class);
            query.setParameter("userId", userId);
            return query.list();
        }
    }

    public List<Order> findAll() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Order> query = session.createQuery("from Order order by orderDate desc", Order.class);
            return query.list();
        }
    }

    public void updateStatus(Long orderId, String status) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            Order order = session.get(Order.class, orderId);
            if (order != null) {
                order.setStatus(status);
                session.update(order);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }
}