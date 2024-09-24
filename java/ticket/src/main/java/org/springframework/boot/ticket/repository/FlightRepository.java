package org.springframework.boot.ticket.repository;

import org.springframework.boot.ticket.entity.Flight;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@Repository
public interface FlightRepository extends JpaRepository<Flight, Integer> {

    @Query("select f from Flight as f where  f.fromCity = :departure and f.departureTime >= :startDate ")
    List<Flight> findByStartTimeAndDeparture(@Param(value = "startDate") LocalDateTime startDate, @Param(value = "departure") String departure);

    @Query("select f from Flight as f where  f.toCity = :arrival and f.departureTime >= :startDate and  f.previousSegment.id = :id ")
    Flight findByArrivalAndStartDate(@Param(value = "startDate") LocalDateTime startDate,@Param(value = "arrival")String arrival,@Param(value = "id")int flight);


    @Query("select f from Flight as f where f.toCity = :arrival and f.fromCity = :departure and f.departureTime >= :startDate")
    List<Flight> countPreviousSegment(@Param(value = "startDate") LocalDateTime startDate,@Param(value = "arrival")String arrival,@Param(value = "departure")String departure);


}
