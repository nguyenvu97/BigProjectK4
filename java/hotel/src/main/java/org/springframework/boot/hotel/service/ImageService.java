package org.springframework.boot.hotel.service;

import org.springframework.boot.hotel.dto.HotelDto;
import org.springframework.boot.hotel.dto.ImageDto;
import org.springframework.boot.hotel.entity.Hotel;
import org.springframework.boot.hotel.entity.Image;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface ImageService {
    void add(List<MultipartFile> fileList, Hotel hotel)throws IOException;
    byte[] uploadFilesImage(String fileName) throws IOException;
}
