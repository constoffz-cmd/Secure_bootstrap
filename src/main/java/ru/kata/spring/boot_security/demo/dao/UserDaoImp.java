package ru.kata.spring.boot_security.demo.dao;

import org.springframework.stereotype.Repository;
import web.model.User;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Repository
public class UserDaoImp implements UserDao {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public void saveUser(User user) {

        entityManager.persist(user);
    }

    @Override
    public List<User> listUsers() {

        return entityManager.createQuery("from User", User.class).getResultList();
    }

    public User getUserById(Long id) {

        User user = entityManager.find(User.class, id);
        return user;
    }

    @Override
    public void updateUser(User user) {

        entityManager.merge(user);
    }

    @Override
    public void deleteUser(Long id) {
        User user = entityManager.find(User.class, id);
        if (user != null) {
            entityManager.remove(user);
        }

    }

}