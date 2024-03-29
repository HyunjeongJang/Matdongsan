DROP TABLE "ALARM";
DROP TABLE "REALESTATE_SELL";
DROP TABLE "REALESTATE_RENT";
DROP TABLE "MEMBER";
DROP TABLE "INTEREST";
DROP TABLE "RESTAURANT";
DROP TABLE "RES_IMG";
DROP TABLE "REVIEW";
DROP TABLE "HASHTAG";
DROP TABLE "RES_HASHTAG";
DROP TABLE "CHAT_MESSAGE";
DROP TABLE "CHAT_ROOM";
DROP TABLE "CHAT_ROOM_JOIN";
DROP TABLE "FREE_BOARD";
DROP TABLE "REPLY";
DROP TABLE "QNA_BOARD";
DROP TABLE "HOTWEEK";
DROP TABLE "REPORT";
DROP TABLE "REAL_RESERVATION";

-- DROP TABLE "ALARM";

CREATE TABLE "ALARM"
(
    "ALARM_NO"     NUMBER        NOT NULL PRIMARY KEY,
    "MEMBER_NO"    NUMBER        NOT NULL,
    "ALARM_TYPE"   VARCHAR(255)  NOT NULL,
    "TARGET_NO"    VARCHAR(255)  NOT NULL,
    "IS_READ"      VARCHAR(1)    NOT NULL,
    "IS_DELETED"   VARCHAR(1)    NOT NULL,
    "TITLE"        VARCHAR(255)  NOT NULL,
    "CONTENTS"     VARCHAR(1024) NULL,
    "CREATED_DATE" TIMESTAMP     NOT NULL
);

COMMENT
    ON COLUMN "ALARM"."ALARM_NO" IS '알람 번호';

COMMENT
    ON COLUMN "ALARM"."MEMBER_NO" IS '사용자 번호';

COMMENT
    ON COLUMN "ALARM"."ALARM_TYPE" IS '알람 타입';

COMMENT
    ON COLUMN "ALARM"."TARGET_NO" IS '알람 대상 번호';

COMMENT
    ON COLUMN "ALARM"."IS_READ" IS '확인여부';

COMMENT
    ON COLUMN "ALARM"."IS_DELETED" IS '삭제여부';

COMMENT
    ON COLUMN "ALARM"."TITLE" IS '제목';

COMMENT
    ON COLUMN "ALARM"."CONTENTS" IS '내용';

COMMENT
    ON COLUMN "ALARM"."CREATED_DATE" IS '생성일자';




-- DROP TABLE "REALESTATE_SELL";

CREATE TABLE REALESTATE_SELL
(
    "ESTATE_NO"    VARCHAR(255)  NOT NULL,
    "ACC_YEAR"   VARCHAR(255)  NULL,
    "SGG_CD"     VARCHAR(255)  NULL,
    "SGG_NM"     VARCHAR(255)  NULL,
    "BJDONG_CD"  VARCHAR(255)  NULL,
    "BJDONG_NM"  VARCHAR2(255) NULL,
    "BONBEON"    VARCHAR(255)  NULL,
    "BUBEON"     VARCHAR(255)  NULL,
    "BLDG_NM"    VARCHAR(255)  NULL,
    "DEAL_YMD"   VARCHAR(255)  NULL,
    "OBJ_AMT"    VARCHAR(255)  NULL,
    "BLDG_AREA"  VARCHAR(255)  NULL,
    "BUILD_YEAR" VARCHAR(255)  NULL,
    "HOUSE_TYPE" VARCHAR(255)  NULL,
    "FLOOR"      VARCHAR2(255) NULL,
    "GBN" VARCHAR(255) DEFAULT '매매'  NULL
);

COMMENT
    ON COLUMN REALESTATE_SELL."ESTATE_NO" IS '매매번호';

COMMENT
    ON COLUMN REALESTATE_SELL."ACC_YEAR" IS '접수년도';

COMMENT
    ON COLUMN REALESTATE_SELL."SGG_CD" IS '자치구코드';

COMMENT
    ON COLUMN REALESTATE_SELL."SGG_NM" IS '자치구명';

