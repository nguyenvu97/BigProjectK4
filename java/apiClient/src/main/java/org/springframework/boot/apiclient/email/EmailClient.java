package org.springframework.boot.apiclient.email;


import org.springframework.boot.apiclient.dto.MemberData;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;

@FeignClient(url = "http://localhost:1003",name = "email")
@Repository
public interface EmailClient {
    @GetMapping("/api/v1/decode")
    void email(@RequestBody EmailDto emailDto);


}
