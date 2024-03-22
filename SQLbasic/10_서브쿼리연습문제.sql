/*
문제 1.
-EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 // 높은 사원들의 데이터를 출력 하세요 
(AVG(컬럼) 사용)
-EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들의 수를 출력하세요
-EMPLOYEES 테이블에서 job_id가 IT_PROG인 사원들의 평균급여보다 높은 사원들의 
데이터를 출력하세요
*/

--FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY


--해설
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT COUNT(*)
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees WHERE job_id = 'IT_PROG');





--내가 작성
SELECT e.*

FROM employees e JOIN
(SELECT

FROM
    employees
ON;





--** SQL의 실행 순서
--FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY

/*
문제 2.
-DEPARTMENTS테이블에서 manager_id가 100인 부서에 속해있는 사람들의
모든 정보를 출력하세요.
*/

SELECT *
FROM employees
WHERE department_id = ( SELECT department_id FROM departments WHERE manager_id = 100);











--해설
SELECT * FROM employees
WHERE department_id = (SELECT department_id FROM departments
                        WHERE manager_id = 100); --SELECT department_id 외부키

--내가 작성
SELECT *
    FROM JOIN 
 9000   ( SELECT employees e 
    FROM
        departments d
    WHERE manager_id = 100
    )
ON e.manager_id = d.manager_id;

/*
문제 3.
-EMPLOYEES테이블에서 “Pat”의 manager_id보다 높은 manager_id를 갖는 모든 사원의 데이터를 
출력하세요
-EMPLOYEES테이블에서 “James”(2명)들의 manager_id를 갖는 모든 사원의 데이터를 출력하세요.
*/

SELECT *
FROM employees
WHERE manager_id IN ( SELECT manager_id FROM employees WHERE first_name = 'James');








--해설
SELECT * FROM employees
WHERE manager_id > (SELECT manager_id FROM employees
                    WHERE first_name = 'Pat');

SELECT * FROM employees
WHERE manager_id IN (SELECT manager_id FROM employees
                    WHERE first_name = 'James');


/*
문제 4.
-EMPLOYEES테이블 에서 first_name기준으로 내림차순 정렬하고, 41~50번째 데이터의 
행 번호, 이름을 출력하세요
*/
--FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY

--복습
SELECT *
    FROM(
        SELECT ROWNUM AS RN, tbl.first_name
        FROM
            (
            SELECT * FROM employees
            ORDER BY first_name DESC
            ) tbl
        )
WHERE 41 > RN AND RN < 50;



--해설
SELECT * FROM
    (
    SELECT ROWNUM AS rn, tbl.first_name
        FROM
        (
        --요걸 가장 안쪽으로 : 먼저 확인
        SELECT * FROM employees
        ORDER BY first_name DESC
        ) tbl --별칭 --1번 이름 정렬
    )   --2번 RN(ROWNUM : 랭킹)넣기
WHERE rn BETWEEN 41 AND 50; --3번 자르기




--내가 작성
SELECT
    ROWNUM AS rn, tbl.*
    FROM
    (
    SELECT *
    FROM employees
    ORDER BY first_name DESC
    ) tbl
WHERE rn > 40 AND rn <= 50;

/*
문제 5.
-EMPLOYEES테이블에서 hire_date기준으로 오름차순 정렬하고, 31~40번째 데이터의 
행 번호, 사원id, 이름, 전화번호, 입사일을 출력하세요.
*/

SELECT * FROM 
    (
    SELECT ROWNUM AS RN, tbl.employee_id, tbl.first_name, tbl.phone_number, tbl.hire_date
    FROM
        (
        SELECT * FROM employees
        ORDER BY hire_date ASC
        )tbl
    )
WHERE RN > 30 AND RN <= 40;






--해설
SELECT * FROM
    (
    SELECT ROWNUM AS rn, tbl.employee_id, tbl.first_name,
    tbl.phone_number, tbl.hire_date
        FROM
        (--가상 테이블
        SELECT * FROM employees
        ORDER BY hire_date ASC
        ) tbl --별칭
    )   
WHERE rn BETWEEN 31 AND 40;


--내가 작성
SELECT
    ROWNUM AS rn, tbl.*
    FROM
    (
    SELECT
        *
    FROM employees
    ORDER BY hire_date
    ) tbl
WHERE rn > 31 AND rn <= 40;



/*
문제 6.
employees테이블 departments테이블을 left 조인하세요
조건) 직원아이디, 이름(성, 이름), 부서아이디, 부서명 만 출력합니다.
조건) 직원아이디 기준 오름차순 정렬
*/

--해설
SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name AS full_name,
    e.department_id,
    d.department_name

FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY e.employee_id;



--내가 작성
SELECT e.employee_id, e.first_name || ' ' || e.last_name, e.department_id
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY e.department_id;



/*
문제 7.
문제 6의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
employees테이블 departments테이블을 left 조인하세요
조건) 직원아이디, 이름(성, 이름), 부서아이디, 부서명 만 출력합니다.
조건) 직원아이디 기준 오름차순 정렬
*/

--복습
SELECT e.employee_id, e.first_name, e.department_id,
    (
    SELECT d.department_name 
    FROM departments d
    WHERE e.department_id = d.department_id
    )AS departname
    FROM employees e
ORDER BY employee_id ASC;



--해설
SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name AS full_name,
    e.department_id, --SELECT에 추가
    (SELECT department_name --부서명
    FROM departments d
    WHERE d.department_id = e.department_id)AS dept_name --WHERE에서 JOIN
FROM employees e
ORDER BY e.employee_id;




/*
문제 8.
departments테이블 locations테이블을 left 조인하세요
조건) 부서아이디, 부서이름, 매니저아이디, 로케이션아이디, 스트릿_어드레스, 포스트 코드, 시티 만 출력합니다
조건) 부서아이디 기준 오름차순 정렬
*/

--내가 작성
SELECT *
FROM departments d
LEFT JOIN locations l
ON d.location_id = l.location_id
ORDER BY d.department_id ASC;


--해설
SELECT
    d.department_id, d.department_name, d.manager_id, d.location_id,
    loc.street_address, loc.postal_code, loc.city
FROM departments d
LEFT JOIN locations loc
ON d.location_id = loc.location_id
ORDER BY department_id;


/*
문제 9.
문제 8의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
departments테이블 locations테이블을 조인하세요
조건) 부서아이디, 부서이름, 매니저아이디, 로케이션아이디, 스트릿_어드레스, 포스트 코드, 시티 만 출력합니다
조건) 부서아이디 기준 오름차순 정렬
*/

--복습
SELECT d.department_id, d.department_name, d.location_id, --쉼표 주의
    (
    SELECT loc.street_address
    FROM locations loc
    WHERE d.location_id = loc.location_id
    ), --쉼표 주의
    (
    SELECT loc.postal_code
    FROM locations loc
    WHERE d.location_id = loc.location_id
    ),
    (
    SELECT loc.city
    FROM locations loc
    WHERE d.location_id = loc.location_id
    )
FROM departments d
ORDER BY d.department_id ASC;

--해설
SELECT
    d.department_id, d.department_name, d.manager_id, d.location_id,
    (SELECT loc.street_address --컬럼 증가 할 수록 JOIN이 더 빠름
    FROM locations loc
    WHERE d.location_id = loc.location_id) AS street_address,
    (SELECT loc.postal_code
    FROM locations loc
    WHERE d.location_id = loc.location_id) AS postal_code,
    (SELECT loc.city
    FROM locations loc
    WHERE d.location_id = loc.location_id) AS city
FROM departments d
ORDER BY d.department_id;

--내가 작성
SELECT * FROM
    (
    SELECT department_id
    FROM departments d
    WHERE d.location_id = l.location_id
    );

/*
문제 10.
locations테이블 countries 테이블을 left 조인하세요
조건) 로케이션아이디, 주소, 시티, country_id, country_name 만 출력합니다
조건) country_name기준 오름차순 정렬
*/
--내가 작성
SELECT *
FROM locations l
LEFT JOIN countries c
ON l.country_id = c.country_id
ORDER BY country_name ASC;


--해설
SELECT
    loc.location_id, loc.street_address, loc.city,
    c.country_id, c.country_name
FROM locations loc
LEFT JOIN countries c
ON loc.country_id = c.country_id
ORDER BY c.country_id;



/*
문제 11.
문제 10의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
locations테이블 countries 테이블을 조인하세요
조건) 로케이션아이디, 주소, 시티, country_id, country_name 만 출력합니다
조건) country_name기준 오름차순 정렬
*/

--복습
SELECT
    l.location_id, l.street_address, l.city, l.country_id,
    (
    SELECT c.country_name
    FROM countries c
    WHERE l.country_id = c.country_id
    )
FROM locations l
ORDER BY l.country_id; --바깥이면 바깥거 사용해라





--내가 작성
SELECT *
    (
    SELECT country_name
    FROM countries c
    WHERE c.country_id = l.country_id) AS tbl
FROM locations l;

--해설

SELECT
    loc.location_id, loc.street_address, loc.city, loc.country_id,  --최대한 스칼라 덜 사용하게 하려고
    (SELECT country_name 
    FROM countries c
    WHERE loc.country_id = c.country_id) AS country_name
FROM locations loc
ORDER BY loc.country_id;

/*
문제 12. 
employees테이블, departments테이블을 left조인 hire_date를 오름차순 기준으로 
11-20번째 데이터만 출력합니다.
조건) rownum을 적용하여 번호, 직원아이디, 이름, 전화번호, 입사일, 
부서아이디, 부서이름 을 출력합니다.
조건) hire_date를 기준으로 오름차순 정렬 되어야 합니다. rownum이 틀어지면 안됩니다.
*/

--복습
SELECT * FROM(
    SELECT ROWNUM AS rn, tbl.*
        FROM(
        SELECT e.employee_id, e.first_name, e.phone_number, e.hire_date
        FROM employees e LEFT JOIN departments d
        ON e.employee_id = d.department_id
        ORDER BY hire_date ASC 
        )tbl
    )
WHERE rn > 11 AND rn < 20;


--내가 작성
SELECT *
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE ;


--해설
SELECT * FROM
    (--ROWNUM 범위 지정 위해
    SELECT ROWNUM AS rn, tbl.* --안에서 SELECT 해놔서 tbl.*하면 됨 --2번 ROWNUM rn 세팅
        FROM 
        (
        SELECT
            e.employee_id, e.first_name, e.phone_number, e.hire_date,
            d.department_id, d.department_name
        FROM employees e LEFT JOIN departments d
        ON e.department_id = d.department_id
        ORDER BY hire_date --1번 ORDER 정렬 + with LEFT JOIN
        ) tbl
    )
WHERE rn > 10 AND rn <= 20; --3번 rn WHERE 정렬 




/*
문제 13. 
--EMPLOYEES 와 DEPARTMENTS 테이블에서 JOB_ID가 SA_MAN 사원의 정보의 LAST_NAME, JOB_ID, 
DEPARTMENT_ID,DEPARTMENT_NAME을 출력하세요.
*/

--해설
SELECT
    tbl.*, d.department_name
FROM 
    (--1차 단일행
    SELECT
        last_name, job_id, department_id
    FROM employees
    WHERE job_id = 'SA_MAN'
    ) tbl
JOIN departments d --2차 JOIN
ON tbl.department_id = d.department_id; --新문법

--내가 작성
SELECT e.last_name, e.job_id, d.department_id, d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE job_id = 'SA_MAN';




/*
문제 14
-- DEPARTMENTS 테이블에서 각 부서의 ID, NAME, MANAGER_ID와 부서에 속한 인원수를 출력하세요.
-- 인원수 기준 내림차순 정렬하세요.
-- 사람이 없는 부서는 출력하지 않습니다.
*/







--해설 방법1 :
SELECT
    d.department_id, d.department_name, d.manager_id,
    a.total
FROM departments d
JOIN
    (
    SELECT
        department_id, COUNT(*) AS total
    FROM employees
    GROUP BY department_id
    ) a
ON d.department_id = a.department_id
ORDER BY a.total DESC;

--해설2

SELECT
    d.department_id, d.department_name, d.manager_id,
    (
        SELECT
            COUNT(*) --1번 : employees에서 인원수 카운트
        FROM employees e
        WHERE e.department_id = d.department_id
    ) AS total
FROM departments d
WHERE d.manager_id IS NOT NULL --2번 프라이머리키로 NULL 부서 확인
ORDER BY total DESC; --2번

--해설 3 추가문제(EXISTS) 추가

SELECT
    d.department_id, d.department_name, d.manager_id,
    (
        SELECT
            COUNT(*)
        FROM employees e
        WHERE e.department_id = d.department_id
    ) AS total
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
)
ORDER BY total DESC;

