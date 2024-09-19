package org.springframework.boot.hotel.mapper;

import org.mapstruct.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.apiclient.mapper.MapperAll;
import org.springframework.boot.apiclient.mapper.MapperConfig;
import org.springframework.boot.hotel.dto.HotelDto;

import org.springframework.boot.hotel.dto.ImageDto;
import org.springframework.boot.hotel.dto.request.HotelSearch;
import org.springframework.boot.hotel.entity.Enum.CategoryType;
import org.springframework.boot.hotel.entity.Hotel;
import org.springframework.boot.hotel.entity.Image;
import org.springframework.boot.hotel.repository.RoomRepository;
import org.springframework.boot.hotel.service.BookService;
import org.springframework.boot.hotel.service.RoomService;


import java.util.List;

@Mapper(config = MapperConfig.class,
        uses = {ImgMapper.class,
                RoomMapper.class}

)
public interface HotelMapper extends MapperAll<Hotel, HotelDto> {
    @Override
    Hotel toDto(HotelDto hotelDto);



    @Override
    List<Hotel> toListEntity(List<HotelDto> d);

    @Override
    List<HotelDto> toListDto(List<Hotel> e);


    @Override
    @Mappings({
//            @Mapping(target = "count", expression = "Java()")
    })
    HotelDto toEntity(Hotel hotel);


}
