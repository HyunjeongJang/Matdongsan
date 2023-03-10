package com.project.restaurant.repository;

import com.project.restaurant.dto.ResHashtagDto;
import com.project.restaurant.vo.ResHashtag;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class ResHashtagRepository {
    private final SqlSessionTemplate sqlSession;

    public void insert(ResHashtag resHashtag) {
        sqlSession.insert("resHashtagMapper.insert", resHashtag);
    }

    public List<ResHashtagDto> selectByResNo(String resNo) {
        return sqlSession.selectList("resHashtagMapper.selectListByResNo", resNo);
    }

    public List<ResHashtagDto> selectByRevNo(int revNo) {
        return sqlSession.selectList("resHashtagMapper.selectListByRevNo", revNo);
    }

    public void deleteByRevNo(int revNo) {
        sqlSession.delete("resHashtagMapper.deleteByRevNo", revNo);
    }

    public List<String> selectTop2ByReview(String resNo) {
        return sqlSession.selectList("resHashtagMapper.resHashtagByReview", resNo);
    }
}
