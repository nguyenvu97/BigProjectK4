package org.springframework.boot.ticket.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.boot.ticket.service.AirportService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/v1/Airport")
public class AirportController {
    private final AirportService airportService;

    @GetMapping("/all")
    public ResponseEntity<?> all() {
        return ResponseEntity.ok(airportService.getLocal());
    }
}
