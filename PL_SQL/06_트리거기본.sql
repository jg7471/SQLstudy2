/*
trigger는 테이블에 부착된 형태로써, INSERT, UPDATE, DELETE 작업이 수행될 때
특정 코드가 작동되도록 하는 구문입니다.
VIEW에는 부착이 불가능합니다.

트리거를 만들 때 범위 지정하고 F5 or F9버튼으로 부분 실행해야 합니다.
그렇지 않으면 하나의 구문으로 인식되어 정상 동작하지 않습니다.
*/


CREATE TABLE tbl_test(
    id NUMBER(10),
    text VARCHAR2(20)
);

--드래그 F5 or F9 실행
CREATE OR REPLACE TRIGGER trg_test --trg_관례
    AFTER DELETE OR UPDATE --트리거의 동작 시점(삭제 혹은 수정 이후에 동작)
    ON tbl_test -- 트리거를 부착할 테이블
    FOR EACH ROW -- 각 행에 모두 적용(생략 가능. 생략 시 한 번만 실행)
--DECLARE -- 생략 가능 (변수 선언할게 없다)

BEGIN
    dbms_output.put_line('트리거가 동작함'); --실행하고자 하는 코드를 begin - end 사이에 넣음
END;





INSERT INTO tbl_test VALUES(1, '김춘식'); --트리거 동작X 이유 @ : --인서트 트리거 동작x
INSERT INTO tbl_test VALUES(2, '손흥민');
INSERT INTO tbl_test VALUES(3, '이청용');

UPDATE tbl_test SET text = '김개똥' WHERE id = 1; --춘식 -> 개똥 --트리거 동작O
--동작순서 UPDATE(사용자 추가 입력) -> AFTER DELETE OR UPDATE
DELETE FROM tbl_test WHERE id = 2; --트리거 동작O
