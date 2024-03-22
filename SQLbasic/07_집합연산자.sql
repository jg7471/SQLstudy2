-- 집합 연산자
-- 서로 다른 쿼리 결과의 행들을 하나로 결합, 비교, 차이를 구할 수 있게 해 주는 연산자
-- UNION(합집합 중복x), UNION ALL(합집합 중복 o), INTERSECT(교집합), MINUS(차집합)
-- 위 아래 column 개수와 데이터 타입이 정확히 일치해야 합니다.




--UNION -> 중복 데이터를 허용하지 않음
SELECT --10건
    employee_id, first_name, hire_date --아이디 위아래 같아야 집합 같아야함
FROM employees
WHERE hire_date LIKE '04%'
UNION --중복을 허용하지 않는 합집합(Michael 비중복)
SELECT --2건
    employee_id, first_name, hire_date
FROM employees
WHERE department_id = 20;




-- UNION ALL -> 중복 데이터 허용
SELECT --10건
    employee_id, first_name, hire_date
FROM employees
WHERE hire_date LIKE '04%'
UNION ALL --중복을 허용하는 합집합(Michael 중복)
SELECT --2건
    employee_id, first_name, hire_date
FROM employees
WHERE department_id = 20;




--INTERSECT 교집합
SELECT --10건
    employee_id, first_name, hire_date
FROM employees
WHERE hire_date LIKE '04%'
INTERSECT
SELECT --2건
    employee_id, first_name, hire_date
FROM employees
WHERE department_id = 20;




--MINUS
SELECT --10건 --기준점
    employee_id, first_name, hire_date
FROM employees
WHERE hire_date LIKE '04%'
MINUS --Michael(중복값) 제외됨
SELECT --2건
    employee_id, first_name, hire_date
FROM employees
WHERE department_id = 20;



SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20
MINUS
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%';

