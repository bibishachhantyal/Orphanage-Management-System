package orphanage.service;

import orphanage.dao.UserDAO;
import orphanage.model.User;
import orphanage.util.PasswordUtil;

public class UserService {
    private final UserDAO userDAO = new UserDAO();

    public ServiceResult<User> register(String username, String email, String password,
                                       String confirm, String fullName, String phone, String address) {
        if (username == null || username.isBlank()
                || email == null || email.isBlank()
                || password == null || password.isBlank()) {
            return ServiceResult.fail("Username, email, and password are required.");
        }
        if (!password.equals(confirm)) {
            return ServiceResult.fail("Passwords do not match.");
        }
        if (!PasswordUtil.isStrongPassword(password)) {
            return ServiceResult.fail("Password must be at least 8 characters and include uppercase, lowercase, a number, and a special character (e.g. Admin@123).");
        }
        if (userDAO.usernameExists(username)) {
            return ServiceResult.fail("Username is already taken.");
        }
        if (userDAO.emailExists(email)) {
            return ServiceResult.fail("Email is already registered.");
        }
        if (phone != null && !phone.isBlank() && userDAO.phoneExists(phone)) {
            return ServiceResult.fail("Phone number is already registered to another account.");
        }

        User user = new User();
        user.setUsername(username.trim());
        user.setEmail(email.trim());
        user.setPassword_hash(PasswordUtil.hashPassword(password));
        user.setRole("USER");
        user.setApproved(false);
        user.setFullName(fullName == null || fullName.isBlank() ? null : fullName.trim());
        user.setPhone(phone == null || phone.isBlank() ? null : phone.trim());
        user.setAddress(address == null || address.isBlank() ? null : address.trim());
        userDAO.save(user);
        return ServiceResult.ok(user);
    }

    public ServiceResult<User> authenticate(String username, String password) {
        if (username == null || username.isBlank() || password == null || password.isBlank()) {
            return ServiceResult.fail("Invalid username or password.");
        }
        User user = userDAO.findByUsername(username.trim());
        if (user == null || !PasswordUtil.checkPassword(password, user.getPassword_hash())) {
            return ServiceResult.fail("Invalid username or password.");
        }
        if (!user.isApproved()) {
            return ServiceResult.fail("Your account is pending admin approval.");
        }
        return ServiceResult.ok(user);
    }

    public User findById(int id) {
        return userDAO.findById(id);
    }

    public ServiceResult<User> updateProfile(int userId, String fullName, String email, String phone,
                                             String address, String currentPassword,
                                             String newPassword, String confirmPassword) {
        User user = userDAO.findById(userId);
        if (user == null) {
            return ServiceResult.fail("Account not found.");
        }
        if (email == null || email.isBlank()) {
            return ServiceResult.fail("Email is required.");
        }
        if (userDAO.emailExistsForOther(email.trim(), userId)) {
            return ServiceResult.fail("Email is already registered to another account.");
        }
        if (phone != null && !phone.isBlank() && userDAO.phoneExistsForOther(phone.trim(), userId)) {
            return ServiceResult.fail("Phone number is already registered to another account.");
        }

        boolean changingPassword = newPassword != null && !newPassword.isBlank();
        if (changingPassword) {
            if (currentPassword == null || currentPassword.isBlank()) {
                return ServiceResult.fail("Enter your current password to set a new one.");
            }
            if (!PasswordUtil.checkPassword(currentPassword, user.getPassword_hash())) {
                return ServiceResult.fail("Current password is incorrect.");
            }
            if (!newPassword.equals(confirmPassword)) {
                return ServiceResult.fail("New passwords do not match.");
            }
            if (!PasswordUtil.isStrongPassword(newPassword)) {
                return ServiceResult.fail("New password must meet strength requirements (e.g. Admin@123).");
            }
            user.setPassword_hash(PasswordUtil.hashPassword(newPassword));
        }

        user.setFullName(fullName == null || fullName.isBlank() ? null : fullName.trim());
        user.setEmail(email.trim());
        user.setPhone(phone == null || phone.isBlank() ? null : phone.trim());
        user.setAddress(address == null || address.isBlank() ? null : address.trim());
        if (!userDAO.updateProfile(user)) {
            return ServiceResult.fail("Could not save profile. Please try again.");
        }
        return ServiceResult.ok(userDAO.findById(userId));
    }
}