COMMENT
    ON COLUMN REALESTATE_SELL."BJDONG_CD" IS '법정동코드';

COMMENT
    ON COLUMN REALESTATE_SELL."BJDONG_NM" IS '법적동명';

COMMENT
    ON COLUMN REALESTATE_SELL."BONBEON" IS '본번';

COMMENT
    ON COLUMN REALESTATE_SELL."BUBEON" IS '부번';

COMMENT
    ON COLUMN REALESTATE_SELL."BLDG_NM" IS '건물명';

COMMENT
    ON COLUMN REALESTATE_SELL."DEAL_YMD" IS '계약일';

COMMENT
    ON COLUMN REALESTATE_SELL."OBJ_AMT" IS '물건금액';

COMMENT
    ON COLUMN REALESTATE_SELL."BLDG_AREA" IS '건축면적';

COMMENT
    ON COLUMN REALESTATE_SELL."BUILD_YEAR" IS '건축년도';

COMMENT
    ON COLUMN REALESTATE_SELL."HOUSE_TYPE" IS '건물용도';

COMMENT
    ON COLUMN REALESTATE_SELL."FLOOR" IS '층';

COMMENT
    ON COLUMN REALESTATE_SELL."GBN" IS '매매';

-- DROP TABLE "REALESTATE_RENT";

CREATE TABLE "REALESTATE_RENT"
(
    "ESTATE_NO"      VARCHAR(255) NOT NULL,
    "ACC_YEAR"     VARCHAR(255) NULL,
    "SGG_CD"       VARCHAR(255) NULL,
    "SGG_NM"       VARCHAR(255) NULL,
    "BJDONG_CD"    VARCHAR(255) NULL,
    "BJDONG_NM"    VARCHAR(255) NULL,
    "BOBN"         VARCHAR(255) NULL,
    "BUBN"         VARCHAR(255) NULL,
    "FLR_NO"       VARCHAR2(255) NULL,
    "DEAL_YMD"     VARCHAR(255) NULL,
    "RENT_GBN"     VARCHAR(255) NULL,
    "RENT_AREA"    VARCHAR(255) NULL,
    "RENT_GTN"     VARCHAR(255) NULL,
    "RENT_FEE"     VARCHAR(255) NULL,
    "BLDG_NM"      VARCHAR(255) NULL,
    "BUILD_YEAR"   VARCHAR2(255) NULL,
    "HOUSE_GBN_NM" VARCHAR(255) NULL
);

COMMENT
    ON COLUMN "REALESTATE_RENT"."ESTATE_NO" IS '전월세 번호';

COMMENT
    ON COLUMN "REALESTATE_RENT"."ACC_YEAR" IS '접수년도';

COMMENT
    ON COLUMN "REALESTATE_RENT"."SGG_NM" IS '자치구명';

COMMENT
    ON COLUMN "REALESTATE_RENT"."BJDONG_NM" IS '법정동명';

COMMENT
    ON COLUMN "REALESTATE_RENT"."BOBN" IS '본번';

COMMENT
    ON COLUMN "REALESTATE_RENT"."BUBN" IS '부번';

COMMENT
    ON COLUMN "REALESTATE_RENT"."FLR_NO" IS '층';

COMMENT
    ON COLUMN "REALESTATE_RENT"."DEAL_YMD" IS '계약일';

COMMENT
    ON COLUMN "REALESTATE_RENT"."RENT_GBN" IS '전월세구분';

COMMENT
    ON COLUMN "REALESTATE_RENT"."RENT_AREA" IS '임대면적';

COMMENT
    ON COLUMN "REALESTATE_RENT"."RENT_GTN" IS '보증금';

COMMENT
    ON COLUMN "REALESTATE_RENT"."RENT_FEE" IS '임대료';

COMMENT
    ON COLUMN "REALESTATE_RENT"."BLDG_NM" IS '건물명';

COMMENT
    ON COLUMN "REALESTATE_RENT"."BUILD_YEAR" IS '건축년도';

COMMENT
    ON COLUMN "REALESTATE_RENT"."HOUSE_GBN_NM" IS '건물용도';



