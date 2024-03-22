/*
- NUMBER(2) -> ������ 2�ڸ����� ������ �� �ִ� ������ Ÿ��.
- NUMBER(5, 2) -> ������, �Ǽ��θ� ��ģ �� �ڸ��� 5�ڸ�, �Ҽ��� 2�ڸ� --356.74
- NUMBER -> ��ȣ�� ������ �� (38, 0)���� �ڵ� �����˴ϴ�.
- VARCHAR2(byte) -> ��ȣ �ȿ� ���� ���ڿ��� �ִ� ���̸� ����. (4000byte����)
- CLOB -> ��뷮 �ؽ�Ʈ ������ Ÿ�� (�ִ� 4Gbyte)
- BLOB -> ������ ��뷮 ��ü (�̹���, ���� ���� �� ���)
- DATE -> BC 4712�� 1�� 1�� ~ AD 9999�� 12�� 31�ϱ��� ���� ����
- ��, ��, �� ���� ����.
*/

CREATE TABLE dept2 (
    dept_no NUMBER(2), --������ ũ�� ����(�̸�)
    dept_name VARCHAR2(14), --14byte
    loca VARCHAR2(15),
    dept_date DATE,
    dept_bonus NUMBER(10)
);

DESC dept2;
SELECT * FROM dept2;

INSERT INTO dept2
VALUES(10, '������', '����', sysdate, 1000000);

INSERT INTO dept2
VALUES(20, '���ߺ�', '����', sysdate, 2000000);

--NUMBER�� VARCHAR2 Ÿ���� ���̸� Ȯ��
INSERT INTO dept2
VALUES(20, '���ߺο��̤��շ�����̤�����������������������', '��������������������', sysdate, 200000000000000); --������ ���ڼ� �ʰ�


-- �÷� �߰�(�׸�)
ALTER TABLE dept2
ADD dept_count NUMBER(3); --�⺻�� null

--�÷��� ����
ALTER TABLE dept2
RENAME COLUMN dept_count TO emp_count;
SELECT * FROM dept2;

--�÷� �Ӽ� ����
--���� �����ϰ��� �ϴ� �÷��� �����Ͱ� �̹� �����Ѵٸ�, �׿� �´� Ÿ������ ������ �ּž� �մϴ�, ���� �ʴ� Ÿ�����δ� ���� �Ұ�(���� null�� ��� ?��).
ALTER TABLE dept2
MODIFY dept_name VARCHAR2(50); --VARCHAR2(15)->VARCHAR2(50) ���̺���
DESC dept2; --���� Ȯ��



ALTER TABLE dept2
MODIFY dept_name NUMBER(50); --�̹� VARCHAR Ÿ�� �־ NUMBER Ÿ������ ���� �Ұ�

ALTER TABLE dept2
MODIFY emp_count VARCHAR2(20); --���̺� ������ null�̶� �Ӽ� ���� ���� ***Ŀ�԰� �ѹ鿡 ���� XXX
--DDL �ڵ� Ŀ�Ե� : �ѹ�(����) �ȵ� : INSERT UPDATE DELETE�� ROLLBACK ����

--DDL(CREATE, ALTER, TRUNCATE, DROP)�� Ʈ�����(ROLLBACK)�� ����� �ƴմϴ�.
ROLLBACK;

--�÷� ����
ALTER TABLE dept2
DROP COLUMN dept_count; --!���� : ���ο� ������ �־ ������

--���̺� �̸� ����
ALTER TABLE dept2
RENAME TO dept3;

--���̺� ����(������ ���ܵΰ� ���� �����͸� ��� ����)--�Ժη� XXX : �纻��� or merge���
TRUNCATE TABLE dept3;

--���̺� ����
DROP TABLE dept2; --�ƿ� ����(ROLLBACK; ��ʦ)--�Ժη� XXX

--DDL(CREATE, ALTER, TRUNCATE, DROP) != Ʈ����� : ���� �ȵ�
--DML(SELECT, INSERT, UPDATE, DELETE)
--TCL(COMMIT, ROLLBACK, SAVEPOINT)