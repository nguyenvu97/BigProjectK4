package org.springframework.boot.upload.Vnpay;



import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.apiclient.auth.Jwt;
import org.springframework.boot.apiclient.dto.MemberData;
import org.springframework.boot.apiclient.dto.ResultDto;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.*;

import static org.springframework.boot.upload.Vnpay.Config.*;


@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("api/vnpay")
public class PaymaentController {
    public final Jwt jwtDecoder1;

    public final VnpayRepo vnpayRepo;

//    private final OrderDetailsRepo orderDetailsRepo;
//    private final OrderItemRepo orderItemRepo;

    /*
    *Cart Test
    * Ngân hàng	NCB
Số thẻ	9704198526191432198
Tên chủ thẻ	NGUYEN VAN A
Ngày phát hành	07/15
Mật khẩu OTP	123456
    *
    * */

/*
*
* customer pay
*
* */
    @GetMapping("/payUser")
    public ResponseEntity<?> hashUrl(@RequestHeader("Authorization") String token ,@RequestParam String orderNo) {
        MemberData memberData = jwtDecoder1.decode(token);
//        OrderItem order = orderItemRepo.findByEmailAndOrderNo(memberData.getSub(),orderNo);
//       if (order == null){
//           return null;
//       }
//        long amount = (long) order.getPayment();
//        String vnp_OrderType = order.getOrderNo();
        String vnp_OrderType = "orderType";
        int amount = 100;
        String vnp_TxnRef = Config.getRandomNumber(8);
        String vnp_IpAddr = "192.168.1.15";
        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Amount", String.valueOf( amount *100));
        vnp_Params.put("vnp_Command", vnp_Command);
        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);
        vnp_Params.put("vnp_Locale", "vn");

        vnp_Params.put("vnp_OrderInfo", vnp_OrderType);
        vnp_Params.put("vnp_ReturnUrl", vnp_Returnurl);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_OrderType", vnp_OrderType);
        vnp_Params.put("vnp_BankCode", "NCB");
        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);
        List fieldNames = new ArrayList(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = (String) itr.next();
            String fieldValue = vnp_Params.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                //Build hash data
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII));
                //Build query
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII));
                query.append('=');
                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII));
                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }
        String queryUrl = query.toString();
        String vnp_SecureHash = Config.hmacSHA512(Config.vnp_HashSecret, hashData.toString());
        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
        String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;
        ResultDto storeDto = new ResultDto();
        storeDto.setStatus("200");
        storeDto.setMessger("Successfully");
        storeDto.setDate(LocalDateTime.now());
        storeDto.setUrl(paymentUrl);

        return ResponseEntity.status(HttpStatus.OK).body(storeDto);
    }

    @GetMapping("/domain.vn")
    public String Transaction(
            @RequestParam(value = "vnp_Amount") long amount,
            @RequestParam(value = "vnp_BankCode") String BankCode,
            @RequestParam(value = "vnp_OrderInfo") String OrderInfo,
            @RequestParam(value = "vnp_ResponseCode") String responseCode,
            @RequestParam(value = "vnp_TxnRef") String vnp_TxnRef,
            @RequestParam(value = "vnp_TransactionNo") String vnp_TransactionNo
    ) {
        ResultDto storeDto = new ResultDto();
        if (responseCode.equals("00")) {
            storeDto.setStatus("ok");
            storeDto.setMessger("thanh cong");
            vnpayinfo vnpayinfo1 = new vnpayinfo();
            vnpayinfo1.setAmount(amount / 100);
            vnpayinfo1.setBankCode(BankCode);
            vnpayinfo1.setOrderInfo(OrderInfo);
            vnpayinfo1.setResponseCode(responseCode);
            vnpayinfo1.setVnp_TxnRef(vnp_TxnRef);
            vnpayinfo1.setVnp_TransactionNo(vnp_TransactionNo);
            log.info("orderno =>" + vnp_TxnRef + "\n" + "VnPayAmount =>" + amount);
//            OrderItem orderitem = orderItemRepo.findByOrderNo(OrderInfo);


//            LocalDateTime createTime = orderitem.getCreateOrder();
//            LocalDateTime createTime = LocalDateTime.of;
            LocalDateTime currentTime = LocalDateTime.now();
//            Duration duration = Duration.between(createTime, currentTime);
//            long dayBetween = duration.toDays();
//            if (dayBetween >= 3) {
//                orderitem.setStatus(OrderStatus.SUCCESS);
//            } else {
//                orderitem.setStatus(OrderStatus.FAIL);
//            }
//            orderitem.setStatus(OrderStatus.SUCCESS);
//            orderItemRepo.save(orderitem);
//            List<OrderDetails> cartProducts = orderDetailsRepo.findByOrder_id(orderitem.getId());
//
//
//            for (OrderDetails cartproduct : cartProducts
//            ) {
//                cartproduct.setOrderStatus(OrderStatus.SUCCESS);
//                orderDetailsRepo.save(cartproduct);
//                List<Product>productEntities = Collections.singletonList(productRepo.findById(cartproduct.getProduct().getId()).orElse(null));
//                for (Product product : productEntities){
//                    product.setQuantity(product.getQuantity()-cartproduct.getQuantity());
//                }
//
//            }
            vnpayRepo.save(vnpayinfo1);
            String body = "<!DOCTYPE html>\n" + "<html>\n" + "<head>\n" + "    <title>Thanh Toán Thành Công </title>\n" + "    <style>\n" + "        body {\n" + "            font-family: Arial, sans-serif;\n" + "            text-align: center;\n" + "        }\n" + "        h1 {\n" + "            color: #008000;\n" + "        }\n" + "    </style>\n" + "</head>\n" + "<body>\n" + "    <h1>Thanh Toán Thành Công</h1>\n" + "    <p>Cảm Ơn Bạn Thanh Toán !</p>\n"  + "</body>\n" + "</html>\n";
            return body;
        }
        String body = "<!DOCTYPE html>\n" + "<html>\n" + "<head>\n" + "    <title>Thanh Toán Thất bại </title>\n" + "    <style>\n" + "        body {\n" + "            font-family: Arial, sans-serif;\n" + "            text-align: center;\n" + "        }\n" + "        h1 {\n" + "            color: #008000;\n" + "        }\n" + "    </style>\n" + "</head>\n" + "<body>\n" + "    <h1>Thanh Toán Thất bại</h1>\n"   + "</body>\n" + "</html>\n";
        return body;

    }

}