DROP TABLE "REALESTATE_AGENT";

CREATE TABLE MATDONGSAN.REALESTATE_AGENT
(
    AGENT_NO     VARCHAR2(26),
    STATE        VARCHAR2(26),
    BJDONG_NM    VARCHAR2(26),
    ADDRESS      VARCHAR2(255),
    REF_NAME     VARCHAR2(26),
    AGENT_NAME   VARCHAR2(128),
    AGENT_PHONE  VARCHAR2(1024),
    MEMBER_NO    NUMBER,
    ATTACHMENT   VARCHAR2(255),
    APPLY_STATUS VARCHAR2(20) DEFAULT 'A'
);

COMMENT ON COLUMN MATDONGSAN.REALESTATE_AGENT.AGENT_NO IS '부동산 중개업자 번호';


COMMENT ON COLUMN MATDONGSAN.REALESTATE_AGENT.MEMBER_NO IS '회원번호';

-- DROP TABLE MATDONGSAN.REAL_RESERVATION;

CREATE TABLE MATDONGSAN.REAL_RESERVATION
(
    REV_NO         NUMBER                       NOT NULL
        CONSTRAINT REAL_RESERVATION_PK
            PRIMARY KEY,
    MEMBER_NO      NUMBER                       NOT NULL,
    MEMBER_NAME    VARCHAR2(255)                NOT NULL,
    PHONE          VARCHAR2(255)                NOT NULL,
    AGENT_NO      VARCHAR2(255)                 NOT NULL,
    REV_PEOPLE     VARCHAR2(255)                NOT NULL,
    EMAIL          VARCHAR2(255),
    REV_ASK        VARCHAR2(255),
    REV_TIME       VARCHAR2(255)                NOT NULL,
    REV_DATE       DATE                         NOT NULL,
    REV_CREATEDATE DATE         DEFAULT SYSDATE NOT NULL,
    REV_STATUS     VARCHAR2(30) DEFAULT 'C'
);

COMMENT ON TABLE MATDONGSAN.REAL_RESERVATION IS '부동산 예약';

COMMENT ON COLUMN MATDONGSAN.REAL_RESERVATION.MEMBER_NAME IS '예약자 이름';

COMMENT ON COLUMN MATDONGSAN.REAL_RESERVATION.REV_PEOPLE IS '인원';

COMMENT ON COLUMN MATDONGSAN.REAL_RESERVATION.PHONE IS '전화번호';

COMMENT ON COLUMN MATDONGSAN.REAL_RESERVATION.EMAIL IS '이메일';

COMMENT ON COLUMN MATDONGSAN.REAL_RESERVATION.REV_ASK IS '요청사항';

COMMENT ON COLUMN MATDONGSAN.REAL_RESERVATION.REV_DATE IS '방문날짜';

COMMENT ON COLUMN MATDONGSAN.REAL_RESERVATION.REV_CREATEDATE IS '얘약신청 날짜';

COMMENT ON COLUMN MATDONGSAN.REAL_RESERVATION.REV_STATUS IS '예약 상태';


DROP TABLE "MEMBER";

CREATE TABLE "MEMBER"
(
    "MEMBER_NO"                NUMBER                         NOT NULL,
    "PROVIDER"                 VARCHAR(255)                   NOT NULL,
    "PROVIDER_ID"              VARCHAR(255)                   NOT NULL,
    "MEMBER_NAME"              VARCHAR(255)                   NOT NULL,
    "PROFILE_IMAGE"            VARCHAR(255)                   NULL,
    "EMAIL"                    VARCHAR(255)                   NULL,
    "NICKNAME"                 VARCHAR(255)                   NULL,
    "PHONE"                    VARCHAR(255)                   NULL,
    "ADDRESS"                  VARCHAR(255)                   NULL,
    "STATUS"                   VARCHAR(255) DEFAULT 'Y'       NULL,
    "GRADE"                    VARCHAR(255) DEFAULT 'GENERAL' NULL,
    "RECENT_ACCESS"            TIMESTAMP                      NULL,
    "ACCESS_TOKEN"             VARCHAR2(255)                  NULL,
    "REFRESH_TOKEN"            VARCHAR2(255)                  NULL,
--     "REFRESH_TOKEN_EXPIRED_AT" TIMESTAMP                      NULL,
    "BAN_PERIOD"               TIMESTAMP                      NULL
);

