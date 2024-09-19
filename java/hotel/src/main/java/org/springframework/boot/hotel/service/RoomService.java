package org.springframework.boot.hotel.service;

import org.springframework.boot.hotel.dto.RoomDto;
import org.springframework.boot.hotel.entity.Enum.CategoryType;
import org.springframework.boot.hotel.entity.Enum.RoomStatus;
import org.springframework.boot.hotel.entity.Room;
import org.springframework.boot.hotel.projection.RoomData;

import java.text.ParseException;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

public interface RoomService {
    String add(List<Room> room,long hotelId);
    List<RoomDto>findByHotelId(Long hotelId);

    RoomData countRoomsByHotelId(Long hotelId, CategoryType categoryType, int numberPeople, int numberRoom, String startTime, String endTime) ;
}
