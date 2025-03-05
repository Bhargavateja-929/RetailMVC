package com.Retail.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")  
    public String showWelcomePage() {
        return "welcome"; // Resolves to /WEB-INF/views/welcome.jsp
    }

    @GetMapping("/login")
    public String showLoginPage() {
        return "login"; // Resolves to /WEB-INF/views/login.jsp
    }

    @GetMapping("/register")
    public String showRegisterPage() {
        return "register"; // Resolves to /WEB-INF/views/register.jsp
    }

    @GetMapping("/dashboard")
    public String showDashboardPage() {
        return "dashboard"; // Resolves to /WEB-INF/views/dashboard.jsp
    }
}
