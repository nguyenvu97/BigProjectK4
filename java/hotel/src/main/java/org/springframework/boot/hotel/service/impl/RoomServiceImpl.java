package org.springframework.boot.hotel.service.impl;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.apiclient.exception.NotFound;
import org.springframework.boot.hotel.dto.RoomDto;
import org.springframework.boot.hotel.entity.Enum.CategoryType;
import org.springframework.boot.hotel.entity.Enum.RoomStatus;
import org.springframework.boot.hotel.entity.Hotel;
import org.springframework.boot.hotel.entity.Image;
import org.springframework.boot.hotel.entity.Room;
import org.springframework.boot.hotel.mapper.RoomMapper;
import org.springframework.boot.hotel.projection.RoomData;
import org.springframework.boot.hotel.repository.HotelRepository;
import org.springframework.boot.hotel.repository.RoomRepository;
import org.springframework.boot.hotel.service.RoomService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@RequiredArgsConstructor
@Service
@Transactional
public class RoomServiceImpl implements RoomService {
    private final RoomRepository roomRepository;
    private final HotelRepository hotelRepository;
    private final RoomMapper roomMapper;
    private  final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    @Async
    @Override
    public String add(List<Room> room,long hotelId) {
        List<Room> rooms = new ArrayList<>();
        if (hotelId > 0 && room.isEmpty()) {
            throw new NotFound("data not good");
        }
        Hotel hotel = hotelRepository.findById(hotelId).orElseThrow(()->  new NotFound("hotel not found"));
                for (Room room1 : room) {
                    room1.setHotel(hotel);
                    room1.setCategoryType(room1.getCategoryType());
                    room1.setRoomStatus(RoomStatus.Open);
                    rooms.add(room1);

                }
                roomRepository.saveAll(room);
                return "Ok";

    }

    @Override
    @Async
    public List<RoomDto> findByHotelId(Long hotelId) {
        List<Room> rooms = roomRepository.findByHotelIdAndStatus(hotelId,RoomStatus.Off);
        return roomMapper.toListDto(rooms);
    }


    @Override
    @Async
    public RoomData countRoomsByHotelId(Long hotelId, CategoryType categoryType, int numberPeople, int numberRoom, String startTime, String endTime)  {
        if (numberPeople <= 0 || numberRoom <= 0) {
            numberPeople = 2;
            numberRoom = 1;
        }
        System.out.println("Counting rooms with hotelId: " + hotelId + ", categoryType: " + categoryType + ", numberPeople: " + numberPeople + ", numberRoom: " + numberRoom + ", startTime: " + startTime + ", endTime: " + endTime);
        LocalDate startDate = LocalDate.parse(startTime);
        LocalDate endDate = LocalDate.parse(endTime);
        var roomData = roomRepository.countByHotelId(hotelId,categoryType,numberPeople,numberRoom,RoomStatus.Open,
                startDate,
                endDate );
            return roomData;





    }

}
