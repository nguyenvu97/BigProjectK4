package org.springframework.boot.upload.Vnpay;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VnpayRepo extends JpaRepository<vnpayinfo,Long> {
}
