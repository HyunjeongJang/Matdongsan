package com.project.common.dao;

import com.project.common.vo.RealEstateRent;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class RealEatateRentApiDao {
    private final SqlSessionTemplate sqlSession;

    public void truncateData() {
        sqlSession.delete("rentHouseMapper.deleteAll");
    }

    public void packageInsert(List<RealEstateRent> houseList) {
        sqlSession.insert("rentHouseMapper.packageInsert", houseList);
    }
    //List<RentHouseDto> houseList() throws Exception;
}