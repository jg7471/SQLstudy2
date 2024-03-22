

-- Oracle의 한 줄 주석
/*
여러줄 주석
*/

-- SELECT [컬럼명(어러 개 가능)] FROM [테이블 이름]
SELECT
    employee_id, 
    first_name, 
    last_name
FROM
    employees; -- * ALL의 의미 --sql 대소문자 구분X but 관례는 키워드 대문자//식별자 소문자
    --원래는 이렇게 개행함

SELECT email, phone_number, hire_date
From employees;

-- 컬럼을 조회하는 위치에서 * / + - 연산이 가능합니다
SELECT
    employee_id,
    first_name,
    last_name,
    salary,
    salary + salary *0.6 as 성과급 --조회만 가능 --실제 데이터는 변하지 않음
FROM employees;

--NULL 값의 확인(숫자 0이나 공백과는 다른 존재)
SELECT department_id, commission_pct --성과금
FROM employees;

SELECT
    first_name AS 성, --alias(컬럼명, 테이블명의 이름을 변경해서 조회)
    last_name AS 이름,
    salary AS 급여    
FROM employees;



/*
오라클은 홑따옴표로 문자를 표현하고, 문자열 안에 홑따옴표 특수기호를
표현하고 싶다면 ''를 두 번 연속으로 쓰시면 됩니다.
문자열 연결기호는 || 입니다. 문자열의 덧셈 연산을 허용하지 않습니다.
*/
SELECT
    first_name || ' ' || last_name ||'''s salay is ' || salary AS 급여내역
FROM employees; --FROM부터 작성// SQL FROM부터 가장 먼저 실행됨 -- '('')홑따움표


--DISTINCT(중복 행의 제거)
SELECT department_id FROM employees;
SELECT DISTINCT department_id FROM employees; --중복 제거 : 분명한

--ROWNUM,ROWID --주소값
--ROWNUM : 쿼리에 의해 반환되는 행 번호를 출력 (페이징 할 때 씀)
--ROWID : 데이터베이스 내의 행의 주소를 반환(쓸 일 거의 없음)
SELECT ROWNUM, ROWID, employee_id
FROM employees;
