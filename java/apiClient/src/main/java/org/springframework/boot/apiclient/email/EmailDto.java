package org.springframework.boot.apiclient.email;

import lombok.Data;

@Data

public class EmailDto {
    public String to;
    public String email;
    public String body;
}
