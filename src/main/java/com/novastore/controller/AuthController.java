package com.novastore.controller;

import com.novastore.dao.UserDAO;
import com.novastore.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ResourceBundle;

public class AuthController extends HttpServlet {
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getServletPath();
        String language = request.getParameter("lang");
        if (language != null) {
            request.getSession().setAttribute("language", language);
        }
        
        switch (action) {
            case "/login":
                showLoginForm(request, response);
                break;
            case "/register":
                showRegisterForm(request, response);
                break;
            case "/logout":
                logout(request, response);
                break;
            default:
                response.sendRedirect("home");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getServletPath();
        
        switch (action) {
            case "/login":
                processLogin(request, response);
                break;
            case "/register":
                processRegistration(request, response);
                break;
            default:
                response.sendRedirect("home");
        }
    }
    
    private void showLoginForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }
    
    private void showRegisterForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
    }
    
    private void processLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        User user = userDAO.authenticate(email, password);
        
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("home");
        } else {
            request.setAttribute("error", "Invalid email or password");
            showLoginForm(request, response);
        }
    }
    
    private void processRegistration(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email");
        
        if (userDAO.isEmailExists(email)) {
            request.setAttribute("error", "Email already exists");
            showRegisterForm(request, response);
            return;
        }
        
        User user = new User();
        user.setFirstName(request.getParameter("firstName"));
        user.setLastName(request.getParameter("lastName"));
        user.setEmail(email);
        user.setPassword(request.getParameter("password"));
        user.setAddress(request.getParameter("address"));
        user.setPhoneNumber(request.getParameter("phoneNumber"));
        
        if (userDAO.registerUser(user)) {
            request.setAttribute("success", "Registration successful. Please login.");
            showLoginForm(request, response);
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            showRegisterForm(request, response);
        }
    }
    
    private void logout(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("login");
    }
} 