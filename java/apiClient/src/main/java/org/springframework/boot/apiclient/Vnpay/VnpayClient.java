package org.springframework.boot.apiclient.Vnpay;

import org.springframework.boot.apiclient.dto.ResultDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(url = "http://localhost:1003",name = "vnpay")
@Repository
public interface VnpayClient {
    @GetMapping("/payUser")
    public ResponseEntity<?> hashUrl(@RequestHeader("Authorization") String token , @RequestParam String orderNo);

    @GetMapping("/domain.vn")
    public String Transaction(
            @RequestParam(value = "vnp_Amount") long amount,
            @RequestParam(value = "vnp_BankCode") String BankCode,
            @RequestParam(value = "vnp_OrderInfo") String OrderInfo,
            @RequestParam(value = "vnp_ResponseCode") String responseCode,
            @RequestParam(value = "vnp_TxnRef") String vnp_TxnRef,
            @RequestParam(value = "vnp_TransactionNo") String vnp_TransactionNo
    );
}
