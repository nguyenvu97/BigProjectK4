package org.springframework.boot.ticket.mapper;


import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;
import org.springframework.boot.apiclient.mapper.MapperAll;
import org.springframework.boot.apiclient.mapper.MapperConfig;
import org.springframework.boot.ticket.dto.Response.FlightResponse;
import org.springframework.boot.ticket.entity.Flight;

import java.util.List;

@Mapper(config = MapperConfig.class,uses = {
        AircraftMapper.class,
        AirlineMapper.class})
public interface FlightMapper  extends MapperAll<Flight, FlightResponse> {
    @Override
    Flight toDto(FlightResponse flightResponse);

    @Mappings({

            @Mapping(source = "flightSegment.aircraft.totalSeats",target = "totalSeats"),
            @Mapping(source = "flightSegment.aircraft.economySeats",target = "economySeats"),
            @Mapping(source = "flightSegment.aircraft.businessSeats",target = "businessSeats"),
            @Mapping(source = "flightSegment.aircraft.airline.name",target = "airline"),
            @Mapping(source = "flightSegment.subsequentSegments", target = "flights")

    })
    FlightResponse toEntity(Flight flightSegment);


    @Mappings({
            @Mapping(source = "flightSegment.aircraft.totalSeats", target = "totalSeats"),
            @Mapping(source = "flightSegment.aircraft.economySeats", target = "economySeats"),
            @Mapping(source = "flightSegment.aircraft.businessSeats", target = "businessSeats"),
            @Mapping(source = "flightSegment.aircraft.airline.name", target = "airline"),
            @Mapping(target = "flights", expression = "java(null)")
    })
    FlightResponse toEntityWithNoFlights(Flight flightSegment,String data);


    @Override
    List<Flight> toListEntity(List<FlightResponse> d);

    @Override

    List<FlightResponse> toListDto(List<Flight> e);


}


