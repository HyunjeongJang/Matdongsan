package com.project.realestate.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReservationRequest {

    private long memberNo;
    private String memberName;
    private String agentNo;
    private String peopleCount;
    private String phone;
    private String email;
    private String requestText;
    private String revTime;
    private String revDate;
    private String status;


}

