package org.springframework.boot.ticket;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;

@SpringBootApplication(
		scanBasePackages = {
				"org.springframework.boot.apiclient",
				"org.springframework.boot.ticket"

		}
)
@EnableFeignClients(
		basePackages = "org.springframework.boot.apiclient"
)

@PropertySources({
		@PropertySource("classpath:appClient-default.properties")
})
public class TicketApplication {

	public static void main(String[] args) {
		SpringApplication.run(TicketApplication.class, args);
	}

}
