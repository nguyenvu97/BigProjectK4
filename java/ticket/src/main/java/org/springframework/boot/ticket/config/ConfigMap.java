package org.springframework.boot.ticket.config;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Data
@Configuration
public class ConfigMap {
    @Value("${appConfig.default-page-size}")

    public  int pageSize;
    @Value("${appConfig.default-page-number}")
    public   int pageNumber;
}
