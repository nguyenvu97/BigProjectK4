package org.springframework.boot.ticket.mapper;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.annotation.processing.Generated;
import org.springframework.boot.ticket.dto.Response.FlightResponse;
import org.springframework.boot.ticket.entity.Aircraft;
import org.springframework.boot.ticket.entity.Airline;
import org.springframework.boot.ticket.entity.Flight;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2024-09-23T21:31:01+0700",
    comments = "version: 1.5.5.Final, compiler: javac, environment: Java 20.0.1 (Oracle Corporation)"
)
@Component
public class FlightMapperImpl implements FlightMapper {

    @Override
    public Flight toDto(FlightResponse flightResponse) {
        if ( flightResponse == null ) {
            return null;
        }

        Flight.FlightBuilder flight = Flight.builder();

        flight.id( flightResponse.getId() );
        flight.fromCity( flightResponse.getFromCity() );
        flight.toCity( flightResponse.getToCity() );
        flight.departureTime( flightResponse.getDepartureTime() );
        flight.arrivalTime( flightResponse.getArrivalTime() );
        flight.basePrice( flightResponse.getBasePrice() );
        flight.reservedSeats( flightResponse.getReservedSeats() );
        flight.reservedBusinessSeats( flightResponse.getReservedBusinessSeats() );

        return flight.build();
    }

    @Override
    public FlightResponse toEntity(Flight flightSegment) {
        if ( flightSegment == null ) {
            return null;
        }

        FlightResponse flightResponse = new FlightResponse();

        flightResponse.setTotalSeats( flightSegmentAircraftTotalSeats( flightSegment ) );
        flightResponse.setEconomySeats( flightSegmentAircraftEconomySeats( flightSegment ) );
        flightResponse.setBusinessSeats( flightSegmentAircraftBusinessSeats( flightSegment ) );
        flightResponse.setAirline( flightSegmentAircraftAirlineName( flightSegment ) );
        flightResponse.setFlights( flightCollectionToFlightResponseList( flightSegment.getSubsequentSegments() ) );
        flightResponse.setId( flightSegment.getId() );
        flightResponse.setFromCity( flightSegment.getFromCity() );
        flightResponse.setToCity( flightSegment.getToCity() );
        flightResponse.setDepartureTime( flightSegment.getDepartureTime() );
        flightResponse.setArrivalTime( flightSegment.getArrivalTime() );
        flightResponse.setBasePrice( flightSegment.getBasePrice() );
        flightResponse.setReservedSeats( flightSegment.getReservedSeats() );
        flightResponse.setReservedBusinessSeats( flightSegment.getReservedBusinessSeats() );

        return flightResponse;
    }

    @Override
    public FlightResponse toEntityWithNoFlights(Flight flightSegment, String data) {
        if ( flightSegment == null && data == null ) {
            return null;
        }

        FlightResponse flightResponse = new FlightResponse();

        if ( flightSegment != null ) {
            flightResponse.setTotalSeats( flightSegmentAircraftTotalSeats( flightSegment ) );
            flightResponse.setEconomySeats( flightSegmentAircraftEconomySeats( flightSegment ) );
            flightResponse.setBusinessSeats( flightSegmentAircraftBusinessSeats( flightSegment ) );
            flightResponse.setAirline( flightSegmentAircraftAirlineName( flightSegment ) );
            flightResponse.setId( flightSegment.getId() );
            flightResponse.setFromCity( flightSegment.getFromCity() );
            flightResponse.setToCity( flightSegment.getToCity() );
            flightResponse.setDepartureTime( flightSegment.getDepartureTime() );
            flightResponse.setArrivalTime( flightSegment.getArrivalTime() );
            flightResponse.setBasePrice( flightSegment.getBasePrice() );
            flightResponse.setReservedSeats( flightSegment.getReservedSeats() );
            flightResponse.setReservedBusinessSeats( flightSegment.getReservedBusinessSeats() );
        }
        flightResponse.setFlights( null );

        return flightResponse;
    }

    @Override
    public List<Flight> toListEntity(List<FlightResponse> d) {
        if ( d == null ) {
            return null;
        }

        List<Flight> list = new ArrayList<Flight>( d.size() );
        for ( FlightResponse flightResponse : d ) {
            list.add( toDto( flightResponse ) );
        }

        return list;
    }

    @Override
    public List<FlightResponse> toListDto(List<Flight> e) {
        if ( e == null ) {
            return null;
        }

        List<FlightResponse> list = new ArrayList<FlightResponse>( e.size() );
        for ( Flight flight : e ) {
            list.add( toEntity( flight ) );
        }

        return list;
    }

    private int flightSegmentAircraftTotalSeats(Flight flight) {
        if ( flight == null ) {
            return 0;
        }
        Aircraft aircraft = flight.getAircraft();
        if ( aircraft == null ) {
            return 0;
        }
        int totalSeats = aircraft.getTotalSeats();
        return totalSeats;
    }

    private int flightSegmentAircraftEconomySeats(Flight flight) {
        if ( flight == null ) {
            return 0;
        }
        Aircraft aircraft = flight.getAircraft();
        if ( aircraft == null ) {
            return 0;
        }
        int economySeats = aircraft.getEconomySeats();
        return economySeats;
    }

    private int flightSegmentAircraftBusinessSeats(Flight flight) {
        if ( flight == null ) {
            return 0;
        }
        Aircraft aircraft = flight.getAircraft();
        if ( aircraft == null ) {
            return 0;
        }
        int businessSeats = aircraft.getBusinessSeats();
        return businessSeats;
    }

    private String flightSegmentAircraftAirlineName(Flight flight) {
        if ( flight == null ) {
            return null;
        }
        Aircraft aircraft = flight.getAircraft();
        if ( aircraft == null ) {
            return null;
        }
        Airline airline = aircraft.getAirline();
        if ( airline == null ) {
            return null;
        }
        String name = airline.getName();
        if ( name == null ) {
            return null;
        }
        return name;
    }

    protected List<FlightResponse> flightCollectionToFlightResponseList(Collection<Flight> collection) {
        if ( collection == null ) {
            return null;
        }

        List<FlightResponse> list = new ArrayList<FlightResponse>( collection.size() );
        for ( Flight flight : collection ) {
            list.add( toEntity( flight ) );
        }

        return list;
    }
}