COMMENT
    ON COLUMN "MEMBER"."MEMBER_NO" IS '회원번호';

COMMENT
    ON COLUMN "MEMBER"."PROVIDER" IS '소셜사';

COMMENT
    ON COLUMN "MEMBER"."PROVIDER_ID" IS '소셜ID';

COMMENT
    ON COLUMN "MEMBER"."MEMBER_NAME" IS '소셜회원이름';

COMMENT
    ON COLUMN "MEMBER"."PROFILE_IMAGE" IS '프로필이미지URL';

COMMENT
    ON COLUMN "MEMBER"."EMAIL" IS '이메일';

COMMENT
    ON COLUMN "MEMBER"."NICKNAME" IS '닉네임';

COMMENT
    ON COLUMN "MEMBER"."PHONE" IS '휴대폰번호';

COMMENT
    ON COLUMN "MEMBER"."ADDRESS" IS '주소';

COMMENT
    ON COLUMN "MEMBER"."STATUS" IS '활동상태';

COMMENT
    ON COLUMN "MEMBER"."GRADE" IS '등급';

COMMENT
    ON COLUMN "MEMBER"."RECENT_ACCESS" IS '최근접속기록';

COMMENT
    ON COLUMN "MEMBER"."ACCESS_TOKEN"  IS '로그인 토큰';

COMMENT
    ON COLUMN "MEMBER"."REFRESH_TOKEN" IS '리프레시 토큰';

COMMENT
    ON COLUMN "MEMBER"."REFRESH_TOKEN_EXPIRED_AT" IS '리프레시 토큰 제한시간';


-- DROP TABLE "INTEREST";

CREATE TABLE "INTEREST"
(
    "MEMBER_NO" NUMBER                   NOT NULL,
    "ESTATE_NO"   VARCHAR(255)             NULL
);

COMMENT
    ON COLUMN "INTEREST"."ESTATE_NO" IS '부동산번호';

COMMENT
    ON COLUMN "INTEREST"."MEMBER_NO" IS '회원번호';


-- DROP TABLE "RESTAURANT";

CREATE TABLE "RESTAURANT"
(
    "RES_NO"     VARCHAR(255)   NOT NULL,
    "RES_NAME"   VARCHAR(255)   NOT NULL,
    "STATE"      VARCHAR(255)   NOT NULL,
    "ADDRESS"    VARCHAR(255)   NULL,
    "RES_PHONE"  VARCHAR(255)   NULL,
    "WEBSITE"    VARCHAR(255)   NULL,
    "RES_TIME"   VARCHAR(255)   NULL,
    "TRANSPORT"  VARCHAR(255)   NULL,
    "RES_FOOD"   VARCHAR(255)   NULL,
    "RES_IMGURL" VARCHAR2(2056) NULL
);

COMMENT
    ON COLUMN "RESTAURANT"."RES_NO" IS '맛집번호';

COMMENT
    ON COLUMN "RESTAURANT"."RES_NAME" IS '상호명';

COMMENT
    ON COLUMN "RESTAURANT"."STATE" IS '구이름';

COMMENT
    ON COLUMN "RESTAURANT"."ADDRESS" IS '도로명주소';

COMMENT
    ON COLUMN "RESTAURANT"."RES_PHONE" IS '전화번호';

COMMENT
    ON COLUMN "RESTAURANT"."WEBSITE" IS '웹사이트';

COMMENT
    ON COLUMN "RESTAURANT"."RES_TIME" IS '운영시간';

COMMENT
    ON COLUMN "RESTAURANT"."TRANSPORT" IS '교통정보';

COMMENT
    ON COLUMN "RESTAURANT"."RES_FOOD" IS '대표메뉴';

COMMENT
    ON COLUMN "RESTAURANT"."RES_IMGURL" IS '레스토랑이미지경로';


-- DROP TABLE "REVIEW";

