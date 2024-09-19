package org.springframework.boot.ticket.repository;

import org.springframework.boot.ticket.entity.FlightSegment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FlightSegmentRepository extends JpaRepository<FlightSegment, Integer> {
}
