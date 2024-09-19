package org.springframework.boot.hotel.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.*;
import org.springframework.boot.hotel.entity.Enum.BookingStatus;

import java.time.LocalDate;
import java.util.Date;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class Booking {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;    
    private String orderNo;
    private Date bookingDate;
    private Date checkInDate;
    private Date checkOutDate;
    private int numberPeople;
    private double totalPrice;
    private int quantityRoom;
    private int stayNight;
    private String userName;
    private String email;
    private String phoneNumber;
    private long roomId;
    private BookingStatus bookingStatus;
    private long hotelId;
    private String roomCategory;
    private String hotelName;

}
