
--그룹함수 AVG, MAX, MIN, SUM, COUNT : 사용하려면 그룹을 해야 함
--그룹화를 따로 하지 않으면 그룹은 테이블 전체가 됩니다.
SELECT
    AVG(salary),
    MAX(salary),
    MIN(salary),
    SUM(salary),
    COUNT(salary)
FROM employees;

SELECT COUNT(*) --총 행의 수
FROM employees;

SELECT COUNT(first_name) FROM employees; --요렇게도 됨(위와 같은 결과)
SELECT COUNT(commission_pct) FROM employees; --null이 아닌 행의 수
SELECT COUNT(manager_id) FROM employees;

SELECT * FROM employees;

--부서별로 그룹화, 그룹함수의 사용
SELECT
    department_id,
    AVG(salary) --department_id(각 부서)의 평균
FROM employees
GROUP BY department_id; --해당 항목 그룹화

-- 주의할 점
-- 그룹 함수는 단독적으로 사용될 때는 전체 테이블이 그룹의 대상이 되지만
-- 일반 컬럼과 동시에 그냥 출력될 수는 없습니다. 그룹이 필요합니다.
SELECT
    department_id,
    AVG(salary)
FROM employees; --에러

-- GROUP BY절을 사용할 때 GROUP 절에 묶이지 않은 컬럼은 조회 불가
SELECT
    job_id,
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id; --에러(job_id 없음)

-- ★GROUP BY절 2개 이상 사용 : 중복 발생
SELECT
    job_id,
    department_id,
    AVG(salary)
FROM employees
GROUP BY job_id, department_id;

--GROUP BY를 통해 그룹화 할 때 조건을 걸 경우 HAVING을 사용
--WHERE은 일반 조건절 GROUP BY 보다 먼저 진행
SELECT
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 100000;
--SQL 실행순서 FROM -> WHERE -> GROUP BY -> HAVING -> SELECT(평균 세팅) -> ORDER BY(평균 사용가능) : 효율성 : 그래서 WHERE (salary) > 10000; 불가
--ORDER BY 제일 아래

SELECT
    job_id,
    count(*)
FROM employees
GROUP BY job_id
HAVING COUNT(*) >= 5; --count가 5 이상

--부서 아이디가 50 이상인 것들을 그룹화 시키고, 그룹 급여 평균이 5000 이상만 조회
--내가 작성
SELECT
    department_id, AVG(salary)
FROM employees
WHERE salary > 5000
GROUP BY department_id
HAVING department_id > 50
ORDER BY AVG(salary) DESC;

--해답
SELECT
    department_id,
    AVG(salary) AS 평균
FROM employees
WHERE department_id >= 50
GROUP BY department_id
HAVING AVG(salary) >= 5000
ORDER BY 평균 DESC;

    



/*
문제 1.
1-1. 사원 테이블에서 JOB_ID별 사원 수를 구하세요.
1-2. 사원 테이블에서 JOB_ID별 월급의 평균을 구하세요. 월급의 평균 순으로 내림차순 정렬하세요.
*/

--해설
SELECT
    job_id,
    COUNT(*),
    AVG(salary) AS 평균월급
FROM employees
GROUP BY job_id
ORDER BY 평균월급 DESC;



--내가 작성 1차
SELECT
    job_id, salary
FROM employees
GROUP BY job_id, salary
HAVING AVG (salary) > 1
ORDER BY salary DESC;

--내가 작성 2차
SELECT COUNT(job_id), AVG(salary), job_id
FROM employees
GROUP BY job_id
ORDER BY AVG(salary) DESC;






/*
문제 2.
사원 테이블에서 입사 년도 별 사원 수를 구하세요.
(TO_CHAR() 함수를 사용해서 연도만 변환합니다. 그리고 그것을 그룹화 합니다.)
*/

--해설
SELECT
    TO_CHAR(hire_date, 'yy') AS 입사년도,
    COUNT(*) AS 사원수
FROM employees
GROUP BY TO_CHAR(hire_date, 'yy')
ORDER BY 입사년도;

--내가 작성 1차
SELECT
    first_name, TO_CHAR(hire_date, '99/99/99 99:99:99')
FROM employees
WHERE hire_date LIKE '__'
GROUP BY first_name, hire_date
ORDER BY hire_date DESC;


--내가작성 2차
SELECT
    hire_date,
    COUNT(TO_CHAR(hire_date, 'YY/MM/DD HH:MI:SS'))
FROM employees
WHERE hire_date LIKE '__%'
GROUP BY COUNT(TO_CHAR(hire_date, 'YY/MM/DD HH:MI:SS'))
ORDER BY hire_date;


--내가 작성 3차
SELECT
    TO_CHAR(hire_date, 'yy'),
    COUNT(*)
FROM employees
GROUP BY TO_CHAR(hire_date, 'yy')
ORDER BY TO_CHAR(hire_date, 'yy') DESC;











/*
문제 3.
급여가 5000 이상(WHERE 일반조건)인 사원들의 부서별 평균 급여를 출력하세요. 
단 부서 평균 급여가 7000이상(GROUP 그룹화조건)인 부서만 출력하세요.
*/


--내가 작성
SELECT department_id, salary
FROM employees
WHERE salary >= 5000
HAVING
    AVG (salary) >= 7000
GROUP BY department_id, salary    
ORDER BY salary DESC;


    
    

/*
문제 4.
사원 테이블에서 commission_pct(커미션) 컬럼이 null이 아닌 사람들의
department_id(부서별) salary(월급)의 평균, 합계, count를 구합니다.
조건 1) 월급의 평균은 커미션을 적용시킨 월급입니다.
조건 2) 평균은 소수 2째 자리에서 절삭 하세요.
*/


--내가 작성 2차
SELECT
    department_id,
    TRUNC(AVG(salary + salary*commission_pct), 2),
    SUM(salary + salary*commission_pct)
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id;





--내가 작성 1차
SELECT TRUNC(salary), COUNT (department_id)
WHERE commission_pct IS NOT NULL
FROM employees
HAVING 
    AVG (salary) >= 1
    SUM (salary) >= 1
    COUNT(department_id) >= 5
GROUP BY department_id, salary;



--해설
SELECT
    department_id,
    TRUNC(AVG(salary + salary*commission_pct), 2) AS avg_salary,
    SUM(salary + salary*commission_pct) AS sum,
    COUNT(*) AS count
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id;


