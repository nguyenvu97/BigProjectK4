package org.springframework.boot.ticket.dto.Requet;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SearchFlight {


    public String startDate;
    public String endDate;
    public String departure;
    public String arrival;

}
