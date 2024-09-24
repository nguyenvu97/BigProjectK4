package org.springframework.boot.ticket.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;
import org.springframework.boot.apiclient.mapper.MapperAll;
import org.springframework.boot.apiclient.mapper.MapperConfig;
import org.springframework.boot.ticket.dto.AirportDto;
import org.springframework.boot.ticket.entity.Airport;

import java.util.List;


@Mapper(config = MapperConfig.class)

public interface AirportMapper extends MapperAll<Airport, AirportDto> {
    @Override
    Airport toDto(AirportDto airportDto);

    @Override
    @Mappings({
            @Mapping(source = "airport.zone.name" ,target = "location" )
    })
    AirportDto toEntity(Airport airport);

    @Override
    List<Airport> toListEntity(List<AirportDto> d);

    @Override
    List<AirportDto> toListDto(List<Airport> e);
}
