
/*
문제 1.
EMPLOYEES 테이블에서 이름, 입사일자 컬럼으로 변경(별칭)해서 이름순으로 오름차순 출력 합니다.
조건 1) 이름 컬럼은 first_name, last_name을 붙여서 출력합니다. (CONCAT)
조건 2) 입사일자 컬럼은 xx/xx/xx로 저장되어 있습니다. xxxxxx형태로 변경해서 출력합니다. (REPLACE)
*/

SELECT
    CONCAT(first_name, last_name) AS 이름,
    REPLACE(hire_date, '/', '') AS 입사일자
FROM employees
ORDER BY 이름 ASC;

--내가 작성
--SELECT
--    REPLACE (hire_date, '/', ''(CONCAT ((first_name || ' ' || last_name,  hire_date) )))
--FROM employees
--ORDER BY first_name ASC;



/*
문제 2.
EMPLOYEES 테이블에서 phone_number컬럼은 ###.###.####형태로 저장되어 있다
여기서 처음 세 자리 숫자 대신 서울 지역변호 (02)를 붙여 
전화 번호를 출력하도록 쿼리를 작성하세요. (CONCAT, SUBSTR 사용)
*/

SELECT
    CONCAT('(02)', SUBSTR(phone_number, 5)) --안 부터
FROM employees;

--함수 사용시 결과값만 나옴 : 데이터 변하지 않음

--내가 작성
--SELECT
--    SUBSTR('___', 1, 3(CONCAT('(02)', phone_number)))
--FROM employees
--ORDER BY phone_number ASC;



/*
문제 3. 
EMPLOYEES 테이블에서 JOB_ID가 it_prog인 사원의 이름(first_name)과 급여(salary)를 출력하세요.
조건 1) 비교하기 위한 값은 소문자로 비교해야 합니다.(힌트 : lower 이용)
조건 2) 이름은 앞 3문자까지 출력하고 나머지는 *로 출력합니다. 
이 열의 열 별칭은 name입니다.(힌트 : rpad와 substr 또는 substr 그리고 length 이용)
조건 3) 급여는 전체 10자리로 출력하되 나머지 자리는 *로 출력합니다. 
이 열의 열 별칭은 salary입니다.(힌트 : lpad 이용)
*/
SELECT
    RPAD(SUBSTR(first_name, 1, 3), LENGTH(first_name), '*') AS name,
    LPAD(salary, 10, '*') AS salary
FROM employees
WHERE LOWER (job_id) = 'it_prog';

--SELECT
--    LPAD(first_name, 3, '*' AS name),
--    LPAD(salary, 1, '*' AS salary)
--FROM employees
--WHERE job_id, it_prog
