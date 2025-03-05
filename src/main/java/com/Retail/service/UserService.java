package com.Retail.service;

import com.Retail.dao.UserDAO;
import com.Retail.model.User;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    private final UserDAO userDAO;

    public UserService(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    public boolean loginUser(User user) {
        return userDAO.validateUser(user);
    }

    public boolean registerUser(User user) {
        if (userDAO.isEmailRegistered(user.getEmail())) {
            return false;  // Email already exists
        }
        return userDAO.registerUser(user);
    }
}
