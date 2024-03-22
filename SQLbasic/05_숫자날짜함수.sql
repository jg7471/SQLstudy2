
--숫자함수
--ROUND(반올림)
--원하는 반올림 위치를 매개값으로 지정, 음수를 주는 것도 가능
SELECT
    ROUND(3.1415, 3), ROUND(45.923, 0), ROUND(45.923, 1) --반올림 자릿수
FROM dual;

--TRUNC(절사)
--정해진 소수점 자리수까지 잘라냄
SELECT
    TRUNC(3.1415, 3), TRUNC(45.923, 0), TRUNC(45.923, 1) --반올림 자릿수
FROM dual;

--ABS(절대값)
SELECT ABS(-34) FROM dual;

--CEIL(올림), FLOOR(버림)
SELECT CEIL(3.14), FLOOR(3.14)
FROM dual;

--MOD(나머지 나눗셈 연산)
SELECT
10 / 4, --10 % 4 --안됨 : MOD 사용
MOD(10, 4) --나머지 2
FROM DUAL;


------------------------------------------------------

--날짜함수
--stsdate : 컴퓨터의 현재 날짜, 시간 정보를 가져와서 제공하는 함수
SELECT sysdate FROM dual; --도구 환경설정 NLS : 시간 설정 가능 : RR/MM/DD HH24:MI:SSXFF
SELECT systimestamp FROM dual; --mm초까지 +GMT

--날짜도 연산이 가능합니다
SELECT sysdate + 1 FROM dual;  --일자 덧셈 연산이 가능.

--날짜타입과 날짜 타입은 뺄셈 연산을 지원(덧셈X)
SELECT
    first_name, sysdate - hire_date
FROM employees
ORDER BY hire_date ASC;

SELECT
    first_name,
    --(sysdate - hire_date) / 365 AS year --년수
    (sysdate - hire_date) / 7 AS week --주수
FROM employees;

-- 날짜 반올림, 절사
SELECT ROUND(sysdate) FROM dual; --12:00 기준:
SELECT ROUND(sysdate, 'year') FROM dual; --7/1 기준
SELECT ROUND(sysdate, 'month') FROM dual; --15일 기준
SELECT ROUND(sysdate, 'day') FROM dual; --주 기준 : 일요일 first

SELECT TRUNC(sysdate) FROM dual;
SELECT TRUNC(sysdate, 'year') FROM dual; --년 기준으로 절사
SELECT TRUNC(sysdate, 'month') FROM dual; --월 기준으로 절사
SELECT TRUNC(sysdate, 'day') FROM dual; --주 기준으로 절사 : 일요일 first


