package org.springframework.boot.ticket.entity;


import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.Collection;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "aircarf")
public class Aircraft {
    @Id
    @Column(name = "id")
    private int id;


    @Column(length = 50,name = "type")
    private String type;


    @Column(length = 250,name = "code")
    private String code;
    @Column(name = "totalSeats")
    private Integer totalSeats;
    @Column(name = "economySeats")
    private int economySeats;
    @Column(name = "businessseats")
    private int businessSeats;
    @Column(name = "price_per_km")
    private double pricePerKm;
    @Column(name = "status")
    private int status;



    @ManyToOne
    @JoinColumn(name = "airline_id", insertable = false, updatable = false)

    private Airline airline;

    @OneToMany(mappedBy = "aircraft")
    private Collection<FlightSegment> flightSegments = new ArrayList<>();
}
