package org.springframework.boot.hotel.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Builder
public class Review {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String email;
    private String comment;
    private double rating;
    private Date time;
    @ManyToOne
    @JoinColumn(name = "hotel_id")
    public Hotel hotel;
}
