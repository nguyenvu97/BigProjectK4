package org.springframework.boot.ticket.entity;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.util.RouteMatcher;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;


@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "flight_segment")
@Entity
public class FlightSegment {
    @Id
    @Column(name = "id")
    private int id;

    @Column(name = "fromCity")
    private String fromCity;
    @Column(name = "toCity")
    private String toCity;
    @Column(name = "de_time")
    private Date departureTime;
    @Column(name = "ar_time")
    private Date arrivalTime;
    @Column(name = "base_price" )
    private BigDecimal basePrice;
    @Column(name = "r_eseats")
    private int reservedSeats;
    @Column(name ="r_bseats" )
    private int reservedBusinessSeats;
    @Column(name = "status")
    private int status;
    @Column(name = "code")
    private String code;
    @Column(name = "note" )
    private String note;
    @Column(name = "order")
    private int order;


    @ManyToOne
    @JoinColumn(name = "previousSegmentId", insertable = false, updatable = false)
    private FlightSegment previousSegment;

    @OneToMany(mappedBy = "previousSegment")
    private Collection<FlightSegment> subsequentSegments = new ArrayList<>();

    @ManyToOne
    @JoinColumn(name = "air_id", insertable = false, updatable = false)
    private Aircraft aircraft;

    @ManyToOne
    @JoinColumn(name = "route_id", insertable = false, updatable = false)
    private Route route;

}
