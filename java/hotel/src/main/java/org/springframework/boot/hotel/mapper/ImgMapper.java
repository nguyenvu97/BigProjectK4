package org.springframework.boot.hotel.mapper;

import org.mapstruct.Mapper;
import org.springframework.boot.apiclient.mapper.MapperAll;
import org.springframework.boot.apiclient.mapper.MapperConfig;
import org.springframework.boot.hotel.dto.ImageDto;
import org.springframework.boot.hotel.entity.Image;


import java.util.List;

@Mapper(config = MapperConfig.class)
public interface ImgMapper extends MapperAll<Image, ImageDto> {
    @Override
    Image toDto(ImageDto imageDto);

    @Override
    ImageDto toEntity(Image image);

    @Override
    List<Image> toListEntity(List<ImageDto> d);

    @Override
    List<ImageDto> toListDto(List<Image> e);
}
