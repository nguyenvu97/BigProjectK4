package org.springframework.boot.ticket.service.impl;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.boot.apiclient.exception.NotFound;
import org.springframework.boot.ticket.dto.Requet.SearchFlight;
import org.springframework.boot.ticket.dto.Response.FlightResponse;
import org.springframework.boot.ticket.entity.Flight;
import org.springframework.boot.ticket.mapper.FlightMapper;
import org.springframework.boot.ticket.repository.FlightRepository;
import org.springframework.boot.ticket.service.FlightService;
import org.springframework.core.convert.ConversionService;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.text.DateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class FlightServiceImpl implements FlightService {
    private final FlightRepository flightRepository;
    private final FlightMapper flightMapper;

    @Override
    public FlightResponse getFlight(int flightId) {
        Flight flight = flightRepository.findById(flightId).orElse(null);
        return flightMapper.toEntity(flight);
    }

    @Override
    @Async
    public List<FlightResponse> getData(SearchFlight searchFlight,int number) {
        if (number <= 0) {
            throw new NotFound("input number must be greater than 0");
        } else {
            switch (number) {
                case 1:
                    return getFlight(searchFlight.startDate, searchFlight.endDate, searchFlight.departure, searchFlight.arrival);
                case 2:
                    return getFlight(searchFlight.endDate, "", searchFlight.arrival, searchFlight.departure);
            }
        }
        return null;
    }

    @Async
    @Override
    public List<FlightResponse> getFlight(String startDate, String endDate, String departure, String arrival) {
         DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        List<FlightResponse> primaryFlight = new ArrayList<>();

        List<FlightResponse> secondaryFlight = new ArrayList<>();

        List<FlightResponse> additionalFlightResponses = new ArrayList<>();
        LocalDateTime startTime = LocalDateTime.parse(startDate, formatter);
        List<Flight> flights = flightRepository.countPreviousSegment(startTime,arrival,departure);
        if (flights.isEmpty()) {
            throw  new NotFound("not found");
        }
        primaryFlight = flights.stream().map(
                flight1 -> { return  flightMapper.toEntityWithNoFlights(flight1,null); }
        ).collect(Collectors.toList());
        additionalFlightResponses.addAll(primaryFlight);

        List<Flight> flights1 = flightRepository.findByStartTimeAndDeparture(startTime,departure);
        secondaryFlight = flights1.stream().map(
                flight -> {
                    Flight nextFlight = flightRepository.findByArrivalAndStartDate(startTime,arrival, flight.getId());
                    return nextFlight != null ?  flightMapper.toEntity(flight) : null;
                }
        ).filter(Objects::nonNull) .collect(Collectors.toList());
        additionalFlightResponses.addAll(secondaryFlight);

        return additionalFlightResponses;
    }
}


