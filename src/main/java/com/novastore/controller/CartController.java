package com.novastore.controller;

import com.novastore.dao.ProductDAO;
import com.novastore.model.Product;
import com.novastore.model.ShoppingCart;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class CartController extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        
        if (cart == null) {
            cart = new ShoppingCart();
            session.setAttribute("cart", cart);
        }
        
        request.getRequestDispatcher("/WEB-INF/views/cart/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");

        if (cart == null) {
            cart = new ShoppingCart();
            session.setAttribute("cart", cart);
        }

        switch (action) {
            case "update":
                updateCartItem(request, response, cart);
                break;
            case "remove":
                removeCartItem(request, response, cart);
                break;
            case "clear":
                cart.clear();
                response.sendRedirect("cart");
                break;
            default:
                response.sendRedirect("cart");
        }
    }

    private void updateCartItem(HttpServletRequest request, HttpServletResponse response, ShoppingCart cart) 
            throws IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            Product product = productDAO.getProductById(productId);
            if (product != null && quantity > 0 && quantity <= product.getStockQuantity()) {
                cart.updateQuantity(productId, quantity);
            }
        } catch (NumberFormatException e) {
            // Invalid input, ignore
        }
        response.sendRedirect("cart");
    }

    private void removeCartItem(HttpServletRequest request, HttpServletResponse response, ShoppingCart cart) 
            throws IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            cart.removeItem(productId);
        } catch (NumberFormatException e) {
            // Invalid input, ignore
        }
        response.sendRedirect("cart");
    }
} 