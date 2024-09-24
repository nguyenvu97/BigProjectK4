package org.springframework.boot.ticket.entity;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.boot.ticket.entity.Enum.StatusTicket;

import java.lang.annotation.Documented;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

// set mongo db vao luu truc tiep vso do
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
//@Document(collection = "orderTicket")
@Builder
public class Ticket {
    @Id
    private long id;
    private String orderNo;
    private String email;
    private String phone;
    private String customType;
    private double amountTotal;
    private List<Map<String,String>> flights = new ArrayList<>();
    private List<Map<String,String>> hotels = new ArrayList<>();

}
