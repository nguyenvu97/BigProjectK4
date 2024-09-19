package org.springframework.boot.ticket.dto;

import lombok.Data;

@Data
public class AirportDto {
    private long id;
    private String airportName;
    private String location;
}
