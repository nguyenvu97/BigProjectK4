package org.springframework.boot.hotel.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.boot.apiclient.exception.NotFound;
import org.springframework.boot.hotel.entity.Room;
import org.springframework.boot.hotel.repository.HotelRepository;
import org.springframework.boot.hotel.repository.RoomRepository;
import org.springframework.boot.hotel.service.RoomService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/v1/room")
public class RoomController {
    private final RoomService roomService;
    private final RoomRepository roomRepository;

    @PostMapping("/add")
    public ResponseEntity<?>add(@RequestBody List<Room> rooms,@RequestParam int hotelId) {
        try{
            return ResponseEntity.ok(roomService.add(rooms,hotelId));
        }catch (NotFound e){
            return  ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getData());
        }
    }

}
