//package org.springframework.boot.ticket.controller;
//
//import lombok.RequiredArgsConstructor;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//
//import java.util.List;
//
//@RestController
//@RequiredArgsConstructor
//@RequestMapping("api/v1")
//public class AirportController {
//    private final AirportService airportService;
//    @PostMapping("/add")
//    public ResponseEntity<?> add(@RequestBody List<Airport> airport) {
//        return ResponseEntity.ok(airportService.add(airport));
//    }
//    @GetMapping("/all")
//    public ResponseEntity<?> all() {
//        return ResponseEntity.ok(airportService.GetAllLocaltion());
//    }
//}