CREATE TABLE "REVIEW"
(
    "REV_NO"         NUMBER                  NOT NULL,
    "MEMBER_NO"      NUMBER                  NOT NULL,
    "RES_NO"         VARCHAR(255)            NOT NULL,
    "STAR_RATING"    NUMBER                  NOT NULL,
    "REVIEW_CONTENT" VARCHAR(2056)          NOT NULL,
    "CREATE_DATE"    TIMESTAMP              NOT NULL,
    "STATUS"         VARCHAR(20) DEFAULT 'Y' NOT NULL
);

COMMENT
    ON COLUMN "REVIEW"."REV_NO" IS '리뷰번호';

COMMENT
    ON COLUMN "REVIEW"."MEMBER_NO" IS '회원번호';

COMMENT
    ON COLUMN "REVIEW"."RES_NO" IS '맛집번호';

COMMENT
    ON COLUMN "REVIEW"."STAR_RATING" IS '별점';

COMMENT
    ON COLUMN "REVIEW"."REVIEW_CONTENT" IS '내용';

COMMENT
    ON COLUMN "REVIEW"."CREATE_DATE" IS '리뷰작성일';

COMMENT
    ON COLUMN "REVIEW"."STATUS" IS '리뷰노출상태';


-- DROP TABLE "HASHTAG";

CREATE TABLE "HASHTAG"
(
    "HASHTAG_ID" VARCHAR(255) NOT NULL,
    "HASHTAG"    VARCHAR(255) NULL
);

COMMENT
    ON COLUMN "HASHTAG"."HASHTAG_ID" IS '해시태그ID';

COMMENT
    ON COLUMN "HASHTAG"."HASHTAG" IS '해시태그';


DROP TABLE "HOTWEEK";

CREATE TABLE "HOTWEEK"
(
    "FREE_BNO"  NUMBER NOT NULL,
    "MEMBER_NO" NUMBER NOT NULL,
    "COUNT_DATE"      DATE   NOT NULL
);

COMMENT
    ON COLUMN "HOTWEEK"."FREE_BNO" IS '게시글 번호';

COMMENT
    ON COLUMN "HOTWEEK"."MEMBER_NO" IS '회원번호';

COMMENT
    ON COLUMN "HOTWEEK"."COUNT_DATE" IS '조회일';


DROP TABLE "CHAT_MESSAGE";

CREATE TABLE "CHAT_MESSAGE"
(
    "CM_NO"        NUMBER                      NOT NULL,
    "CHAT_ROOM_NO" VARCHAR(255)                NOT NULL,
    "SEND_NO"      NUMBER                      NOT NULL,
    "CREATE_DATE"  DATE        DEFAULT SYSDATE NOT NULL,
    "READ"         VARCHAR(20) DEFAULT 'Y'     NULL,
    "MS_CONTENT"   VARCHAR(255)                NULL
);

COMMENT
    ON COLUMN "CHAT_MESSAGE"."CM_NO" IS '메세지번호';

COMMENT
    ON COLUMN "CHAT_MESSAGE"."CHAT_ROOM_NO" IS '채팅방번호';

COMMENT
    ON COLUMN "CHAT_MESSAGE"."CREATE_DATE" IS '메세지 생성일자';

COMMENT
    ON COLUMN "CHAT_MESSAGE"."READ" IS '일음 여부';

COMMENT
    ON COLUMN "CHAT_MESSAGE"."MS_CONTENT" IS '메세지내용';


DROP TABLE "CHAT_ROOM";

CREATE TABLE "CHAT_ROOM"
(
    "CHAT_ROOM_NO" VARCHAR(255)                 NOT NULL,
    "MEMBER_NO"    NUMBER                       NOT NULL,
    "STATUS"       VARCHAR(255) DEFAULT 'Y'     NULL,
    "CREATE_DATE"  DATE         DEFAULT SYSDATE NULL
);

COMMENT
    ON COLUMN "CHAT_ROOM"."CHAT_ROOM_NO" IS '채팅방번호';

COMMENT
    ON COLUMN "CHAT_ROOM"."MEMBER_NO" IS '회원번호';

