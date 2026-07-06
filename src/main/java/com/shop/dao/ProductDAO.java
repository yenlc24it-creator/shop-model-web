package com.shop.dao;

import com.shop.entity.Product;
import com.shop.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class ProductDAO {

    // Phương thức chính: thêm tham số onlyInStock để lọc sản phẩm còn hàng
    public List<Product> findAll(int page, int size, String keyword, Long categoryId, boolean onlyInStock) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "from Product where 1=1";
            if (onlyInStock) {
                hql += " and stock > 0";
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                hql += " and lower(name) like :keyword";
            }
            if (categoryId != null) {
                hql += " and category.id = :categoryId";
            }
            hql += " order by id";
            Query<Product> query = session.createQuery(hql, Product.class);
            if (keyword != null && !keyword.trim().isEmpty()) {
                query.setParameter("keyword", "%" + keyword.toLowerCase() + "%");
            }
            if (categoryId != null) {
                query.setParameter("categoryId", categoryId);
            }
            query.setFirstResult((page - 1) * size);
            query.setMaxResults(size);
            return query.list();
        }
    }

    // Phương thức count có tham số onlyInStock
    public long count(String keyword, Long categoryId, boolean onlyInStock) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "select count(*) from Product where 1=1";
            if (onlyInStock) {
                hql += " and stock > 0";
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                hql += " and lower(name) like :keyword";
            }
            if (categoryId != null) {
                hql += " and category.id = :categoryId";
            }
            Query<Long> query = session.createQuery(hql, Long.class);
            if (keyword != null && !keyword.trim().isEmpty()) {
                query.setParameter("keyword", "%" + keyword.toLowerCase() + "%");
            }
            if (categoryId != null) {
                query.setParameter("categoryId", categoryId);
            }
            return query.uniqueResult();
        }
    }

    // Các phương thức overload để tương thích với code cũ (mặc định onlyInStock = false)
    public List<Product> findAll(int page, int size, String keyword, Long categoryId) {
        return findAll(page, size, keyword, categoryId, false);
    }

    public long count(String keyword, Long categoryId) {
        return count(keyword, categoryId, false);
    }

    public List<Product> findAll(int page, int size, String keyword) {
        return findAll(page, size, keyword, null, false);
    }

    public long count(String keyword) {
        return count(keyword, null, false);
    }

    public Product findById(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Product.class, id);
        }
    }

    public void save(Product product) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.saveOrUpdate(product);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }

    public void delete(Product product) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.delete(product);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }
}