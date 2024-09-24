package org.springframework.boot.ticket.mapper;

import org.mapstruct.Mapper;
import org.springframework.boot.apiclient.mapper.MapperAll;
import org.springframework.boot.apiclient.mapper.MapperConfig;
import org.springframework.boot.ticket.dto.AircraftDto;
import org.springframework.boot.ticket.entity.Aircraft;

import java.util.List;

@Mapper(config = MapperConfig.class)
public interface AircraftMapper extends MapperAll<Aircraft, AircraftDto> {
    @Override
    Aircraft toDto(AircraftDto aircraftDto);

    @Override
    AircraftDto toEntity(Aircraft aircraft);

    @Override
    List<Aircraft> toListEntity(List<AircraftDto> d);

    @Override
    List<AircraftDto> toListDto(List<Aircraft> e);
}
