package org.springframework.boot.ticket.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.Collection;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "airport")
public class Airport {
    @Id
    @Column(name = "id")
    private int id;
    @Column(name = "code")
    private String code;

    @Column(name = "name")
    private String name;
    @OneToMany(mappedBy = "departurePort")
    private Collection<Route> departureRoutes = new ArrayList<>();

    @OneToMany(mappedBy = "arrivalPort")
    private Collection<Route> arrivalRoutes = new ArrayList<>();
}
