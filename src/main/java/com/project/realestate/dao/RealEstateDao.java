package com.project.realestate.dao;

import com.project.common.template.PageInfoCombine;
import com.project.realestate.dto.RealEstateRentListFilter;
import com.project.realestate.vo.RealEstateRent;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.test.context.jdbc.Sql;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class RealEstateDao {

    private final SqlSessionTemplate sqlSession;

    public int selectListCount(SqlSession sqlSession) {
        return sqlSession.selectOne("rentMapper.selectListCount");
    }
//    public int selectListCount(SqlSession sqlSession, Map<String, Object> paramMap) {
//        return sqlSession.selectOne("rentMapper.searchListCount", paramMap);
//    }


    public List<RealEstateRent> selectList(PageInfoCombine pageInfoCombine, RealEstateRentListFilter filter) {
        RowBounds rowBounds = pageInfoCombine.generateRowBounds();
        return sqlSession.selectList("rentMapper.selectList", filter, rowBounds);
    }


//    public ArrayList<RealEstateRent> selectList(SqlSession sqlSession, PageInfoCombine pageInfoCombine, RealEstateRentListFilter filter) {
//
//        RowBounds rowBounds = pageInfoCombine.generateRowBounds();
//        return (ArrayList) sqlSession.selectList("rentMapper.selectList", filter, rowBounds);
//
//    }


//    public ArrayList<RealEstateRent> selectList(SqlSession sqlSession, Map<String, Object> paramMap) {
//
//        int offset = ( ((PageInfo)paramMap.get("pi")).getCurrentPage() - 1) * ((PageInfo)paramMap.get("pi")).getBoardLimit();
//        int limit = ((PageInfo)paramMap.get("pi")).getBoardLimit();
//
//        RowBounds rowBounds = new RowBounds(offset, limit);
//
//        return (ArrayList) sqlSession.selectList("rentMapper.searchList", paramMap, rowBounds);
//    }

    // 자치구 리스트
    public ArrayList<RealEstateRent> searchLocalList(SqlSession sqlSession){
        return (ArrayList) sqlSession.selectList("rentMapper.searchLocalList");
    }

    // 동 리스트
    public ArrayList<String> selectOption(SqlSession sqlSession, String local){
        return  (ArrayList) sqlSession.selectList("rentMapper.selectOption", local);
    }

    public ArrayList<String> getSellList(SqlSession sqlSession){
        return (ArrayList) sqlSession.selectList("sellMapper.getSellList");

    }

}
