package org.springframework.boot.ticket.mapper;

import org.mapstruct.Mapper;
import org.springframework.boot.apiclient.mapper.MapperAll;
import org.springframework.boot.apiclient.mapper.MapperConfig;
import org.springframework.boot.ticket.dto.AirlineDto;
import org.springframework.boot.ticket.entity.Airline;

import java.util.List;

@Mapper(config = MapperConfig.class)
public interface AirlineMapper extends MapperAll<Airline, AirlineDto> {
    @Override
    Airline toDto(AirlineDto airlineDto);

    @Override
    AirlineDto toEntity(Airline airline);

    @Override
    List<Airline> toListEntity(List<AirlineDto> d);

    @Override
    List<AirlineDto> toListDto(List<Airline> e);
}