COMMENT
    ON COLUMN "CHAT_ROOM"."STATUS" IS '채팅방상태';

COMMENT
    ON COLUMN "CHAT_ROOM"."CREATE_DATE" IS '생성일자';


DROP TABLE "CHAT_ROOM_JOIN";

CREATE TABLE "CHAT_ROOM_JOIN"
(
    "CHAT_ROOM_NO" VARCHAR(255) NOT NULL,
    "MEMBER_NO"    NUMBER NOT NULL
);

COMMENT
    ON COLUMN "CHAT_ROOM_JOIN"."CHAT_ROOM_NO" IS '채팅방번호';

COMMENT
    ON COLUMN "CHAT_ROOM_JOIN"."MEMBER_NO" IS '회원번호';


-- DROP TABLE "RES_IMG";

CREATE TABLE "RES_IMG"
(
    "IMG_NO"      NUMBER       NOT NULL,
    "REV_NO"   NUMBER          NULL,
    "MEMBER_NO"   NUMBER       NOT NULL,
    "RES_NO"      VARCHAR(255) NOT NULL,
    "IMAGE_LEVEL" NUMBER       NULL,
    "ORIGIN_NAME" VARCHAR(255) NULL,
    "CHANGE_NAME" VARCHAR(255) NULL
);

COMMENT
    ON COLUMN "RES_IMG"."IMG_NO" IS '이미지 번호';

COMMENT
    ON COLUMN "RES_IMG"."REV_NO" IS '리뷰번호';

COMMENT
    ON COLUMN "RES_IMG"."MEMBER_NO" IS '회원번호';

COMMENT
    ON COLUMN "RES_IMG"."RES_NO" IS '맛집번호';

COMMENT
    ON COLUMN "RES_IMG".IMAGE_LEVEL IS '이미지레벨';

COMMENT
    ON COLUMN "RES_IMG"."ORIGIN_NAME" IS '원본파일이름';

COMMENT
    ON COLUMN "RES_IMG"."CHANGE_NAME" IS '저장파일이름';


-- DROP TABLE "RES_HASHTAG";

CREATE TABLE "RES_HASHTAG"
(
    "RES_NO"     VARCHAR(255) NULL,
    "HASHTAG_ID" VARCHAR(255) NULL,
    "REV_NO"     NUMBER       NULL,
    "MEMBER_NO"  NUMBER       NOT NULL
);

COMMENT
    ON COLUMN "RES_HASHTAG"."RES_NO" IS '맛집번호';

COMMENT
    ON COLUMN "RES_HASHTAG"."HASHTAG_ID" IS '해시태그 아이디';

COMMENT
    ON COLUMN "RES_HASHTAG"."REV_NO" IS '리뷰번호';

COMMENT
    ON COLUMN "RES_HASHTAG"."MEMBER_NO" IS '회원번호';


DROP TABLE "FREE_BOARD";

CREATE TABLE "FREE_BOARD"
(
    "FREE_BNO"      NUMBER                       NOT NULL,
    "MEMBER_NO"     NUMBER                       NOT NULL,
    "BOARD_TITLE"   VARCHAR(255)                 NOT NULL,
    "BOARD_WRITER"  VARCHAR(255)                 NOT NULL,
    "BOARD_CONTENT" VARCHAR(2056)                NULL,
    "BOARD_DATE"    TIMESTAMP    DEFAULT localtimestamp NULL,
    "BOARD_AREA"    VARCHAR(255)                 NULL,
    "STATUS"        VARCHAR(255) DEFAULT 'Y'     NULL,
    "NOTICE"        NUMBER DEFAULT 0             NULL,
    "BLIND"         VARCHAR2(1)  DEFAULT 'N'     NULL
);

COMMENT
    ON COLUMN "FREE_BOARD"."FREE_BNO" IS '게시글번호';

COMMENT
    ON COLUMN "FREE_BOARD"."MEMBER_NO" IS '회원번호';

COMMENT
    ON COLUMN "FREE_BOARD"."BOARD_TITLE" IS '글제목';

COMMENT
    ON COLUMN "FREE_BOARD"."BOARD_WRITER" IS '작성자';

