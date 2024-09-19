package org.springframework.boot.hotel.service;

import org.springframework.boot.hotel.dto.PageDto;
import org.springframework.boot.hotel.dto.PagingDto;
import org.springframework.boot.hotel.dto.ReviewDto;
import org.springframework.boot.hotel.entity.Review;
import org.springframework.boot.hotel.projection.ReviewCount;

import java.util.List;
import java.util.Map;

public interface ReviewService {

    String createReview(ReviewDto review );

    PageDto getReviews(long hotelId, int pageNumber);

    ReviewCount startHotelId(long hotelId);
    Map<Integer, Integer> start_Sequentially(long hotelId);


    int start(long userId,long reviewId );
}
