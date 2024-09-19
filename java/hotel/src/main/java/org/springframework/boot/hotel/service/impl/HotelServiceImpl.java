package org.springframework.boot.hotel.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.boot.apiclient.auth.Jwt;
import org.springframework.boot.apiclient.exception.NotFound;
import org.springframework.boot.hotel.config.ConfigMap;
import org.springframework.boot.hotel.dto.HotelDto;
import org.springframework.boot.hotel.dto.ImageDto;
import org.springframework.boot.hotel.dto.PageDto;
import org.springframework.boot.hotel.dto.request.HotelSearch;
import org.springframework.boot.hotel.entity.Hotel;
import org.springframework.boot.hotel.mapper.HotelMapper;
import org.springframework.boot.hotel.mapper.ImgMapper;
import org.springframework.boot.hotel.mapper.RoomMapper;
import org.springframework.boot.hotel.projection.RoomData;
import org.springframework.boot.hotel.repository.HotelRepository;
import org.springframework.boot.hotel.service.HotelService;
import org.springframework.boot.hotel.service.ImageService;
import org.springframework.boot.hotel.service.ReviewService;
import org.springframework.boot.hotel.service.RoomService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;

import java.text.ParseException;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import static org.springframework.boot.hotel.spec.HotelSpec.*;

@Service
@RequiredArgsConstructor
public class HotelServiceImpl implements HotelService {
    private final HotelRepository hotelRepository;
    private final ImageService imageService;
    private final HotelMapper hotelMapper;
    private final RoomMapper roomMapper;
    private final ImgMapper imgMapper;
    private final Jwt jwt;
    private final ConfigMap configMap;

    private final ReviewService reviewService;
    private final RoomService roomService;


    @Override
    @Async
    public String addHotel(Hotel hotel, List<MultipartFile> images) throws IOException {
//        MemberData memberData = jwt.decode(token);
//        if (memberData.getRole().equals("USER")){
//            throw new NotFound("Role not allowed");
//        }
        imageService.add(images,hotelRepository.save(hotel));
        return "Ok";
    }

    @Override
    @Async
    public HotelDto findByID(long id)  {
        if (id <=0){
            throw new NotFound("id < 0");
        }
        Hotel hotel = hotelRepository.findById(id).orElse(null);
        return hotelMapper.toEntity(hotel);
    }

    @Override
    public byte[] listImage(String imageName) throws IOException {
        return imageService.uploadFilesImage(imageName);
    }
    @Override
    public List<ImageDto> findImages(Long hotelId) {
        Hotel hotel = hotelRepository.findById(hotelId).orElseThrow(null);

        return imgMapper.toListDto(hotel.getImage());
    }
    @Override
    @Async
    public PageDto searchHotel(HotelSearch hotelSearch,int sortId) {

        if (hotelSearch.getPageSize() <= 0 || hotelSearch.getPageNumber() <= 0) {
            hotelSearch.setPageSize(configMap.getPageSize());
            hotelSearch.setPageNumber(configMap.getPageNumber());

        }
        PageRequest pageRequest = PageRequest.of(hotelSearch.getPageNumber(), hotelSearch.getPageSize());

        // Tạo Specification
        Specification<Hotel> specification = searchHotelRoom1(hotelSearch,sortId);

        // Tìm kiếm và phân trang
        Page<Hotel> page = hotelRepository.findAll(specification, pageRequest);

        // Chuyển đổi thành HotelDto
        List<HotelDto> hotelDtos = page.getContent().stream()
                .map(hotel -> {

                    var count = roomService.countRoomsByHotelId(hotel.getId(), hotelSearch.getCategoryType(), hotelSearch.getNumberPeople(), hotelSearch.getNumberRoom(),hotelSearch.getStartTime(),hotelSearch.getEndTime());
                    if (count != null){
                        HotelDto hotelDto = new HotelDto();
                        hotelDto.setId(hotel.getId());
                        hotelDto.setHotelAddress(hotel.getHotelAddress());
                        hotelDto.setTitleHotel(hotel.getTitleHotel());
                        hotelDto.setStars(reviewService.startHotelId(hotel.getId()).getAverageRating());
                        hotelDto.setCountReviews(reviewService.startHotelId(hotel.getId()).getReviewCount());
                        hotelDto.setCategory(count.getCategoryType());
                        hotelDto.setCountReviews(hotelDto.getCountReviews());
                        hotelDto.setPhoneNumber(hotel.getPhoneNumber());
                        hotelDto.setWebsite(hotel.getWebsite());
                        hotelDto.setHotelName(hotel.getHotelName());
                        hotelDto.setCount(count.getCountRoom());
                        hotelDto.setImage(findImages(hotel.getId()));
                        hotelDto.setPrice(count.getRoomPrice());
                        hotelDto.setRoomId(count.getRoomId());

                        return hotelDto;
                    }


                        return null;

                }).filter(Objects::nonNull)

                .collect(Collectors.toList());

        // Tạo PageDto
        PageDto pageDto = new PageDto();
        pageDto.setPageNumber(hotelSearch.getPageNumber());
        pageDto.setPageSize(hotelSearch.getPageSize());
        pageDto.setNumber(page.getNumber());
        pageDto.setNumberOfElements(page.getNumberOfElements());
        pageDto.setTotalElements(page.getTotalElements());
        pageDto.setTotalPages(page.getTotalPages());
        pageDto.setContent(hotelDtos);

        return pageDto;
    }


}
