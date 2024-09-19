package org.springframework.boot.hotel.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.boot.apiclient.exception.NotFound;
import org.springframework.boot.hotel.entity.Booking;
import org.springframework.boot.hotel.repository.BookingRepository;
import org.springframework.boot.hotel.service.BookService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/v1/booking")
public class BookingController {
    private final BookService bookService;


    @PostMapping("/add")
    public ResponseEntity<?> addBooking(@RequestBody Booking booking, @RequestParam long roomId) {
        try {
            return ResponseEntity.ok().body(bookService.add(booking, roomId));

        }catch (NotFound e){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getData());
        }
    }

    @PostMapping("/add/with_token")
    public ResponseEntity<?> addBookingWith_token(@RequestBody Booking booking, @RequestParam long roomId,@RequestHeader(value = "Authorization")String token) {
        try {
            return ResponseEntity.ok().body(bookService.add(booking, roomId,token));

        }catch (NotFound e){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getData());
        }
    }


    @GetMapping("/search")
    public ResponseEntity<?> search( @RequestParam String orderNo) {
        try {
            return ResponseEntity.ok().body(bookService.search(orderNo));

        }catch (NotFound e){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }
}
