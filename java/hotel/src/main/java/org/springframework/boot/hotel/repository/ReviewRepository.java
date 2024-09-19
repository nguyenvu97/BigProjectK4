package org.springframework.boot.hotel.repository;


import org.aspectj.weaver.ast.Var;
import org.springframework.boot.hotel.entity.Review;
import org.springframework.boot.hotel.projection.ReviewCount;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long>, JpaSpecificationExecutor<Review> {
    Page<Review> findByHotelId(long hotelId, Pageable pageable);
    @Query("SELECT COALESCE(SUM(r.rating) / NULLIF(COUNT(r.hotel.id), 0), 0) as averageRating , count(r.hotel.id) as reviewCount FROM Review r WHERE r.hotel.id = :hotelId   ")
    ReviewCount getAverageRatingForHotel(@Param("hotelId") long hotelId);
    @Query("select count(r) from Review r WHERE r.hotel.id = :hotelId and r.rating =:count")
    int countHotel(@Param("count") int i,@Param("hotelId") long hotelId);




}
