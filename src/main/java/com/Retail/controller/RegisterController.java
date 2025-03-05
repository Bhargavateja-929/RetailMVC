package com.Retail.controller;

import com.Retail.model.User;
import com.Retail.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class RegisterController {

    private final UserService userService;

    public RegisterController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/register")
    public String registerUser(
            @RequestParam String firstName,
            @RequestParam String lastName,
            @RequestParam String gender,
            @RequestParam String phoneNumber,
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam String city,
            @RequestParam String state,
            @RequestParam String country,
            @RequestParam String postalCode,
            Model model) {

        User user = new User(firstName, lastName, gender, phoneNumber, email, password, city, state, country, postalCode);

        if (userService.registerUser(user)) {
            model.addAttribute("success", "Registration successful! Please log in.");
            return "redirect:/login";
        } else {
            model.addAttribute("error", "Email already exists.");
            return "register";
        }
    }
}
