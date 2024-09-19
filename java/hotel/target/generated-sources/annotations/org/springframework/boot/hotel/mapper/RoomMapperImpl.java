package org.springframework.boot.hotel.mapper;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.processing.Generated;
import org.springframework.boot.hotel.dto.RoomDto;
import org.springframework.boot.hotel.entity.Enum.CategoryType;
import org.springframework.boot.hotel.entity.Enum.RoomStatus;
import org.springframework.boot.hotel.entity.Room;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2024-09-19T10:22:12+0700",
    comments = "version: 1.5.5.Final, compiler: javac, environment: Java 20.0.1 (Oracle Corporation)"
)
@Component
public class RoomMapperImpl implements RoomMapper {

    @Override
    public Room toDto(RoomDto roomDto) {
        if ( roomDto == null ) {
            return null;
        }

        Room.RoomBuilder room = Room.builder();

        room.id( roomDto.getId() );
        room.price( roomDto.getPrice() );
        room.numberPeople( roomDto.getNumberPeople() );
        room.numberRoom( roomDto.getNumberRoom() );
        if ( roomDto.getCategoryType() != null ) {
            room.categoryType( Enum.valueOf( CategoryType.class, roomDto.getCategoryType() ) );
        }
        if ( roomDto.getRoomStatus() != null ) {
            room.roomStatus( Enum.valueOf( RoomStatus.class, roomDto.getRoomStatus() ) );
        }

        return room.build();
    }

    @Override
    public RoomDto toEntity(Room room) {
        if ( room == null ) {
            return null;
        }

        RoomDto roomDto = new RoomDto();

        roomDto.setId( room.getId() );
        roomDto.setPrice( room.getPrice() );
        roomDto.setNumberPeople( room.getNumberPeople() );
        roomDto.setNumberRoom( room.getNumberRoom() );
        if ( room.getCategoryType() != null ) {
            roomDto.setCategoryType( room.getCategoryType().name() );
        }
        if ( room.getRoomStatus() != null ) {
            roomDto.setRoomStatus( room.getRoomStatus().name() );
        }

        return roomDto;
    }

    @Override
    public List<Room> toListEntity(List<RoomDto> d) {
        if ( d == null ) {
            return null;
        }

        List<Room> list = new ArrayList<Room>( d.size() );
        for ( RoomDto roomDto : d ) {
            list.add( toDto( roomDto ) );
        }

        return list;
    }

    @Override
    public List<RoomDto> toListDto(List<Room> e) {
        if ( e == null ) {
            return null;
        }

        List<RoomDto> list = new ArrayList<RoomDto>( e.size() );
        for ( Room room : e ) {
            list.add( toEntity( room ) );
        }

        return list;
    }
}
