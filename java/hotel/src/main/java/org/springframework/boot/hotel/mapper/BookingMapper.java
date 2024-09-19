package org.springframework.boot.hotel.mapper;

import lombok.RequiredArgsConstructor;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.apiclient.mapper.MapperAll;
import org.springframework.boot.apiclient.mapper.MapperConfig;
import org.springframework.boot.hotel.dto.BookingDto;
import org.springframework.boot.hotel.entity.Booking;
import org.springframework.boot.hotel.repository.HotelRepository;
import org.springframework.boot.hotel.repository.RoomRepository;
import org.springframework.boot.hotel.service.HotelService;

import java.util.List;

@Mapper(config = MapperConfig.class,
        uses = {ImgMapper.class, RoomMapper.class,HotelMapper.class}
)

public interface BookingMapper extends MapperAll<Booking, BookingDto> {

    @Override
    Booking toDto(BookingDto bookingDto);

    @Override
    BookingDto toEntity(Booking booking);

    @Override
    List<Booking> toListEntity(List<BookingDto> d);

    @Override
    List<BookingDto> toListDto(List<Booking> e);

}
