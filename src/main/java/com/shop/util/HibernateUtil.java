package com.shop.util;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {
    private static final SessionFactory sessionFactory = buildSessionFactory();

    private static SessionFactory buildSessionFactory() {
        try {
            System.out.println("=== START HIBERNATE INIT ===");
            Configuration configuration = new Configuration();

            // Cách 1: Thử load từ hibernate.cfg.xml
            try {
                configuration.configure();
                System.out.println("=== LOADED hibernate.cfg.xml ===");
            } catch (Exception e) {
                System.out.println("=== hibernate.cfg.xml NOT FOUND, trying hibernate.properties ===");
                // Cách 2: Load từ hibernate.properties
                configuration.configure("hibernate.properties");
                System.out.println("=== LOADED hibernate.properties ===");
            }

            System.out.println("=== BUILDING SESSION FACTORY ===");
            return configuration.buildSessionFactory();
        } catch (Throwable ex) {
            System.err.println("=== HIBERNATE ERROR ===");
            ex.printStackTrace();
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public static void shutdown() {
        getSessionFactory().close();
    }
}