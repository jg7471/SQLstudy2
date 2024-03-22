SELECT *
FROM employees;

-- WHERE절 비교 (데이터 값은 대/소문자를 구분)
SELECT first_name, last_name, job_id
FROM employees
WHERE job_id = 'IT_PROG'; --it_prog 안됨(비교하는 조건)

SELECT *
FROM employees
WHERE last_name = 'King';

SELECT *
FROM employees
WHERE department_id = 50; --'50', 50 //같음 부서번호가 50 : 암묵적 형변환

SELECT *
FROM employees
WHERE hire_date = '04/01/30'; --날짜 형태

SELECT *
FROM employees
WHERE salary >= 15000
AND salary < 20000;

--데이터의 행 제한(BETWEEN, IN, LIKE)
SELECT * FROM employees
WHERE salary BETWEEN 15000 AND 20000; --결과 위와 동일, 위가 연산속도 조금 더 빠름

SELECT * FROM employees
WHERE hire_date BETWEEN '03/01/01' AND '03/12/31';

--IN 연산자의 사용(특정 값들과 비교할 때 사용)
SELECT * FROM employees
WHERE manager_id IN (100, 101, 102);

SELECT * FROM employees
WHERE job_id IN ('IT_PROG', 'AD VP');

--LIKE 연산자
--%는 어떠한 문자든, _는 데이터의 자리(위치)를 표현할 때
--WHERE LIKE %라면% --홈페이지 검색 列 : 라면 맛있게 끓이는 법 검색


SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '03%'; -- % 뒤 : anything :03으로만 시작하면 상관없다

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%15'; -- 앞 % :anything :15로만 시작하면 상관없다

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%05%'; -- 앞뒤 상관X 05만 포함되어 있으면 가져오기

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '___05%'; -- ___앞에 세글자 있고(月) 05가 있음 % 그뒤는 상관X

SELECT * FROM employees
WHERE commission_pct IS NULL; -- NULL 여부 확인  NULL 은 = 동등연산자로 비교 X

SELECT * FROM employees
WHERE commission_pct IS NOT NULL;

--AND, OR : AND >>> OR
SELECT * FROM employees
WHERE (job_id = 'IT_PROG'
OR job_id = 'FI_MGR') --1번 조건
AND salary >= 6000; --AND가 우선 실행됨 : WHERE 나중에 실행 됨(IT_PROG만 조회 되지 않았다)->()사용 우선순위 설정 --2번 조건

--데이터의 정렬 (SELECT 구문의 가장 마지막에 배치됨)
--ASC : ascending 오름차순(생략가능 : 기본값)
--DESC : descending 내림차순
SELECT * FROM employees
ORDER BY hire_date ASC; --입사일자 빠른 순으로(ASC 생략가능)

SELECT * FROM employees
ORDER BY hire_date DESC; --입사일자 빠른 순으로

SELECT * FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY first_name ASC;

SELECT * FROM employees
WHERE salary >= 5000
ORDER BY employee_id DESC; --ORDER BY 항상 마지막

SELECT
    first_name,
    salary*12 AS pay --pay로 별칭
    
FROM employees
ORDER BY pay ASC; --pay(별칭(가상))도 정렬 설정 가능

