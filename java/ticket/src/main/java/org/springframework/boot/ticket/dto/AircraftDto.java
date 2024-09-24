package org.springframework.boot.ticket.dto;

import jakarta.persistence.Column;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class AircraftDto {
    private int id;
    private String type;
    private String code;
    private int totalSeats;
    private int economySeats;
    private int businessSeats;
    private double pricePerKm;
    private int status;
}
