package org.springframework.boot.ticket.repository;

import org.springframework.boot.ticket.entity.Airport;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AirportRepository extends JpaRepository<Airport, Integer> {
    @Query("select a from  Airport as a where a.zone.id = :id")
    List<Airport> findByAriport(@Param(value = "id") int id);
}
