
--시퀀스(순차적으로 증가하는 값을 만들어 주는 객체) 

CREATE SEQUENCE dept2_seq --()없음
    START WITH 1 --시작값(기본값은 증가할 때 최소값, 감소할 때 최대값) : 생략 가능
    INCREMENT BY 1 --증가값(양수면 증가, 음수면 감소, 기본값 1) : 10, -1 가능
    MAXVALUE 10 --최대값(기본값은 증가일 때 1027, 감소일 때 -1)
    MINVALUE 1 --최소값 (기본값은 증가일 때 1 감소일 때 -1028)
    NOCACHE --캐시 메모리 사용 여부 (CACHE) : 사용하지 않는게(기본값 CACHE) 좋음->NOCACHE
    NOCYCLE; --순환 여부 (NOCYCLE이 기본, 순환시키려면 CYCLE) : 12345/12345/12345
    --프라리머리키 사용하면 노사이클로 가셈
    
  
  
    
CREATE TABLE dept2 (
    dept_no NUMBER(2) PRIMARY KEY,
    dept_name VARCHAR2(14),
    loca VARCHAR2(13),
    dept_date DATE
);

--시퀀스 사용하기(NEXTVAL, CURRVAL)
SELECT dept2_seq.CURRVAL FROM dual; --현재 스퀀스값 확인

INSERT INTO dept2
VALUES(dept2_seq.NEXTVAL, 'test', 'test', sysdate); ----INSERT 실행 시 다음값++ : MAXVALUE 설정값 초과 불가 : 감소 -- 不可

SELECT * FROM dept2;

DROP TABLE dept2;

--시퀀스 속성 수정(직접 수정 가능)
--START WITH 수정 불가
ALTER SEQUENCE dept2_seq MAXVALUE 9999; --최대값 증가
ALTER SEQUENCE dept2_seq INCREMENT BY -1; --증가값 변경 : 감소 불가
ALTER SEQUENCE dept2_seq MINVALUE 0;
--시퀀스 폴더 존재

--시퀀스 값을 다시 처음으로 돌리는 방법
ALTER SEQUENCE dept2_seq INCREMENT BY -16; --현재 나의 CURRVAL값
SELECT dept2_seq.NEXTVAL FROM dual; -- 0으로 초기화
ALTER SEQUENCE dept2_seq INCREMENT BY 1; --다시 1부터 시작

-- -> DROP하고 재생성 하는게 더 빠름
DROP SEQUENCE dept2_seq;

--mySQL은 자동으로 시퀀스 생성해줌

--------------------------------------------------------------------------------
--INDEX 데이터 검색 빠르게 해주는 역할 : 깊이 배우지 않음(고급 문법)
--데이터 많을시 유리

/*
- index
index는 primary key, unique 제약 조건에서 자동으로 생성되고,
조회를 빠르게 해 주는 hint 역할을 합니다.
index는 조회를 빠르게 하지만, 무작위하게 많은 인덱스를 생성해서
사용하면 오히려 성능 부하를 일으킬 수 있습니다.
정말 필요할 때만 index를 사용하는 것이 바람직합니다.
*/
SELECT * FROM employees
WHERE employee_id = 158;

--인덱스 생성
CREATE INDEX emp_salary_idx ON employees(salary); --F10으로 실행계획 확인 가능

/*
테이블 조회 시 인덱스가 붙은 컬럼을 조건절로 사용한다면
테이블 전체 조회가 아닌, 컬럼에 붙은 인덱스를 이용해서 조회를 진행합니다.
인덱스를 생성하게 되면 지정한 컬럼에 ROWID를 붙인 인덱스가 준비되고, 
조회를 진행할 시 해당 인덱스의 ROWID를 통해 빠른 스캔을 가능하게 합니다.
*/

DROP INDEX emp_salary_idx;

/*
- 인덱스가 권장되는 경우 
1. 컬럼이 WHERE 또는 조인조건에서 자주 사용되는 경우
2. 열이 광범위한 값을 포함하는 경우
3. 테이블이 대형인 경우
4. 타겟 컬럼이 많은 수의 null값을 포함하는 경우.
5. 테이블이 자주 수정되고, 이미 하나 이상의 인덱스를 가지고 있는 경우에는
 권장하지 않습니다.
 ->PK 사용권장
*/
