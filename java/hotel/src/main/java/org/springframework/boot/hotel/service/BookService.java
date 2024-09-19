package org.springframework.boot.hotel.service;

import org.springframework.boot.hotel.dto.BookingDto;
import org.springframework.boot.hotel.entity.Booking;

import java.util.List;


public interface BookService {

    BookingDto add(Booking booking, long roomId);
    BookingDto add(Booking booking, long roomId,String jwt);
    List<BookingDto> search(String orderNo);

}
