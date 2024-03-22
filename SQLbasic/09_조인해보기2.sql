
SELECT * FROM info;
SELECT * FROM auth;

--이너 (내부) 조인 : 조인 조건 맞는 애들만 출력됨
SELECT *
FROM info i --테이블 쓰기
INNER JOIN auth a
ON i.auth_id = a.auth_id; --조인 조건

-- ORACLE 문법(오라클 전용 문법이라 더 이상 작성하지 않겠습니다)
SELECT *
FROM info i, auth a
WHERE i.auth_id = a.auth_id;



-- auth_id 컬럼을 그냥 쓰면 모호하다 라고 뜹니다.
-- 그 이유는 양쪽에 모두 존재하는 컬럼이니까
--컬럼에 테이블 이름을 붙이던지, 별칭을 쓰셔서 확실하게 지목하세요
SELECT
    a.auth_id, i.title, i.content, a.name -- auth_id 중복이라 소속 명확히, 왠만해선 다른 것도 소속 밝혀
FROM info i
JOIN auth a --(INNER) JOIN 생략 가능 : default : inner join
ON i.auth_id = a.auth_id;


--필요한 데이터만 조회하겠다 (일반조건) 라고 한다면
--WHERE 구문을 통해 조건을 걺
--JOIN 은 ON
SELECT
    a.auth_id, i.title, i.content, a.name
FROM info i
JOIN auth a
ON i.auth_id = a.auth_id
WHERE a.name = '이순신';


--아우터(외부) 조인 ENSI --보통 LEFT (OUTER) JOIN 이라고 씀 (INNER) JOIN
SELECT *
FROM info i LEFT OUTER JOIN auth a --info i 기준(다 나옴) auth a 붙임(생략 가능성)
ON i.auth_id = a.auth_id;


--오라클 외부조인
SELECT *
FROM info i, auth a
WHERE i.auth_id = a.auth_id(+);


--RIGHT 외부 조인 (보통 left 사용) RIGHT (OUTER) JOIN
SELECT *
FROM info i RIGHT OUTER JOIN auth a --auth a 기준(다 나옴) info i 붙임(생략 가능성)
ON i.auth_id = a.auth_id;


--FULL 조인 : 좌우 테이블 모두 읽어표현 하는 외부 조인 FULL (OUTER) JOIN
SELECT *
FROM info i FULL OUTER JOIN auth a --info i 기준(다 나옴) auth a 붙임(생략 가능성)
ON i.auth_id = a.auth_id;

--CROSS JOIN은 JOIN 조건을 설정하지 않기 때문에
--단순히 모든 컬럼에 대한 JOIN을 진행합니다
--실제로는 거의 사용하지 않습니다 : 시험에 나옴 정처리, SQL D
--각 컬럼 좌 * 우 =

--ANSI 스타일
SELECT * FROM info
CROSS JOIN auth;

--오라클 스타일
SELECT * FROM info, auth;

--여러 개 테이블 조인 -> 키 값을 찾아 구문을 연결해서 쓰면 됩니다. @@@@
SELECT *
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN locations loc ON d.location_id = loc.location_id;



/*
- 테이블 별칭 a, i를 이용하여 LEFT OUTER JOIN 사용.
- info, auth 테이블 사용
- job 컬럼이 scientist인 사람의 id, title, content, job을 출력.
*/

--해답
SELECT *
FROM info i RIGHT OUTER JOIN auth a
ON i.auth_id = a.auth_id;



--내가 작성 :  LEFT로 작성시 결과 값 없음
SELECT *
FROM info i LEFT OUTER JOIN auth a
ON i.auth_id = a.auth_id
WHERE a.job = 'scientist';


--셀프 조인이란 동일 테이블 사이의 조인을 말합니다
--동일 테이블 컬럼을 통해 기존의 존재하는 값을 매칭시켜 가져올 때 사용합니다.
SELECT
    e1.employee_id, e1.first_name, e1.manager_id,
    e2.first_name, e2.employee_id

FROM employees e1
JOIN employees e2
ON e1.manager_id = e2.employee_id
ORDER BY e1.employee_id;
