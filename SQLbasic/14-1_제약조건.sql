-- ���̺� ������ ��������
-- : ���̺� �������� �����Ͱ� �ԷµǴ� ���� �����ϱ� ���� ��Ģ�� �����ϴ� ��.

-- ���̺� ������ �������� (PRIMARY KEY, UNIQUE, NOT NULL, FOREIGN KEY, CHECK)
-- PRIMARY KEY: ���̺��� ���� �ĺ� �÷��Դϴ�. (�ֿ� Ű):��� �� ���̺�� �ο� : null ��? /// PRIMARY KEY : UNIQUE + NOT NULL
-- UNIQUE: ������ ���� ���� �ϴ� �÷� (�ߺ��� ����) : null ��� : ��ȭ��ȣ UK
-- NOT NULL: null�� ������� ����. (�ʼ���)
-- FOREIGN KEY: �����ϴ� ���̺��� PRIMARY KEY�� �����ϴ� �÷� : �����ϱ� ���� Key ��κ� PK
-- CHECK: ���ǵ� ���ĸ� ����ǵ��� ���. : NOT NULL�� ���(Ŀ����)


-- �÷� ���� ���� ���� (�÷� ���𸶴� �������� ����)
CREATE TABLE dept2 (
    dept_no NUMBER(2) CONSTRAINT dept2_dept_pk PRIMARY KEY, --���̺�� (�÷���) Ű�Ӽ� : ���� --�������� �ĺ���(dept2_dept_pk)�� ���� ���� --�÷��� ������ ���߿� ȣ��� �ý��ۿ��� ����� �̸� ��������
    dept_name VARCHAR2(14) NOT NULL CONSTRAINT dept2_deptname_uk UNIQUE, --�ʼ���(NOT NULL+UNIQUE : PK �ڰ� ������, PK 2���� ȥ��)
    loca NUMBER(4) CONSTRAINT dept2_loca_locid_fk REFERENCES HR.locations(location_id), --�����ϱ� ���� ������ : NUMBER(4, 0) --���� REFERENCES �մϴ� HR. ������(���� ����? ��������)
    dept_bonus NUMBER(10) CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 10000),
    dept_gender VARCHAR2(1) CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'))
);

DROP TABLE dept2;

-- ���̺� ���� ���� ���� (��� �� ���� �� ���� ������ ���ϴ� ���)
CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) CONSTRAINT dept_name_notnull NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1), 
    
    CONSTRAINT dept2_dept_pk PRIMARY KEY(dept_no),
    CONSTRAINT dept2_deptname_uk UNIQUE(dept_name),
    CONSTRAINT dept2_loca_locid_fk FOREIGN KEY(loca) REFERENCES HR.locations(location_id),
    CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 10000),
    CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'))
);

INSERT INTO dept2
VALUES(10,'gg',3000,90000,'M'); --9000(���ʽ� 10000�̻�) ���ǿ� ���� �����ؾ���

ROLLBACK; --INSERT ��� CREATE ��� ��ʦ

--�ܷ�Ű(FK)�� �θ����̺�(�������̺�)�� ���ٸ� INSERT ��ʦ
INSERT INTO dept2
VALUES(10,'gg',6542,90000,'M'); --���� --loca�� 6542 ���� ����(�ܷ� ���̺� ���� ����)


--������ ���� �������� ����
UPDATE dept2
SET loca = 4000
WHERE dept_no = 10; --����(�ܷ�Ű(FK) �������� ����)

UPDATE dept2
SET dept_no = 20
WHERE dept_no = 10; --����(�ֿ�Ű(PK) �������� ����)

UPDATE dept2
SET dept_bonus = 900
WHERE dept_no = 10; --����(check �������� ����)



-- ���̺� ���� ���� �������� �߰� �� ����, ����
-- ���� ������ �߰�, ������ ����(���� ��ʦ)
-- �����Ϸ��� �����ϰ� ���ο� �������� �߰��ؾ� ��
CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1)
);

--PK �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_deptno_pk PRIMARY KEY(dept_no);

--FK �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_loca_locid_fk
FOREIGN KEY(loca) REFERENCES locations(location_id);

--CHECK �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 10000);

--unique �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_deptname_uk UNIQUE(dept_name);

--NOT NULL�� �� �������·� �����մϴ�
ALTER TABLE dept2 MODIFY dept_bonus NUMBER(10) NOT NULL; --�ý��� ٣


--���� ���� Ȯ��
SELECT * FROM user_constraints
WHERE table_name = 'DEPT2';

--���� ���� ����
ALTER TABLE dept2 DROP CONSTRAINT dept2_deptno_pk;