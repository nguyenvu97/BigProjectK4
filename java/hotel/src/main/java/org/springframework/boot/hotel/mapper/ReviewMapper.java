package org.springframework.boot.hotel.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mappings;
import org.springframework.boot.apiclient.mapper.MapperAll;
import org.springframework.boot.apiclient.mapper.MapperConfig;
import org.springframework.boot.hotel.dto.ImageDto;
import org.springframework.boot.hotel.dto.ReviewDto;
import org.springframework.boot.hotel.entity.Image;
import org.springframework.boot.hotel.entity.Review;

import java.util.List;

@Mapper(config = MapperConfig.class)
public interface ReviewMapper extends MapperAll<Review, ReviewDto> {
    @Override
//    @Mappings({
//
//    })
    Review toDto(ReviewDto reviewDto);

    @Override
    ReviewDto toEntity(Review review);

    @Override
    List<Review> toListEntity(List<ReviewDto> d);

    @Override
    List<ReviewDto> toListDto(List<Review> e);
}
