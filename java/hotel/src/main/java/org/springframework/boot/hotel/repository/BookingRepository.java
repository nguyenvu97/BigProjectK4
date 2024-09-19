package org.springframework.boot.hotel.repository;

import org.springframework.boot.hotel.dto.BookingDto;
import org.springframework.boot.hotel.entity.Booking;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {
    List<BookingDto> findByOrderNo(String orderNo);
}
