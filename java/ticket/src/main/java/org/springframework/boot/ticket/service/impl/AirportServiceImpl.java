//package org.springframework.boot.ticket.service.impl;
//
//import jakarta.transaction.Transactional;
//import lombok.RequiredArgsConstructor;
//import org.springframework.boot.apiclient.exception.NotFound;
//import org.springframework.boot.ticket.dto.AirportDto;
//import org.springframework.boot.ticket.mapper.AirPortMapper;
//import org.springframework.scheduling.annotation.Async;
//import org.springframework.stereotype.Service;
//
//import java.util.ArrayList;
//import java.util.List;
//
//@Service
//@RequiredArgsConstructor
//@Transactional
//public class AirportServiceImpl implements AirportService {
//    private final AirportRepository airportRepository;
//    private final AirPortMapper airPortMapper;
//
//    @Override
//    @Async
//    public String add(List<Airport> airports) {
//        List<Airport> airports1 = new ArrayList<>();
//        if (airports == null){
//            throw new NotFound("airports cannot be null");
//        }
//        for (Airport airport : airports) {
//            airports1.add(airport);
//        }
//        airportRepository.saveAllAndFlush(airports1);
//        return "Ok";
//    }
//
//    @Override
//    @Async
//    public List<AirportDto> GetAllLocaltion() {
//        List<Airport> airports = airportRepository.findAll();
//        return airPortMapper.toListDto(airports);
//    }
//}
