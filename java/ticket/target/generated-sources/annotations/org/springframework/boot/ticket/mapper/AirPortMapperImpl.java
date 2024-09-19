package org.springframework.boot.ticket.mapper;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.processing.Generated;
import org.springframework.boot.ticket.dto.AirportDto;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2024-08-25T07:11:08+0700",
    comments = "version: 1.5.5.Final, compiler: javac, environment: Java 20.0.1 (Oracle Corporation)"
)
@Component
public class AirPortMapperImpl implements AirPortMapper {

    @Override
    public Airport toDto(AirportDto airportDto) {
        if ( airportDto == null ) {
            return null;
        }

        Airport.AirportBuilder airport = Airport.builder();

        airport.id( airportDto.getId() );
        airport.airportName( airportDto.getAirportName() );
        airport.location( airportDto.getLocation() );

        return airport.build();
    }

    @Override
    public AirportDto toEntity(Airport airport) {
        if ( airport == null ) {
            return null;
        }

        AirportDto airportDto = new AirportDto();

        airportDto.setId( airport.getId() );
        airportDto.setAirportName( airport.getAirportName() );
        airportDto.setLocation( airport.getLocation() );

        return airportDto;
    }

    @Override
    public List<Airport> toListEntity(List<AirportDto> d) {
        if ( d == null ) {
            return null;
        }

        List<Airport> list = new ArrayList<Airport>( d.size() );
        for ( AirportDto airportDto : d ) {
            list.add( toDto( airportDto ) );
        }

        return list;
    }

    @Override
    public List<AirportDto> toListDto(List<Airport> e) {
        if ( e == null ) {
            return null;
        }

        List<AirportDto> list = new ArrayList<AirportDto>( e.size() );
        for ( Airport airport : e ) {
            list.add( toEntity( airport ) );
        }

        return list;
    }
}
