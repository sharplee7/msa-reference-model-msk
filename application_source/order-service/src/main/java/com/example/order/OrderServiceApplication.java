package com.example.order;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import com.amazonaws.xray.spring.aop.XRayEnabled;

@XRayEnabled
@SpringBootApplication
@EntityScan(basePackages={"com.example.common.domain"})
public class OrderServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(OrderServiceApplication.class, args);
	}

}
