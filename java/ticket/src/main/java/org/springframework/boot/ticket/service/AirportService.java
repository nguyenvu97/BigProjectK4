package org.springframework.boot.ticket.service;

import org.springframework.boot.ticket.dto.AirportDto;

import java.util.List;
import java.util.Map;

public interface AirportService {
    Map<String, List<AirportDto>>  getLocal();
}
