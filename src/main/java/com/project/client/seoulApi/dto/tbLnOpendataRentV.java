package com.project.client.seoulApi.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class tbLnOpendataRentV {
    @JsonProperty("row")
    private RealEstateRentDto[] houseList;
}
