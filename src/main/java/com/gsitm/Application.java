package com.gsitm;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.batch.BatchAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.ImportResource;

import com.gsitm.base.config.MybatisConfiguration;

import de.codecentric.boot.admin.config.EnableAdminServer;

@Import(MybatisConfiguration.class)
@ImportResource("classpath:batch/job-*.xml")
@EnableAdminServer
@SpringBootApplication(exclude={BatchAutoConfiguration.class})
public class Application extends SpringBootServletInitializer {
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(Application.class);
    }

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}
}