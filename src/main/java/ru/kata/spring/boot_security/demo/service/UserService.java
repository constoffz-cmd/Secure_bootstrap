package ru.kata.spring.boot_security.demo.service;


import web.model.User;

import java.util.List;

public interface UserService {
    void saveUser(User user);

    List<User> listUsers();

    User getUserById(Long Id);

    void updateUser(User user);

    void deleteUser(Long id);
}