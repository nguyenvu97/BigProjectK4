package org.springframework.boot.login;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;

@SpringBootApplication(
        scanBasePackages = {
                "org.springframework.boot.apiclient",
                "org.springframework.boot.login"

        }
)
@EnableFeignClients(
        basePackages = "org.springframework.boot.apiclient"
)

@PropertySources({
        @PropertySource("classpath:appClient-default.properties")
})
public class LoginApplication {

    public static void main(String[] args) {
        SpringApplication.run(LoginApplication.class, args);
    }

}
