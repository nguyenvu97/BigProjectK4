package org.springframework.boot.hotel.repository;

import org.springframework.boot.hotel.entity.Image;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ImageRepository extends JpaRepository<Image, Long> {
    Image findByImg(String imageName);
}
