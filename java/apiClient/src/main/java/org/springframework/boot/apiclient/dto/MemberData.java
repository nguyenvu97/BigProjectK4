package org.springframework.boot.apiclient.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.scheduling.annotation.Async;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MemberData {
    private long id;
    private String sub;
    private long iat;
    private long exp;
    private String role;
    private String aliases;
    private String fullName;
    private String address;
    private String phone;

}