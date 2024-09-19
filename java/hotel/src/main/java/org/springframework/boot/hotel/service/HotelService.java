package org.springframework.boot.hotel.service;

import org.springframework.boot.hotel.dto.HotelDto;
import org.springframework.boot.hotel.dto.ImageDto;
import org.springframework.boot.hotel.dto.PageDto;
import org.springframework.boot.hotel.dto.request.HotelSearch;
import org.springframework.boot.hotel.entity.Hotel;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface HotelService {
    String addHotel(Hotel hotel, List<MultipartFile> images) throws IOException;

    HotelDto findByID(long id);


    byte[] listImage(String imageName) throws IOException;

//    PageDto searchHotel(HotelSearch HotelSearch);

    List<ImageDto>findImages(Long hotelId);

    PageDto searchHotel(HotelSearch hotelSearch,int sortId);
//    PageDto searchHotel(HotelSearch HotelSearch, int sortId, FilterRequest filterRequest);



}
