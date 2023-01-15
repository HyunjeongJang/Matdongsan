package com.project.common.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class RentHouseDto {

    @JsonProperty("ACC_YEAR")
    private String accYear;
    @JsonProperty("SGG_CD")
    private String sggCd;
    @JsonProperty("SGG_NM")
    private String sggNm;
    @JsonProperty("BJDONG_CD")
    private String bjdongCd;
    @JsonProperty("BJDONG_NM")
    private String bjdongNm;
    @JsonProperty("LAND_GBN")
    private String landGbn;
    @JsonProperty("LAND_GBN_NM")
    private String landGbnNm;
    @JsonProperty("BOBN")
    private String bonbeon;
    @JsonProperty("BUBN")
    private String bubeon;
    @JsonProperty("FLR_NO")
    private String floorNo;
    @JsonProperty("CNTRCT_DE")
    private String dealYmd;
    @JsonProperty("RENT_GBN")
    private String rentGbn;
    @JsonProperty("RENT_AREA")
    private String rentArea;
    @JsonProperty("RENT_GTN")
    private String rentGtn;
    @JsonProperty("RENT_FEE")
    private String rentFee;
    @JsonProperty("BLDG_NM")
    private String buildingNm;
    @JsonProperty("BUILD_YEAR")
    private String buildYear;
    @JsonProperty("HOUSE_GBN_NM")
    private String houseType;
    @JsonProperty("CNTRCT_PRD")
    private String ctperiod;
    @JsonProperty("NEW_RON_SECD")
    private String renewal;
    @JsonProperty("CNTRCT_UPDT_RQEST_AT")
    private String ctUpdate;
    @JsonProperty("BEFORE_GRNTY_AMOUNT")
    private String preSecurityDeposit;
    @JsonProperty("BEFORE_MT_RENT_CHRGE")
    private String previousRent;
}