COMMENT
    ON COLUMN "FREE_BOARD"."BOARD_CONTENT" IS '글내용';

COMMENT
    ON COLUMN "FREE_BOARD"."BOARD_DATE" IS '작성일';

COMMENT
    ON COLUMN "FREE_BOARD"."BOARD_AREA" IS '지역';

COMMENT
    ON COLUMN "FREE_BOARD"."STATUS" IS '상태';

COMMENT
    ON COLUMN "FREE_BOARD"."NOTICE" IS '공지사항 여부';

COMMENT
    ON COLUMN "FREE_BOARD"."BLIND" IS '블라인드 여부';




DROP TABLE "REPLY";

CREATE TABLE "REPLY"
(
    "REPLY_NO"      NUMBER                       NOT NULL,
    "MEMBER_NO"     NUMBER                       NOT NULL,
    "FREE_BNO"      NUMBER                       NOT NULL,
    "REPLY_CONTENT" VARCHAR(2056)                NULL,
    "REPLY_DATE"    TIMESTAMP DEFAULT localtimestamp NULL,
    "STATUS"        VARCHAR(255) DEFAULT 'Y'     NULL
);

COMMENT
    ON COLUMN "REPLY"."REPLY_NO" IS '댓글번호';

COMMENT
    ON COLUMN "REPLY"."MEMBER_NO" IS '회원번호';

COMMENT
    ON COLUMN "REPLY"."FREE_BNO" IS '게시글번호';

COMMENT
    ON COLUMN "REPLY"."REPLY_CONTENT" IS '댓글내용';

COMMENT
    ON COLUMN "REPLY"."REPLY_DATE" IS '댓글작성일';

COMMENT
    ON COLUMN "REPLY"."STATUS" IS '상태값';


DROP TABLE "REPORT";

CREATE TABLE "REPORT"
(
    "REPORT_NO"      NUMBER        NOT NULL,
    "FREE_BNO"       NUMBER        NOT NULL,
    "MEMBER_NO"      NUMBER        NULL,
    "REPORT_USER_NO" NUMBER        NULL,
    "REPORT_CONTENT" VARCHAR(2056) NULL,
    "REPORT_TYPE"   VARCHAR2(255) NULL

);

COMMENT
    ON COLUMN "REPORT"."REPORT_NO" IS '신고번호';

COMMENT
    ON COLUMN "REPORT"."FREE_BNO" IS '게시글번호';

COMMENT
    ON COLUMN "REPORT"."MEMBER_NO" IS '피신고회원번호';

COMMENT
    ON COLUMN "REPORT"."REPORT_USER_NO" IS '신고회원번호';

COMMENT
    ON COLUMN "REPORT"."REPORT_CONTENT" IS '신고사유';




DROP TABLE "QNA_BOARD";

CREATE TABLE "QNA_BOARD"
(
    "QNA_BNO"     NUMBER                       NOT NULL,
    "MEMBER_NO"   NUMBER                       NOT NULL,
    "P_BNO"       NUMBER                       NULL,
    "QNA_TITLE"   VARCHAR(255)                 NOT NULL,
    "QNA_CONTENT" VARCHAR(2056)                NOT NULL,
    "QNA_DATE"    TIMESTAMP    DEFAULT localtimestamp NULL,
    "COUNT"       NUMBER       DEFAULT 0       NULL,
    "STATUS"      VARCHAR(255) DEFAULT 'Y'     NULL,
    "QNA_AREA"    VARCHAR(255)                 NULL,
    "QNA_DEPTH"   NUMBER       DEFAULT '1'     NULL,
    "QNA_WRITER"  VARCHAR(255)                  NULL,
    "NOTICE"        NUMBER DEFAULT 0             NULL,
    "BLIND"         VARCHAR2(1)  DEFAULT 'N'     NULL
);

COMMENT
    ON COLUMN "QNA_BOARD"."QNA_BNO" IS '글번호';

COMMENT
    ON COLUMN "QNA_BOARD"."MEMBER_NO" IS '회원번호';

