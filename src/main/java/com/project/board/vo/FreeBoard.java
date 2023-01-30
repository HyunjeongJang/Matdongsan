package com.project.board.vo;

import lombok.Data;

import java.sql.Date;

@Data
public class FreeBoard {
    private int boardNo;
    private long memberNo;
    private String boardTitle;
    private String boardWriter;
    private String boardContent;
    private Date boardDate;
    private String boardArea;
    private String status;



    private int currentPage;
}