DELETE FROM employees
WHERE employee_id = 207;








--내가 작성
SELECT tbl.* , COUNT(department_id) AS members
FROM (
    SELECT tbl.* 
        FROM(
            SELECT department_id, department_name, manager_id
            FROM departments
            WHERE manager_id IS NOT NULL
        )tbl
    GROUP BY department_id;
    )
ORDER BY COUNT(members) DESC;



/*
문제 15
--부서에 대한 정보 전부와, 주소, 우편번호, 부서별 평균 연봉을 구해서 출력하세요.
--부서별 평균이 없으면 0으로 출력하세요.
*/


--해설 방법1 : 요걸로
SELECT
    d.*,
    loc.street_address, loc.postal_code,
    NVL(tbl.result, 0) AS 부서별평균급여 --NVL(컬럼(if nulll), 변환할 타겟값)
FROM departments d

JOIN locations loc
ON d.location_id = loc.location_id


LEFT JOIN ( --평균 급여를 先 구하기
    SELECT --연결고리
        department_id,
        TRUNC(AVG(salary), 0) AS result
    FROM employees
    GROUP BY department_id
) tbl
ON d.department_id = tbl.department_id


ORDER BY tbl.result;




--해설 방법2
SELECT
    d.*,
    loc.street_address, loc.postal_code,
    NVL(
    (
        SELECT
            TRUNC(AVG(salary), 0)
        FROM employees e
        WHERE e.department_id = d.department_id
    ),
    0) AS 부서별평균급여

