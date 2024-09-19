package org.springframework.boot.upload.email;

import org.springframework.boot.apiclient.email.EmailDto;

public interface EmailSender {
    void sendemail(EmailDto emailDto);
}
