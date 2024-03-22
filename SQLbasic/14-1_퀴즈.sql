
--문제1 내가 작성
CREATE TABLE quiz (
    m_name VARCHAR2(3) CONSTRAINT mem_name NOT NULL,
    m_num NUMBER(1) CONSTRAINT mem_memnum_pk PRIMARY KEY,
    reg_date DATE CONSTRAINT mem_regdate_uk UNIQUE,
    gender VARCHAR2(1) CONSTRAINT mem_gender_ck CHECK(gender IN('M', 'F')),
    loca NUMBER(4) CONSTRAINT mem_loca_loc_locid_fk REFERENCES HR.locations(location_id) --연결고리
);

INSERT INTO quiz
VALUES('AAA',1,'2018-07-01','M',1800);

INSERT INTO quiz
VALUES('BBB',2,'2018-07-02','F',1900);

INSERT INTO quiz
VALUES('CCC',3,'2018-07-03','M',2000);

INSERT INTO quiz
VALUES('DDD',4,sysdate,'M',2000);

--문제1 해설


--문제2 내가 작성
SELECT *
FROM quiz q
JOIN locations loc
ON q.loca = loc.location_id --연결고리
ORDER BY m_num ASC;


--문제 2해설2