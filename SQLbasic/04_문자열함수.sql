
SELECT * FROM dual; --TEST용 테이블(연산결과 테스트)

/*
dual이라는 테이블은 sys가 소유하는 오라클의 표준 테이블로서,
오직 한 행에 한 컬럼만 담고 있는 dummy 테이블 입니다.
일시적인 산술 연산이나 날짜 연산 등에 주로 사용합니다.
모든 사용자가 접근할 수 있습니다.
*/

-- lower(소문자), initcap(앞글자만 대문자), upper(대문자)
SELECT
'abcDEF', lower('abcDEF'), initcap('abcDEF'), upper('abcDEF')
FROM dual;

SELECT
last_name
    last_name,
    LOWER(last_name),
    INITCAP(last_name),
    UPPER(last_name)
FROM employees;

SELECT
    salary
FROM employees
WHERE LOWER(last_name) = 'austin'; --이름 대소문자 구분 --LOWER 소문자로 검색 : 자바 or SQL에서 처리해야


--length(길이), instr(문자 찾기, 없으면 0 반환, 있으면 인덱스 값)
SELECT
    'abcdef', LENGTH('avcdef'), INSTR('abcdef', 'b') --idx 1부터 시작(보통은 0부터 시작, 이쪽 동네가 특이한거)
FROM dual;

SELECT
    first_name, 
    LENGTH(first_name),
    INSTR(first_name, 'a')
FROM employees;

--substr(자를 문자열, 시작인덱스 ,길이)
--substr(자를 문자열, 시작인덱스) ->문자열 끝까지
--인덱스 1부터 시작
--concat(문자 연결) *매개값 두개 밖에 -> 3개 이상 : OR -> CONCAT 잘 안씀
--mysql CONCAT 제한 없음 : OR 없음

SELECT
    'abcdef' AS ex,
    SUBSTR('abcdef',2 ,4), --2부터 4이하 자름(자바 미만)
    SUBSTR('abcdef',2), --끝까지
    CONCAT('abc', '123') --붙임 -- concat은 매개값 2개 밖에 안받음
FROM dual;

SELECT
    first_name,
    SUBSTR(first_name, 1, 3),
    CONCAT(first_name, last_name)
FROM employees;

--LPAD, RPAD (좌/우측 지정한 문자열로 채우기)
SELECT
    LPAD('abc', 10, '*'), --원본문자 + 채울문자 = 10 (기존값 가릴 때 : 전화번호)
    RPAD('abc', 10, '*')
FROM dual;

--LTRIM(), RTRIM()
--LTRIM(param1, param2) -> param2의 값을 param1에서 찾아서 제거(왼쪽부터)
SELECT
    LTRIM('javascript_java', 'java') --javascript_java에서 java라는 글자를 지움
FROM dual;

--RTRIM(param1, param2) -> param2의 값을 param1에서 찾아서 제거(오른쪽부터)
SELECT
    RTRIM('javascript_java', 'java')
FROM dual;

--TRIM() : 양쪽 공백제거
SELECT TRIM('            java           ') FROM dual;

--REPLACE(str, old, new) --글자 대체
SELECT
    REPLACE('My dream is a president', 'president', 'programmer')
FROM dual;

SELECT
    REPLACE(REPLACE('My dream is a president', 'president', 'programmer'), ' ', '★')
FROM dual; --공백 문자 지워라

--자바 : 함수의 호출문을 다른 함수의 매개값으로
--함수의 리턴값을 다른함수의 매개값으로 사용가능

SELECT
    REPLACE(CONCAT('hello', '(world!'), '!', '?')
FROM dual;




