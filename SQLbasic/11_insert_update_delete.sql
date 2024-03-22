

--INSERT
--테이블 구조 확인
DESC departments; --NOT NULL 필수값

--INSERT 첫번째 방법(모든 컬럼 데이터를 한 번에 지정해서 삽입)
INSERT INTO departments
VALUES(300, '개발부', 100, 1500); --VALUES ? 다 삽입

VALUES(300, '개발부')--에러 --컬럼을 지정하지 않고 값만 주는 경우는 모든 값을 다 줘야한다(NULL 허용 여부 상관없이)

SELECT * FROM departments; --데이터 조회
ROLLBACK;--데이터 삽입 취소(실행 시점을 다시 뒤로 돌리는 키워드)

/*
이름              널?       유형           
--------------- -------- ------------ 
DEPARTMENT_ID   NOT NULL NUMBER(4)   --필수(데이터타입 number) 
DEPARTMENT_NAME NOT NULL VARCHAR2(30)--필수
MANAGER_ID               NUMBER(6)   --옵션
LOCATION_ID              NUMBER(4)   --옵션
*/

--INSERT의 두번째 방법 (직접 컬럼을 지정하고 저장, NOT NULL 컬럼을 확인하세요)
INSERT INTO departments
    (department_id, department_name)
VALUES
    (300, '개발부');
--VALUES로 生 삽입시 전부 입력(NOT NULL 포함), INSERT INTO로 지정시 선택 삽입 가능

ROLLBACK;

INSERT INTO departments
    (department_id, location_id) --에러 -> department_name이 NOT NULL
VALUES
    (301, 1500);--DEPARTMENT_NAME 필수값 미삽입
    
    
--사본 테이블 생성
--사본 테이블을 생성할 때 그냥 생성하면 -> 조회된 데이터까지 모두 복수
--WHERE 절에 false(1=2) 지정하면 -> 테이블의 구조만 복사되고 데이터는 복사 X
--CTAS(복사)문은 컬럼의 구조와 데이터를 복사할 뿐, 제약조건(PrimaryKey, ForginKey...)은 복제되지 않음

CREATE TABLE emps AS
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE 1 = 2); -- 2 flase : 내부의 데이터 복사x : 구조만 따옴

SELECT * FROM emps;
DROP TABLE emps; -- 테이블 삭제

-- INSERT (서브쿼리)
INSERT INTO emps
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE department_id = 50);

SELECT * FROM emps
WHERE employee_id = 120;

--INSERT 방식 (컬럼지목X 한번에, 원하는 컬럼만, 서브쿼리)
--------------------------------------------------------------------------------
--UPDATE
--UPDATE 테이블이름 SET 컬럼=값, 컬럼=값... WHERE 누구를 수정할지(조건)
CREATE TABLE emps AS
(SELECT * FROM employees); --테이블 고대로 복제

SELECT * FROM emps;

--UPDATE를 진행할 때는 누구를 수정할 지 조건으로 잘 지목해야 합니다
--그렇지 않으면 수정 대상이 전체 테이블로 지정됨(일괄수정)
UPDATE emps SET salary = 30000;
ROLLBACK;

UPDATE emps SET salary = 30000
WHERE employee_id = 100;
SELECT * FROM emps;

ROLLBACK;

UPDATE emps SET salary = salary + salary*0.1 --수정
WHERE employee_id = 100;

UPDATE emps
SET phone_number = '010.5421.1286', manager_Id = 102 --100번의 phone_number, manager_Id 변경함
WHERE employee_id = 100;

--UPDATE(서브쿼리)
UPDATE emps --100번의 job_id, salary, manager_id를 101로 복사
SET (job_id, salary, manager_id) =
    (
        SELECT job_id, salary, manager_id
        FROM emps
        WHERE employee_id = 100
    )
WHERE employee_id = 101;


--DELETE
--DELETE도 WHERE을 지정하지 않으면 테이블 전체행이 대상이 됩니다

--DELETE * FROM emps 
--WHERE employee_id = 103; --불가 : 삭제대상 한 행(한줄), 컬럼 하나만 지우고 싶으면 UPDATE

--DELETE 여러줄 지목시 삭제 가능!!

DELETE FROM emps; --지정 안할시 전체 삭제

DELETE FROM emps
WHERE employee_id = 103;

SELECT * FROM emps;


--DELETE(서브쿼리)
DELETE FROM emps
WHERE department_id = (SELECT department_id FROM departments
                        WHERE department_name = 'IT');
                        
                        
