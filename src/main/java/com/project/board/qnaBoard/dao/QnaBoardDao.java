package com.project.board.qnaBoard.dao;
import org.apache.ibatis.session.SqlSession;

public class QnaBoardDao {

    public int selectBoard(SqlSession sqlSession, int bno) {
        return sqlSession.selectOne("boardMapper.selectList", bno);
    }


}