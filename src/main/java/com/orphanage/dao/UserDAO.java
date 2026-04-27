package com.orphanage.dao;

import com.orphanage.model.User;
import java.sql.SQLException;

public interface UserDAO {
    int registerUser(User user) throws SQLException;
    User loginUser(String email, String rawHash) throws SQLException;
    User getUserById(int id) throws SQLException;
    User findByEmailWithAuth(String email) throws SQLException;
    boolean emailExists(String email) throws SQLException;
}
