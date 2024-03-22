/*
view는 제한적인 자료만 보기 위해 사용하는 가상 테이블의 개념입니다.
뷰는 기본 테이블로 유도된 가상 테이블이기 때문에
필요한 컬럼만 저장해 두면 관리가 용이해 집니다.
뷰는 가상테이블로 실제 데이터가 물리적으로 저장된 형태는 아닙니다.
뷰를 통해서 데이터에 접근하면 원본 데이터는 안전하게 보호될 수 있습니다.

ex 파견직원에게 테이블 제공?, 보안성↑
VIEW(단순, 복합) : INSERT 不可, 용량 無
*/

SELECT * FROM user_sys_privs; --오라클 제공

--단순 뷰 : 하나의 테이블을 이용하여 생성한 뷰
--뷰의 컬럼명은 함수 호출문, 연산식 등 같은 가상 표현식(first_name || ' ' || last_name)이면 안됨
SELECT
    employee_id,
    first_name || ' ' || last_name,
    job_id,
    salary
FROM employees
WHERE department_id = 60;

CREATE VIEW view_emp AS ( --단순 VIEW 생성 : 하나의 TABLE을 기반으로 생성 
    SELECT
        employee_id,
        first_name || ' ' || last_name AS full_name, --가상 표현식
        job_id,
        salary
    FROM employees
    WHERE department_id = 60
);


SELECT * FROM view_emp
WHERE salary >= 6000;

--복합 VIEW : JOIN이 안들어 가서 짧아진다
--여러 테이블을 조인하여 필요한 데이터만 저장하고 빠른 확인을 위해 사용
CREATE VIEW view_emp_dept_job AS (
    SELECT
        e.employee_id,
        e.first_name || ' ' || last_name AS full_name,
        d.department_name,
        j.job_title
    
    FROM employees e
    
    LEFT JOIN departments d
    ON e.department_id = d.department_id --JOIN 조건
    
    LEFT JOIN jobs j
    ON e.job_id = j.job_id
)
ORDER BY employee_id;

SELECT * FROM view_emp_dept_job;



--VIEW 수정 (CREATE OR REPLACE VIEW 구문)
--동일 이름으로 해당 구문을 사용하면 데이터가 변경되면서 새롭게 생성됨
CREATE OR REPLACE VIEW view_emp_dept_job AS (
    SELECT
        e.employee_id,
        e.first_name || ' ' || last_name AS full_name,
        d.department_name,
        j.job_title,
        e.salary --컬럼추가
    
    FROM employees e
    
    LEFT JOIN departments d
    ON e.department_id = d.department_id --JOIN 조건
    
    LEFT JOIN jobs j
    ON e.job_id = j.job_id
)
ORDER BY employee_id;

SELECT * FROM view_emp_dept_job;


SELECT
    job_title,
    AVG(salary) AS avg
    
FROM view_emp_dept_job
GROUP BY job_title
ORDER BY avg DESC; --SQL 구문이 간결해짐

--VIEW 삭제
DROP VIEW view_emp;


/*
VIEW에 INSERT가 일어나는 경우 실제 테이블에도 반영이 됩니다.
그래서 VIEW의 INSERT, UPDATE, DELETE는 많은 제약 사항이 따릅니다.
원본 테이블이 NOT NULL인 경우 VIEW에 INSERT가 불가능합니다.
VIEW에서 사용하는 컬럼이 가상열인 경우에도 안됩니다.
*/

--두 번째 컬럼인 'full_name'은 가상열(virtual column)이기 때문에 INSERT 안됨
INSERT INTO view_emp_dept_job --VIEW INSERT 하면 원본 TABLE에도 영향이 감
VALUES(300, 'test', 'test', 'test', 10000); --에러


--JOIN된 VIEW(복합 view)의 경우에는 한번에 삽입 不可
INSERT INTO view_emp_dept_job
    (employee_id, department_name, job_title, salary) --department_name PK
VALUES(300, 'test', 'test', 10000);
--복합 VIEW INSERT 不可, READ ONLY


--원본 테이블 컬럼 중 NOT NULL 컬럼이 존재하고, 해당 컬럼을 view로 지목할 수 없다면, INSERT 不可
INSERT INTO view_emp --단순view
    (employee_id, job_id, salary)
VALUES(300, 'test', 10000);

--DELETE
DELETE FROM view_emp
WHERE employee_id = 107; --VIEW에서 107 삭제됨 ->원본 테이블도 삭제됨 : 그렇지만 하지마라

SELECT * FROM view_emp; --VIEW
SELECT * FROM employees; --원본

ROLLBACK;

--WITH CHECK OPTION ->조건 제약 컬럼
--VIEW를 생성할 때 사용한 조건 컬럼은 VIEW를 통해서 변경할 수 없게 해주는 키워드

CREATE OR REPLACE VIEW view_emp_test AS (
    SELECT
    employee_id,
    first_name,
    last_name,
    email,
    hire_date,
    job_id,
    department_id
    
    FROM employees
    WHERE department_id = 60
)
WITH CHECK OPTION CONSTRAINT view_emp_test_ck; --CONSTRAINT view_emp_test_ck 이름 생성(옵션) : 무결성 보증

SELECT * FROM view_emp_test;

UPDATE view_emp_test
SET department_id = 100 --WHERE department_id = 60 조건에 위배
WHERE employee_id = 107;

--읽기 전용 VIEW READ ONLY(DML 연산 막음 : SELECT만 허용)

CREATE OR REPLACE VIEW view_emp_test AS (
    SELECT
    employee_id,
    first_name,
    last_name,
    email,
    hire_date,
    job_id,
    department_id
    
    FROM employees
    WHERE department_id = 60
)
WITH READ ONLY;