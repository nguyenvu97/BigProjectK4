package org.springframework.boot.hotel.mapper;

import org.mapstruct.Mapper;
import org.springframework.boot.apiclient.mapper.MapperAll;
import org.springframework.boot.apiclient.mapper.MapperConfig;
import org.springframework.boot.hotel.dto.RoomDto;
import org.springframework.boot.hotel.entity.Room;

import java.util.List;

@Mapper(config = MapperConfig.class
)
public interface RoomMapper extends MapperAll<Room, RoomDto> {
    @Override
    Room toDto(RoomDto roomDto);

    @Override
    RoomDto toEntity(Room room);

    @Override
    List<Room> toListEntity(List<RoomDto> d);

    @Override
    List<RoomDto> toListDto(List<Room> e);
}
