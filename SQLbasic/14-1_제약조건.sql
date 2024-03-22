-- 테이블 생성과 제약조건
-- : 테이블에 부적절한 데이터가 입력되는 것을 방지하기 위해 규칙을 설정하는 것.

-- 테이블 열레벨 제약조건 (PRIMARY KEY, UNIQUE, NOT NULL, FOREIGN KEY, CHECK)
-- PRIMARY KEY: 테이블의 고유 식별 컬럼입니다. (주요 키):사번 每 테이블당 부여 : null 不? /// PRIMARY KEY : UNIQUE + NOT NULL
-- UNIQUE: 유일한 값을 갖게 하는 컬럼 (중복값 방지) : null 허용 : 전화번호 UK
-- NOT NULL: null을 허용하지 않음. (필수값)
-- FOREIGN KEY: 참조하는 테이블의 PRIMARY KEY를 저장하는 컬럼 : 접근하기 위한 Key 대부분 PK
-- CHECK: 정의된 형식만 저장되도록 허용. : NOT NULL과 비슷(커스텀)


-- 컬럼 레벨 제약 조건 (컬럼 선언마다 제약조건 지정)
CREATE TABLE dept2 (
    dept_no NUMBER(2) CONSTRAINT dept2_dept_pk PRIMARY KEY, --테이블명 (컬럼명) 키속성 : 관례 --제약조건 식별자(dept2_dept_pk)는 생략 가능 --컬럼명 생략시 나중에 호출시 시스템에서 기계어로 이름 지정해줌
    dept_name VARCHAR2(14) NOT NULL CONSTRAINT dept2_deptname_uk UNIQUE, --필수값(NOT NULL+UNIQUE : PK 자격 있으나, PK 2개시 혼동)
    loca NUMBER(4) CONSTRAINT dept2_loca_locid_fk REFERENCES HR.locations(location_id), --연결하기 위해 기존값 : NUMBER(4, 0) --참조 REFERENCES 합니다 HR. 계정명(동일 계정? 생략가능)
    dept_bonus NUMBER(10) CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 10000),
    dept_gender VARCHAR2(1) CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'))
);

DROP TABLE dept2;

-- 테이블 레벨 제약 조건 (모든 열 선언 후 제약 조건을 취하는 방식)
CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) CONSTRAINT dept_name_notnull NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1), 
    
    CONSTRAINT dept2_dept_pk PRIMARY KEY(dept_no),
    CONSTRAINT dept2_deptname_uk UNIQUE(dept_name),
    CONSTRAINT dept2_loca_locid_fk FOREIGN KEY(loca) REFERENCES HR.locations(location_id),
    CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 10000),
    CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'))
);

INSERT INTO dept2
VALUES(10,'gg',3000,90000,'M'); --9000(보너스 10000이상) 조건에 맞혀 삽입해야함

ROLLBACK; --INSERT 취소 CREATE 취소 不可

--외래키(FK)가 부모테이블(참조테이블)에 없다면 INSERT 不可
INSERT INTO dept2
VALUES(10,'gg',6542,90000,'M'); --에러 --loca에 6542 값이 없음(외래 테이블에 값이 없음)


--수정할 때도 제약조건 유의
UPDATE dept2
SET loca = 4000
WHERE dept_no = 10; --실패(외래키(FK) 제약조건 위반)

UPDATE dept2
SET dept_no = 20
WHERE dept_no = 10; --실패(주요키(PK) 제약조건 위반)

UPDATE dept2
SET dept_bonus = 900
WHERE dept_no = 10; --실패(check 제약조건 위반)



-- 테이블 생성 이후 제약조건 추가 및 변경, 삭제
-- 제약 조건은 추가, 삭제만 가능(변경 不可)
-- 변경하려면 삭제하고 새로운 내용으로 추가해야 함
CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1)
);

--PK 추가
ALTER TABLE dept2 ADD CONSTRAINT dept2_deptno_pk PRIMARY KEY(dept_no);

--FK 추가
ALTER TABLE dept2 ADD CONSTRAINT dept2_loca_locid_fk
FOREIGN KEY(loca) REFERENCES locations(location_id);

--CHECK 추가
ALTER TABLE dept2 ADD CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 10000);

--unique 추가
ALTER TABLE dept2 ADD CONSTRAINT dept2_deptname_uk UNIQUE(dept_name);

--NOT NULL은 열 수정형태로 변경합니다
ALTER TABLE dept2 MODIFY dept_bonus NUMBER(10) NOT NULL; --시스템 名


--제약 조건 확인
SELECT * FROM user_constraints
WHERE table_name = 'DEPT2';

--제약 조건 삭제
ALTER TABLE dept2 DROP CONSTRAINT dept2_deptno_pk;