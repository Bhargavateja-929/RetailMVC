package com.Retail.dao;

import com.Retail.model.User;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAO {
    private final JdbcTemplate jdbcTemplate;

    public UserDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public boolean validateUser(User user) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ? AND password = ?";
        Integer count = jdbcTemplate.queryForObject(sql, new Object[]{user.getEmail(), user.getPassword()}, Integer.class);
        return count != null && count > 0;
    }

    public boolean isEmailRegistered(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";
        Integer count = jdbcTemplate.queryForObject(sql, new Object[]{email}, Integer.class);
        return count != null && count > 0;
    }

    public boolean registerUser(User user) {
        String sql = "INSERT INTO Users (FirstName, LastName, Gender, PhoneNumber, Email, Password, City, State, Country, PostalCode) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        int rows = jdbcTemplate.update(sql, user.getFirstName(), user.getLastName(), user.getGender(), 
                                       user.getPhoneNumber(), user.getEmail(), user.getPassword(), 
                                       user.getCity(), user.getState(), user.getCountry(), user.getPostalCode());
        return rows > 0;
    }
}
