package org.springframework.boot.ticket.service.impl;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.apiclient.exception.NotFound;
import org.springframework.boot.ticket.dto.AirportDto;

import org.springframework.boot.ticket.entity.Airport;
import org.springframework.boot.ticket.entity.Zone;
import org.springframework.boot.ticket.mapper.AirportMapper;
import org.springframework.boot.ticket.repository.AirportRepository;
import org.springframework.boot.ticket.repository.ZoneRepository;
import org.springframework.boot.ticket.service.AirportService;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class AirportServiceImpl implements AirportService {
    private final AirportRepository airportRepository;
    private final AirportMapper airPortMapper;
    private final ZoneRepository zoneRepository;



    @Override
    public Map<String, List<AirportDto>> getLocal() {
        Map<String, List<AirportDto>>  local = new HashMap<>();
        List<Zone> listzone = zoneRepository.findAll();
        for (Zone zone : listzone) {
            List<Airport>data = airportRepository.findByAriport(zone.getId());

           List<AirportDto> name = data.stream().map(ariport ->{
               return  airPortMapper.toEntity(ariport);
           }).collect(Collectors.toList());

            local.put(zone.getName(),name);
        }
        return local;





    }
}
