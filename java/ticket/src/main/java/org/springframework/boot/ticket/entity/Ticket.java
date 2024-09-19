//package org.springframework.boot.ticket.entity;
//
//import jakarta.persistence.*;
//import lombok.*;
//import org.springframework.boot.ticket.entity.Enum.StatusTicket;
//
//import java.math.BigDecimal;
//import java.util.Date;
//@Setter
//@Getter
//@AllArgsConstructor
//@NoArgsConstructor
//@Entity
//@Builder
//public class Ticket {
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    @Column(name = "id")
//    private long id;
//
//    private int flightId;
//
//    private String ticketNo;
//    private String flightNumber;
//    private String departureAirportName;
//    private Date departureTime;
//    private String arrivalAirportName;
//    private Date arrivalTime;
//    private String aliases;
//    private String fullName;
//    private String email;
//    private String phone;
//    private String customType;
//
//    @Column(name = "promotionId")
//    private Integer member;
//
//    private String numberSeats;
//    private String typeSeats;
//
//    @Column(precision = 10, scale = 2)
//    private BigDecimal amountTicket;
//
//    @Column(precision = 10, scale = 2)
//    private BigDecimal amountTotal;
//
//    private TicketType ticketType;
//
//    @Column(name = "dateBooking")
//    private Date dateBooking;
//
//    @Enumerated(EnumType.STRING)
//    private StatusTicket statusTicket;
//
//    @ManyToOne
//    @JoinColumn(name = "flightId", insertable = false, updatable = false)
//    private FlightSegment flight;
//}
