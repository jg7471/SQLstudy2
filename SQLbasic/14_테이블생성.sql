/*
- NUMBER(2) -> 정수를 2자리까지 저장할 수 있는 숫자형 타입.
- NUMBER(5, 2) -> 정수부, 실수부를 합친 총 자리수 5자리, 소수점 2자리 --356.74
- NUMBER -> 괄호를 생략할 시 (38, 0)으로 자동 지정됩니다.
- VARCHAR2(byte) -> 괄호 안에 들어올 문자열의 최대 길이를 지정. (4000byte까지)
- CLOB -> 대용량 텍스트 데이터 타입 (최대 4Gbyte)
- BLOB -> 이진형 대용량 객체 (이미지, 파일 저장 시 사용)
- DATE -> BC 4712년 1월 1일 ~ AD 9999년 12월 31일까지 지정 가능
- 시, 분, 초 지원 가능.
*/

CREATE TABLE dept2 (
    dept_no NUMBER(2), --데이터 크기 지정(미만)
    dept_name VARCHAR2(14), --14byte
    loca VARCHAR2(15),
    dept_date DATE,
    dept_bonus NUMBER(10)
);

DESC dept2;
SELECT * FROM dept2;

INSERT INTO dept2
VALUES(10, '영업부', '서울', sysdate, 1000000);

INSERT INTO dept2
VALUES(20, '개발부', '서울', sysdate, 2000000);

--NUMBER와 VARCHAR2 타입의 길이를 확인
INSERT INTO dept2
VALUES(20, '개발부워ㅜㄹ넝런어룬어ㅜㄹㄴㅇㄹㄴㅇㄹㄴㅇㄹㄴㅇ', '서ㄴㄹㄴㅇㄹㄴㅇㄹ울', sysdate, 200000000000000); --세팅한 글자수 초과


-- 컬럼 추가(항목)
ALTER TABLE dept2
ADD dept_count NUMBER(3); --기본값 null

--컬럼명 변경
ALTER TABLE dept2
RENAME COLUMN dept_count TO emp_count;
SELECT * FROM dept2;

--컬럼 속성 수정
--만약 변경하고자 하는 컬럼에 데이터가 이미 존재한다면, 그에 맞는 타입으로 변경해 주셔야 합니다, 맞지 않는 타입으로는 변경 불가(값이 null일 경우 ?外).
ALTER TABLE dept2
MODIFY dept_name VARCHAR2(50); --VARCHAR2(15)->VARCHAR2(50) 길이변경
DESC dept2; --길이 확인



ALTER TABLE dept2
MODIFY dept_name NUMBER(50); --이미 VARCHAR 타입 있어서 NUMBER 타입으로 변경 불가

ALTER TABLE dept2
MODIFY emp_count VARCHAR2(20); --테이블에 데이터 null이라서 속성 변경 가능 ***커밋과 롤백에 영향 XXX
--DDL 자동 커밋됨 : 롤백(복구) 안됨 : INSERT UPDATE DELETE만 ROLLBACK 가능

--DDL(CREATE, ALTER, TRUNCATE, DROP)은 트랜잭션(ROLLBACK)의 대상이 아닙니다.
ROLLBACK;

--컬럼 삭제
ALTER TABLE dept2
DROP COLUMN dept_count; --!주의 : 내부에 데이터 있어도 삭제됨

--테이블 이름 변경
ALTER TABLE dept2
RENAME TO dept3;

--테이블 삭제(구조는 남겨두고 내부 데이터만 모두 삭제)--함부러 XXX : 사본사용 or merge사용
TRUNCATE TABLE dept3;

--테이블 삭제
DROP TABLE dept2; --아예 삭제(ROLLBACK; 不可)--함부러 XXX

--DDL(CREATE, ALTER, TRUNCATE, DROP) != 트랜잭션 : 복구 안됨
--DML(SELECT, INSERT, UPDATE, DELETE)
--TCL(COMMIT, ROLLBACK, SAVEPOINT)