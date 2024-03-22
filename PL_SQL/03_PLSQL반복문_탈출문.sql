--WHILE문

DECLARE
    v_total NUMBER := 0;
    v_count NUMBER := 1;

BEGIN
    WHILE v_count <= 10 --end
    LOOP
        v_total := v_total + v_count;
        v_count := v_count +1; --step : ++ 역할 : DB에는 없음(파이썬도 없음)
    
    END LOOP;
    dbms_output.put_line(v_total);

END;

--탈출문

DECLARE
    v_total NUMBER := 0;
    v_count NUMBER := 1;

BEGIN
    WHILE v_count <= 10 --end
    LOOP
    
        EXIT WHEN v_count = 5; --EXIT = break 같은 개념
        
        
        v_total := v_total + v_count;
        v_count := v_count +1; --step : ++ 역할 : DB에는 없음(파이썬도 없음)
    
    END LOOP;
    dbms_output.put_line(v_total);

END;

--FOR문
DECLARE
    v_num NUMBER := 7;

BEGIN
    FOR i IN 1..9 -- .을 2개 작성해서 범위 표현
    LOOP
        dbms_output.put_line(v_num || 'x' || i || '=' || v_num*i);
    
    END LOOP;
    
END;

--CONTINUE문
DECLARE
    v_num NUMBER := 7;

BEGIN
    FOR i IN 1..9 -- .을 2개 작성해서 범위 표현
    LOOP
        CONTINUE WHEN MOD(i, 2) = 0; --오라클 %연산 없음 -> MOD 사용
        dbms_output.put_line(v_num || 'x' || i || '=' || v_num*i);
    
    END LOOP;
    
END;


--------------------------------------------------------------------------------
-- 1. 모든 구구단을 출력하는 익명 블록을 만드세요. (2 ~ 9단)
-- 짝수단만 출력해 주세요. (2, 4, 6, 8)
-- 참고로 오라클 연산자 중에는 나머지를 알아내는 연산자가 없어요. (% 없음~)

--해설 1)
BEGIN
    FOR num IN 2..9
    LOOP
        IF MOD(num, 2) = 0 THEN
            dbms_output.put_line('구구단 ' || num || '단');
            FOR row IN 1..9
            LOOP
                dbms_output.put_line(num || ' x ' || row || ' = ' || num*row);
            END LOOP;
            dbms_output.put_line('------------------------------------------------');
        END IF;
    END LOOP;
END;

--해설 2)
BEGIN
    FOR num IN 2..9
    LOOP
        CONTINUE WHEN MOD(num, 2) = 1;
        dbms_output.put_line('구구단 ' || num || '단');
        FOR row IN 1..9
        LOOP
            dbms_output.put_line(num || ' x ' || row || ' = ' || num*row);
        END LOOP;
        dbms_output.put_line('------------------------------------------------');
    END LOOP;
END;



--내가 작성
DECLARE --DECLARE 없어도 됨(생략가능)
    i NUMBER; --변수 없어도 됨
    j NUMBER; --변수 없어도 됨

BEGIN
    FOR i IN 2..9
    LOOP
        dbms_output.put_line(i||'단');
        
        FOR j IN 1..9
        LOOP
        dbms_output.put_line(i || '*' || j || '=' || i*j);
    
        END LOOP;
    END LOOP;
    
END;




-- 2. INSERT를 300번 실행하는 익명 블록을 처리하세요.
-- board라는 이름의 테이블을 만드세요. (bno, writer, title 컬럼이 존재합니다.)
-- bno는 SEQUENCE로 올려 주시고, writer와 title에 번호를 붙여서 INSERT 진행해 주세요.
-- ex) 1, test1, title1 -> 2 test2 title2 -> 3 test3 title3 ....

--해설
------------------복붙
--테이블 생성
CREATE TABLE board(
    bno NUMBER PRIMARY KEY, --사이즈X 기본 38
    writer VARCHAR2(30),
    title VARCHAR2(30)
);

--시퀀스 생성
CREATE SEQUENCE b_seq 
    START WITH 1 --생략 가능 : 시작값
    INCREMENT BY 1 --생략 가능 : 증가값
    MAXVALUE 10000 --최대값
    NOCYCLE --: 순환 여부
    NOCACHE;

--반복문 실행(데이터 삽입)
DECLARE
    v_num NUMBER := 1;
BEGIN
    WHILE v_num <= 300
    LOOP
        INSERT INTO board -- 테이블에 데이터를 삽입
        VALUES(b_seq.NEXTVAL, 'test'||v_num, 'title'||v_num);
        
        v_num := v_num + 1;
    END LOOP;
END;

--조회+정렬
SELECT * FROM board
ORDER BY bno DESC; --자바에서도 작성 가능하나 리소스 낭비 심함


--커밋
COMMIT;--DB에 업데이트




















--내가 작성
CREATE TABLE board (
    bno NUMBER(10),
    writer VARCHAR2(14),
    title VARCHAR2(15)    
);

CREATE SEQUENCE board_seq
    START WITH 1
    INCREMENT BY 1 
    MAXVALUE 300
    MINVALUE 1
    NOCACHE
    NOCYCLE;


INSERT INTO board_seq
VALUES(bno_seq.NEXTVAL, 'a', 'a');





