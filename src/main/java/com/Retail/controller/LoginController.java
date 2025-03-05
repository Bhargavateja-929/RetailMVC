package com.Retail.controller;

import com.Retail.model.User;
import com.Retail.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class LoginController {

    private final UserService userService;

    public LoginController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/login")
    @ResponseBody  // Ensure JSON response
    public Map<String, String> loginUser(
            @RequestParam String email,
            @RequestParam String password,
            HttpServletRequest request) {

        Map<String, String> response = new HashMap<>();
        User user = new User(email, password);

        if (userService.loginUser(user)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", email);  // Store user session
            response.put("status", "success");
            response.put("redirectUrl", "dashboard"); // Redirect to dashboard
        } else {
            response.put("status", "error");
            response.put("message", "Incorrect email or password.");
        }
        return response;
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.invalidate();
        return "redirect:/";
    }
}
