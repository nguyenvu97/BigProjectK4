package org.springframework.boot.hotel.dto;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.hotel.entity.Enum.BookingStatus;

import java.util.Date;

@Setter
@Getter
public class BookingDto {
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
