package org.springframework.boot.ticket.repository;

import org.springframework.boot.ticket.entity.Zone;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository

public interface ZoneRepository extends JpaRepository<Zone,Integer> {
}
