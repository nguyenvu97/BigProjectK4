package org.springframework.boot.ticket.service;

import org.springframework.boot.ticket.dto.Requet.SearchFlight;
import org.springframework.boot.ticket.dto.Response.FlightResponse;


import java.util.List;
import java.util.Optional;

public interface FlightService {
    FlightResponse getFlight(int flightId);

    List<FlightResponse> getData(SearchFlight searchFlight,int number);

    List<FlightResponse> getFlight(String startDate, String endDat, String departure, String arrival);

}
