package org.springframework.boot.hotel.service.impl;

import lombok.RequiredArgsConstructor;
import org.hibernate.annotations.Any;
import org.springframework.boot.apiclient.auth.Jwt;
import org.springframework.boot.apiclient.dto.MemberData;
import org.springframework.boot.apiclient.exception.NotFound;
import org.springframework.boot.hotel.dto.BookingDto;
import org.springframework.boot.hotel.entity.Booking;
import org.springframework.boot.hotel.entity.Enum.BookingStatus;
import org.springframework.boot.hotel.entity.Room;
import org.springframework.boot.hotel.mapper.BookingMapper;
import org.springframework.boot.hotel.repository.BookingRepository;
import org.springframework.boot.hotel.repository.HotelRepository;
import org.springframework.boot.hotel.repository.RoomRepository;
import org.springframework.boot.hotel.service.BookService;
import org.springframework.boot.hotel.service.RoomService;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

@Service
@RequiredArgsConstructor
@Transactional(rollbackFor = Exception.class)
public class BookServiceImpl implements BookService {
    private final BookingRepository bookingRepository;
    private final HotelRepository hotelRepository;
    private final RoomRepository roomRepository;
    private final BookingMapper bookingMapper;
    private final Jwt jwt;

    @Override
    @Async
    public BookingDto add(Booking booking, long roomId) {
        if ( !hotelRepository.existsById(booking.getHotelId())){
            throw new NotFound("Hotel Not Found");
        }
        if (roomId< 0){
            throw new NotFound("Room Not Found");
        }

        String orderNo = orderNo();
            Date now = new Date();
            Room room =  roomRepository.findById(roomId).orElseThrow(()->new NotFound("Room Not Found"));

            int date = booking.getCheckOutDate().getDate() -booking.getCheckInDate().getDate()-1 ;
            Booking booking1 =bookingRepository.save(Booking
                            .builder()
                            .bookingDate(now)
                            .stayNight(date)
                            .bookingStatus(BookingStatus.CONFIRMED)
                            .checkInDate(booking.getCheckInDate())
                            .checkOutDate(booking.getCheckOutDate())
                            .hotelId(booking.getHotelId())
                            .roomId(room.getId())
                            .quantityRoom(room.getNumberRoom())
                            .totalPrice(room.getPrice() * booking.getQuantityRoom() * date)
                            .numberPeople(booking.getNumberPeople())
                            .orderNo(orderNo)
                            .email(booking.getEmail())
                            .phoneNumber(booking.getPhoneNumber())
                            .userName(booking.getUserName())
                            .roomCategory(booking.getRoomCategory())
                            .hotelName(booking.getHotelName())
                            .build());

        return bookingMapper.toEntity(booking1);


    }

    @Override
    @Async
    public BookingDto add(Booking booking, long roomId, String token) {
        MemberData memberData = jwt.decode(token);
        if (memberData == null){
            throw new NotFound("Invalid token");
        }
        return add(booking,roomId);
    }

    @Override
    @Async
    public List<BookingDto> search(String orderNo) {
        if (orderNo.isEmpty()){
            throw new NotFound("Order Not Found");
        }
        return bookingRepository.findByOrderNo(orderNo);
    }

    private String orderNo(){
        Random random = new Random();
        return "orderNo"+random.nextInt(10000);
    }
}
