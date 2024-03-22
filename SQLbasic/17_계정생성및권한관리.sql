
--����� ���� Ȯ��
SELECT * FROM all_users;


--���� ���� ���
CREATE USER user1 IDENTIFIED BY user1;

--���� Ŀ�ǵ���ο��� ���� ���ص� ������

--DDL create alter truncate drop
--DML select isert update delete
--TCL commit rollback savepoint
--DCL grant revoke


/*
DCL: GRANT(���� �ο�), REVOKE(���� ȸ��)

CREATE USER -> �����ͺ��̽� ���� ���� ����
CREATE SESSION -> �����ͺ��̽� ���� ����
CREATE TABLE -> ���̺� ���� ����
CREATE VIEW -> �� ���� ����
CREATE SEQUENCE -> ������ ���� ����
ALTER ANY TABLE -> ��� ���̺� ������ �� �ִ� ����
INSERT ANY TABLE -> ��� ���̺��� �����͸� �����ϴ� ����.
SELECT ANY TABLE...

SELECT ON [���̺� �̸�] TO [���� �̸�] -> Ư�� ���̺� ��ȸ�� �� �ִ� ����.
INSERT ON....
UPDATE ON....

- �����ڿ� ���ϴ� ������ �ο��ϴ� ����.
RESOURCE, CONNECT, DBA TO [���� �̸�]
*/

GRANT CREATE SESSION TO user1;

GRANT SELECT ON hr.departments TO user1; --���� �ο�
-- ���� ���� -> SQL commandline -> connect -> ID/PW user1 -> SELECT * FROM HR.departments; ***HR ������

GRANT INSERT ON hr.departments TO user1; --INSERT ������ �ְڴ�

INSERT INTO departments
VALUES(300, 'test', 100, 1800); -- SQL commandline���� ����

GRANT CREATE TABLE TO user1;

GRANT RESOURCE, CONNECT, DBA TO user1; --��� ���� �ֱ�

REVOKE RESOURCE, CONNECT, DBA FROM user1; --���� ���ڴ�

--���̺��� ����Ǵ� ����� ���̺� �����̽��� �����ϴ� �ڵ� : ���� �� �� ����
--�⺻������ �����Ǵ� users ���̺� �����̽��� ��뷮�� ��.�������� ����
ALTER USER user1
DEFAULT TABLESPACE users
QUOTA UNLIMITED ON users;

-- ����� ���� ����
-- DROP USER [�����̸�] CASCADE;
-- CASCADE ���� �� -> ���̺� or ������ �� ��ü�� �����Ѵٸ� ���� ���� �ȵ�.
DROP USER user1 CASCADE; --����� ���� ������ ��ü�� �����ϸ� ���� X, -> �� ���� �� �����ؾ� ��




