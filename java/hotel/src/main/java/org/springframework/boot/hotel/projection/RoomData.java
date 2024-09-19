package org.springframework.boot.hotel.projection;

public interface RoomData {
    long getRoomId();
    int getCountRoom();
    double getRoomPrice();
    String getCategoryType();
}
