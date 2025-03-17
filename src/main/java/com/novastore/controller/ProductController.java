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
import java.util.List;

public class ProductController extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getServletPath();
        String category = request.getParameter("category");
        
        // Initialize shopping cart if it doesn't exist
        HttpSession session = request.getSession();
        if (session.getAttribute("cart") == null) {
            session.setAttribute("cart", new ShoppingCart());
        }

        switch (action) {
            case "/products":
                if (category != null && !category.isEmpty()) {
                    List<Product> products = productDAO.getProductsByCategory(category);
                    request.setAttribute("products", products);
                } else {
                    List<Product> products = productDAO.getAllProducts();
                    request.setAttribute("products", products);
                }
                List<String> categories = productDAO.getAllCategories();
                request.setAttribute("categories", categories);
                request.setAttribute("selectedCategory", category);
                request.getRequestDispatcher("/WEB-INF/views/product/list.jsp").forward(request, response);
                break;

            case "/product":
                String productId = request.getParameter("id");
                if (productId != null) {
                    Product product = productDAO.getProductById(Integer.parseInt(productId));
                    if (product != null) {
                        request.setAttribute("product", product);
                        request.getRequestDispatcher("/WEB-INF/views/product/detail.jsp").forward(request, response);
                        return;
                    }
                }
                response.sendRedirect("products");
                break;

            default:
                response.sendRedirect("products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getServletPath();
        HttpSession session = request.getSession();
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");

        if (cart == null) {
            cart = new ShoppingCart();
            session.setAttribute("cart", cart);
        }

        switch (action) {
            case "/add-to-cart":
                try {
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    Product product = productDAO.getProductById(productId);
                    
                    if (product != null && quantity > 0 && quantity <= product.getStockQuantity()) {
                        cart.addItem(product, quantity);
                        response.getWriter().write("success");
                    } else {
                        response.getWriter().write("error");
                    }
                } catch (NumberFormatException e) {
                    response.getWriter().write("error");
                }
                break;

            default:
                response.sendRedirect("products");
        }
    }
} 