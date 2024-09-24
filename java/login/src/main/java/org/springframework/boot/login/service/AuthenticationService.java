package org.springframework.boot.login.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.boot.login.auth.AuthenticationRequest;
import org.springframework.boot.login.auth.AuthenticationResponse;
import org.springframework.boot.login.auth.RegisterRequest;
import org.springframework.security.core.Authentication;

import java.io.IOException;

public interface AuthenticationService {
     AuthenticationResponse register (RegisterRequest request);
    AuthenticationResponse login(AuthenticationRequest request, HttpServletResponse response);
    void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication);
    void refreshToken(HttpServletRequest request, HttpServletResponse response) throws IOException;
}
