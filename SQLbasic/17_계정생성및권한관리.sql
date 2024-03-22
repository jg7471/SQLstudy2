
--사용자 계정 확인
SELECT * FROM all_users;


--계정 생성 명령
CREATE USER user1 IDENTIFIED BY user1;

--굳이 커맨드라인에서 실행 안해도 괜찮음

--DDL create alter truncate drop
--DML select isert update delete
--TCL commit rollback savepoint
--DCL grant revoke


/*
DCL: GRANT(권한 부여), REVOKE(권한 회수)

CREATE USER -> 데이터베이스 유저 생성 권한
CREATE SESSION -> 데이터베이스 접속 권한
CREATE TABLE -> 테이블 생성 권한
CREATE VIEW -> 뷰 생성 권한
CREATE SEQUENCE -> 시퀀스 생성 권한
ALTER ANY TABLE -> 어떠한 테이블도 수정할 수 있는 권한
INSERT ANY TABLE -> 어떠한 테이블에도 데이터를 삽입하는 권한.
SELECT ANY TABLE...

SELECT ON [테이블 이름] TO [유저 이름] -> 특정 테이블만 조회할 수 있는 권한.
INSERT ON....
UPDATE ON....

- 관리자에 준하는 권한을 부여하는 구문.
RESOURCE, CONNECT, DBA TO [유저 이름]
*/

GRANT CREATE SESSION TO user1;

GRANT SELECT ON hr.departments TO user1; --권한 부여
-- 계정 생성 -> SQL commandline -> connect -> ID/PW user1 -> SELECT * FROM HR.departments; ***HR 계정명

GRANT INSERT ON hr.departments TO user1; --INSERT 권한을 주겠다

INSERT INTO departments
VALUES(300, 'test', 100, 1800); -- SQL commandline에서 실행

GRANT CREATE TABLE TO user1;

GRANT RESOURCE, CONNECT, DBA TO user1; --모든 권한 주기

REVOKE RESOURCE, CONNECT, DBA FROM user1; --권한 뺏겠다

--테이블이 저장되는 장소인 테이블 스페이스를 설정하는 코드 : 거의 할 일 없음
--기본적으로 제공되는 users 테이블 스페이스의 사용량을 무.제한으로 지정
ALTER USER user1
DEFAULT TABLESPACE users
QUOTA UNLIMITED ON users;

-- 사용자 계정 삭제
-- DROP USER [유저이름] CASCADE;
-- CASCADE 없을 시 -> 테이블 or 시퀀스 등 객체가 존재한다면 계정 삭제 안됨.
DROP USER user1 CASCADE; --사용자 계정 삭제시 객체가 존재하면 삭제 X, -> 다 정리 후 삭제해야 함




