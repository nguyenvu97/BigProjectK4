package org.springframework.boot.hotel.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.boot.apiclient.exception.NotFound;
import org.springframework.boot.hotel.config.ConfigMap;
import org.springframework.boot.hotel.dto.PageDto;
import org.springframework.boot.hotel.dto.PagingDto;
import org.springframework.boot.hotel.dto.ReviewDto;
import org.springframework.boot.hotel.entity.Hotel;
import org.springframework.boot.hotel.entity.Review;
import org.springframework.boot.hotel.mapper.ReviewMapper;
import org.springframework.boot.hotel.projection.ReviewCount;
import org.springframework.boot.hotel.repository.HotelRepository;
import org.springframework.boot.hotel.repository.ReviewRepository;
import org.springframework.boot.hotel.service.ReviewService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ReviewServiceImpl implements ReviewService {
    private final ReviewRepository reviewRepository;
    private final HotelRepository hotelRepository;
    private final ConfigMap configMap;
    private final ReviewMapper reviewMapper;

    @Override
    public String createReview(ReviewDto review) {
        if (review == null){
            throw new NotFound("Review is null");
        }
        Date now = new Date();
        Hotel hotel = hotelRepository.findById(review.getHotelId()).orElseThrow(()->new NotFound("no hotel found"));
        reviewRepository.save(Review
                .builder()
                        .rating(review.getRating())
                        .hotel(hotel)
                        .comment(review.getComment())
                        .email(review.getEmail())
                        .time(now)
                .build());
        return "Ok";
    }

    @Override
    public PageDto getReviews(long hotelId, int pagNumber) {
        if (hotelId <= 0){
            throw new NotFound("hotelId is null");
        }

        Pageable pageable = PageRequest.of(pagNumber,configMap.getPageSize());
        Page<Review> reviews = reviewRepository.findByHotelId(hotelId,pageable);
        List<ReviewDto> listReviews = reviews.getContent().stream().map(
                review -> reviewMapper.toEntity(review)
        ).collect(Collectors.toList());
        PageDto pageDto = new PageDto();
        pageDto.setPageNumber(pagNumber);
        pageDto.setPageSize(configMap.getPageSize());
        pageDto.setTotalElements(reviews.getTotalElements());
        pageDto.setContent(listReviews);
        pageDto.setNumberOfElements(reviews.getNumberOfElements());
        pageDto.setTotalPages(reviews.getTotalPages());
        return pageDto;
    }

    @Override
    public ReviewCount startHotelId(long hotelId) {
        if (hotelId <= 0){
            throw new NotFound("hotelId is null");
        }
        return  reviewRepository.getAverageRatingForHotel(hotelId) ;
    }

    @Override
    public Map<Integer, Integer> start_Sequentially(long hotelId) {
        if (hotelId <= 0){
            throw  new NotFound("hotelId is null");
        }

        Map<Integer, Integer> ratingCounts = new HashMap<>();
        for (int i = 1; i < 6; i++) {
            int count = reviewRepository.countHotel(i,hotelId);
            ratingCounts.put(i,count);
        }

        return ratingCounts;
    }

    @Override
    public int start(long userId, long reviewId) {
        if(userId <= 0 || reviewId <= 0){
            throw  new NotFound("userId and hotelId is null");
        }
        
        return 0;
    }


}