COMMENT
    ON COLUMN "QNA_BOARD"."P_BNO" IS '부모글번호';

COMMENT
    ON COLUMN "QNA_BOARD"."QNA_TITLE" IS '글제목';

COMMENT
    ON COLUMN "QNA_BOARD"."QNA_CONTENT" IS '글내용';

COMMENT
    ON COLUMN "QNA_BOARD"."QNA_DATE" IS '작성일';

COMMENT
    ON COLUMN "QNA_BOARD"."COUNT" IS '조회수';

COMMENT
    ON COLUMN "QNA_BOARD"."STATUS" IS '상태값';

COMMENT
    ON COLUMN "QNA_BOARD"."QNA_AREA" IS '지역';

COMMENT
    ON COLUMN "QNA_BOARD"."QNA_DEPTH" IS '글깊이';

COMMENT
    ON COLUMN "QNA_BOARD"."QNA_WRITER" IS '작성자';

COMMENT
    ON COLUMN "QNA_BOARD"."NOTICE" IS '공지사항 여부';

COMMENT
    ON COLUMN "QNA_BOARD"."BLIND" IS '블라인드 여부';





DROP SEQUENCE SEQ_SELL_NO;
CREATE SEQUENCE SEQ_SELL_NO START WITH 10000 INCREMENT BY 1 MAXVALUE 99999999 NOCYCLE NOCACHE;

DROP SEQUENCE SEQ_RENT_NO;
CREATE SEQUENCE SEQ_RENT_NO START WITH 60000 INCREMENT BY 1 MAXVALUE 99999999 NOCYCLE NOCACHE;

DROP SEQUENCE SEQ_RES_NO;
CREATE SEQUENCE SEQ_RES_NO START WITH 50000 INCREMENT BY 1 MAXVALUE 99999999 NOCYCLE NOCACHE;

DROP SEQUENCE SEQ_REV_NO;
CREATE SEQUENCE SEQ_REV_NO START WITH 1 INCREMENT BY 1 MAXVALUE 99999999 NOCYCLE NOCACHE;

DROP SEQUENCE SEQ_MEMBER_NO;
CREATE SEQUENCE SEQ_MEMBER_NO START WITH 1 INCREMENT BY 1 MAXVALUE 99999999 NOCYCLE NOCACHE;

DROP SEQUENCE SEQ_QNA_BNO;
CREATE SEQUENCE SEQ_QNA_BNO START WITH 1 INCREMENT BY 1 MAXVALUE 99999999 NOCYCLE NOCACHE;

DROP SEQUENCE SEQ_FREE_BNO;
CREATE SEQUENCE SEQ_FREE_BNO START WITH 1 INCREMENT BY 1 MAXVALUE 99999999 NOCYCLE NOCACHE;

DROP SEQUENCE SEQ_REPORT_NO;
CREATE SEQUENCE SEQ_REPORT_NO START WITH 1 INCREMENT BY 1 MAXVALUE 99999999 NOCYCLE NOCACHE;

DROP SEQUENCE SEQ_IMG_NO;
CREATE SEQUENCE SEQ_IMG_NO START WITH 1 INCREMENT BY 1 MAXVALUE 99999999 NOCYCLE NOCACHE;

DROP SEQUENCE SEQ_ALARM_NO;
CREATE SEQUENCE SEQ_ALARM_NO START WITH 1 INCREMENT BY 1 MAXVALUE 99999999 NOCYCLE NOCACHE;

DROP SEQUENCE SEQ_REP_NO;
CREATE SEQUENCE SEQ_REP_NO START WITH 1 INCREMENT BY 1 MAXVALUE 99999999 NOCYCLE NOCACHE ;

DROP SEQUENCE SEQ_CM_NO;
CREATE SEQUENCE SEQ_CM_NO START WITH 1 INCREMENT BY 1 MAXVALUE 99999999 NOCYCLE NOCACHE ;

DROP SEQUENCE SEQ_ESTATE_REV_NO;
CREATE SEQUENCE SEQ_ESTATE_REV_NO START WITH 1 INCREMENT BY 1 MAXVALUE 99999999 NOCYCLE NOCACHE ;

