package org.springframework.boot.apiclient.auth;

import org.springframework.boot.apiclient.dto.MemberData;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;

@FeignClient(name = "user",url = "http://localhost:1001")
@Repository
public interface Jwt {
    @GetMapping("/api/v1/decode")
    MemberData decode(@RequestHeader("Authorization")String token);
}
