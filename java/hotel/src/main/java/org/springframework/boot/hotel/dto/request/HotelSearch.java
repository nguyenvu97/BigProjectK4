package org.springframework.boot.hotel.dto.request;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.hotel.dto.PagingDto;
import org.springframework.boot.hotel.entity.Enum.CategoryType;

import java.awt.dnd.DropTargetEvent;
import java.time.LocalDate;
import java.util.Date;

@Setter
@Getter
public class HotelSearch extends PagingDto {
    private  String address;
    private int numberPeople;
    private int numberRoom;
    private CategoryType categoryType;
    private double minMoney;
    private double maxMoney;
    private int startHotel;
    private String startTime;
    private String endTime;


}
