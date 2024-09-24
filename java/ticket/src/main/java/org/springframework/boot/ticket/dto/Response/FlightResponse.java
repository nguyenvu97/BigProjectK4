package org.springframework.boot.ticket.dto.Response;

import jakarta.persistence.Column;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FlightResponse {

    private int id;

    private String fromCity;

    private String toCity;

    private LocalDateTime departureTime;

    private LocalDateTime arrivalTime;

    private BigDecimal basePrice;

    private int reservedSeats;

    private int reservedBusinessSeats;

    private int economySeats;

    private int businessSeats;

    private int totalSeats;

    private String airline;

    private List<FlightResponse> flights;



}