FROM departments d
JOIN locations loc
ON d.location_id = loc.location_id
ORDER BY 부서별평균급여 DESC;











--내가 작성
SELECT
d.*, loc.street_address, AVG(d.salary)



SELECT department_id, --연결고리
       TRUNC(AVG(salary), 0) AS result
FROM departments d
GROUP BY department_id


    LEFT JOIN
    empolyees e 
    ON
    e.department_id = d.department_id
    
    LEFT JOIN
    locations loc
    ON
    loc.location_id = d.location_id

WHERE salary = AVG(d.salary);

/*
문제 16
-문제 15 결과에 대해 DEPARTMENT_ID기준으로 내림차순 정렬해서 
ROWNUM을 붙여 1-10 데이터 까지만 출력하세요.
*/

--해설 :방법1
SELECT * FROM
    (
    SELECT ROWNUM AS rn, tbl2.*
        FROM
        (
        SELECT
            d.*,
            loc.street_address, loc.postal_code,
            NVL(tbl.result, 0) AS 부서별평균급여 --null값 일, 경우 0표기
        FROM departments d
        JOIN locations loc
        ON d.location_id = loc.location_id
        LEFT JOIN ( --평균 급여를 先 구하기
            SELECT 
                department_id, --연결고리
                TRUNC(AVG(salary), 0) AS result
            FROM employees
            GROUP BY department_id
        ) tbl
        ON d.department_id = tbl.department_id
        ORDER BY d.department_id DESC
        ) tbl2
    )
WHERE rn > 10 AND rn <= 20;

--내가 작성
SELECT *
    FROM(
        SELECT ROWNUM AS RN, tbl.*
        FROM
            (

            SELECT
            d.*, loc.street_address, AVG(d.salary)
            
            FROM 
            departments d
            
            LEFT JOIN
            empolyees e 
            ON
            e.department_id = d.department_id
            
            LEFT JOIN
            locations loc
            ON
            loc.location_id = d.location_id
            
            WHERE salary = AVG(d.salary)

            ) tbl
        )
WHERE 0 > RN AND RN < 11;



    
    
    
    
    

    
    
    
    
    
    
