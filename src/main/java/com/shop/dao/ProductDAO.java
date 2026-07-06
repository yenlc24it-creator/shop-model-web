package com.shop.dao;

import com.shop.entity.Product;
import com.shop.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class ProductDAO {

    /**
     * Lấy danh sách sản phẩm với phân trang, tìm kiếm, lọc theo danh mục và chỉ lấy sản phẩm còn hàng
     */
    public List<Product> findAll(int page, int size, String keyword, Long categoryId, boolean onlyInStock) {
        Session session = null;
        try {
            System.out.println("=== ProductDAO.findAll CALLED ===");
            session = HibernateUtil.getSessionFactory().openSession();
            System.out.println("=== SESSION OPENED ===");

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

            List<Product> result = query.list();
            System.out.println("=== FOUND " + result.size() + " PRODUCTS ===");
            return result;

        } catch (Exception e) {
            System.err.println("=== ProductDAO.findAll ERROR ===");
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lấy danh sách sản phẩm: " + e.getMessage(), e);
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
                System.out.println("=== SESSION CLOSED ===");
            }
        }
    }

    /**
     * Đếm tổng số sản phẩm (có hỗ trợ tìm kiếm, lọc danh mục, chỉ lấy còn hàng)
     */
    public long count(String keyword, Long categoryId, boolean onlyInStock) {
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();

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

        } catch (Exception e) {
            System.err.println("=== ProductDAO.count ERROR ===");
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi đếm sản phẩm: " + e.getMessage(), e);
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }
    }

    // ===== OVERLOAD METHODS (giữ nguyên để tương thích code cũ) =====

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

    // ===== CRUD METHODS =====

    /**
     * Tìm sản phẩm theo ID
     */
    public Product findById(Long id) {
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            return session.get(Product.class, id);
        } catch (Exception e) {
            System.err.println("=== ProductDAO.findById ERROR ===");
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi tìm sản phẩm: " + e.getMessage(), e);
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }
    }

    /**
     * Lưu hoặc cập nhật sản phẩm
     */
    public void save(Product product) {
        Transaction tx = null;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            session.saveOrUpdate(product);
            tx.commit();
            System.out.println("=== Product SAVED: " + product.getName() + " ===");
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (Exception rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            System.err.println("=== ProductDAO.save ERROR ===");
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lưu sản phẩm: " + e.getMessage(), e);
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }
    }

    /**
     * Xóa sản phẩm
     */
    public void delete(Product product) {
        Transaction tx = null;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            session.delete(product);
            tx.commit();
            System.out.println("=== Product DELETED: " + product.getName() + " ===");
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (Exception rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            System.err.println("=== ProductDAO.delete ERROR ===");
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi xóa sản phẩm: " + e.getMessage(), e);
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }
    }
}