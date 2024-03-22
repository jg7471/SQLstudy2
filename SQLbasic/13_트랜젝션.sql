

--오토 커밋 활성화 여부 확인
SHOW AUTOCOMMIT;

--오토 커밋 ON --비추
SET AUTOCOMMIT ON;

--ATUO COMMIT OFF
SET AUTOCOMMIT OFF;

SELECT * FROM emps;

DELETE FROM emps WHERE employee_id = 100;

INSERT INTO emps
    (employee_id, last_name, email, hire_date, job_id)
VALUES
    (304, 'lee', 'lee1234@gmail.com', sysdate, 'test');

--보류중인 모든 데이터 변경사항 취소(폐기)
--직전 커밋 단계로 회귀(돌아가기) 및 트랜잭션 종료.
ROLLBACK; --마지막 commit 시점으로 돌아감(SAVEPOINT도 날아감)

SELECT * FROM emps
ORDER BY employee_id DESC;

--세이브 포인트 생성(게임 체크 포인트 같은)
--롤백한 포인트를 직접 이름을 붙여서 지정
--ANSI 표준 문법은 아니기 때문에 권장 X
SAVEPOINT insert_park; --세이브 포인트 성성

INSERT INTO emps
    (employee_id, last_name, email, hire_date, job_id)
VALUES
    (305, 'park', 'park1234@gmail.com', sysdate, 'test');
    
ROLLBACK TO SAVEPOINT insert_park; --세이브 포인트로 돌아가기

--보류중인 모든 데이터 변경사항을 영구적으로 적용하면서 트랜잭션 종료
--커밋 후에는 어떠한 방법을 사용하더라도 되돌릴 수 없음
COMMIT; --다시는 이전 커밋으로 돌아 갈 수없음(롤백도 無用)


--DML 자잘한 데이터 조작
--DDL 데이터 객체





--복습

SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees WHERE job_id = 'IT_PROG' );

SELECT *
FROM departments
WHERE employee_id = (SELECT employee_id FROM departments WHERE manager_id = 100);

SELECT *
FROM employees
WHERE manager_id IN (SELECT manager_id FROM employees WHERE first_name = 'James');


