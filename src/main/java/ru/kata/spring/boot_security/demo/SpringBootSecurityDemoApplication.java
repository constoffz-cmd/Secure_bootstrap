package ru.kata.spring.boot_security.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import ru.kata.spring.boot_security.demo.model.User;
import ru.kata.spring.boot_security.demo.service.UserService;


@SpringBootApplication
public class SpringBootSecurityDemoApplication implements CommandLineRunner {

	private final UserService userService;

	@Autowired
	public SpringBootSecurityDemoApplication(UserService userService) {
		this.userService = userService;
	}

	public static void main(String[] args) {
		SpringApplication.run(SpringBootSecurityDemoApplication.class, args);
	}

	// Этот метод автоматически запустится ПОСЛЕ старта приложения
	@Override
	public void run(String... args) throws Exception {

		// Проверяем, есть ли уже админ (используем ваш метод findByUsername)
		if (userService.findByUsername("admin") == null) {
			User admin = new User();
			admin.setUsername("admin");
			admin.setPassword("admin"); // Пароль в чистом виде, saveUser его захеширует
			admin.setEmail("admin@mail.ru");
			admin.setFirstName("Admin");
			admin.setLastName("Adminov");

			// Метод saveUser из вашего сервиса захеширует пароль и даст ROLE_USER
			userService.saveUser(admin);

			System.out.println("----------------------------------------------");
			System.out.println("ТЕСТОВЫЙ ПОЛЬЗОВАТЕЛЬ СОЗДАН: admin / admin");
			System.out.println("----------------------------------------------");
		}
	}
}
