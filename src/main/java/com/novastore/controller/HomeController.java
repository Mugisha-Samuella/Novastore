package com.novastore.controller;

import com.novastore.dao.ProductDAO;
import com.novastore.model.Product;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class HomeController extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get featured products (you can modify this to get specific products)
            List<Product> featuredProducts = productDAO.getAllProducts();
            request.setAttribute("featuredProducts", featuredProducts);
            
            // Forward to home page
            request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
} 