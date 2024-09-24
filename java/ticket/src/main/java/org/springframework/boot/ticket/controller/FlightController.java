package org.springframework.boot.ticket.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.boot.apiclient.exception.NotFound;
import org.springframework.boot.ticket.dto.Requet.SearchFlight;
import org.springframework.boot.ticket.repository.AirportRepository;
import org.springframework.boot.ticket.repository.FlightRepository;
import org.springframework.boot.ticket.service.FlightService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Date;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/v1/flight")
public class FlightController {
    private final FlightService flightService;


    @GetMapping
    public ResponseEntity<?>getAll(@RequestParam int flightId){

        return ResponseEntity.ok(flightService.getFlight(flightId));
    }

    @GetMapping("/list")
    public ResponseEntity<?> getFlights(@RequestBody SearchFlight searchFlight , @RequestParam int number){
        try{
            return ResponseEntity.ok(flightService.getData(searchFlight,number));
        }
        catch (NotFound n){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(n.getData());
        }


    }
}
