package com.example.customer;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import com.amazonaws.xray.spring.aop.XRayEnabled;

@XRayEnabled
@SpringBootApplication(scanBasePackages={
		"com.example"})
@EnableAspectJAutoProxy
public class CustomerServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(CustomerServiceApplication.class, args);
	}

}
