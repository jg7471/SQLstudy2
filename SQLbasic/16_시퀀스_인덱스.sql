
--������(���������� �����ϴ� ���� ����� �ִ� ��ü) 

CREATE SEQUENCE dept2_seq --()����
    START WITH 1 --���۰�(�⺻���� ������ �� �ּҰ�, ������ �� �ִ밪) : ���� ����
    INCREMENT BY 1 --������(����� ����, ������ ����, �⺻�� 1) : 10, -1 ����
    MAXVALUE 10 --�ִ밪(�⺻���� ������ �� 1027, ������ �� -1)
    MINVALUE 1 --�ּҰ� (�⺻���� ������ �� 1 ������ �� -1028)
    NOCACHE --ĳ�� �޸� ��� ���� (CACHE) : ������� �ʴ°�(�⺻�� CACHE) ����->NOCACHE
    NOCYCLE; --��ȯ ���� (NOCYCLE�� �⺻, ��ȯ��Ű���� CYCLE) : 12345/12345/12345
    --���󸮸Ӹ�Ű ����ϸ� �����Ŭ�� ����
    
  
  
    
CREATE TABLE dept2 (
    dept_no NUMBER(2) PRIMARY KEY,
    dept_name VARCHAR2(14),
    loca VARCHAR2(13),
    dept_date DATE
);

--������ ����ϱ�(NEXTVAL, CURRVAL)
SELECT dept2_seq.CURRVAL FROM dual; --���� �������� Ȯ��

INSERT INTO dept2
VALUES(dept2_seq.NEXTVAL, 'test', 'test', sysdate); ----INSERT ���� �� ������++ : MAXVALUE ������ �ʰ� �Ұ� : ���� -- ��ʦ

SELECT * FROM dept2;

DROP TABLE dept2;

--������ �Ӽ� ����(���� ���� ����)
--START WITH ���� �Ұ�
ALTER SEQUENCE dept2_seq MAXVALUE 9999; --�ִ밪 ����
ALTER SEQUENCE dept2_seq INCREMENT BY -1; --������ ���� : ���� �Ұ�
ALTER SEQUENCE dept2_seq MINVALUE 0;
--������ ���� ����

--������ ���� �ٽ� ó������ ������ ���
ALTER SEQUENCE dept2_seq INCREMENT BY -16; --���� ���� CURRVAL��
SELECT dept2_seq.NEXTVAL FROM dual; -- 0���� �ʱ�ȭ
ALTER SEQUENCE dept2_seq INCREMENT BY 1; --�ٽ� 1���� ����

-- -> DROP�ϰ� ����� �ϴ°� �� ����
DROP SEQUENCE dept2_seq;

--mySQL�� �ڵ����� ������ ��������

--------------------------------------------------------------------------------
--INDEX ������ �˻� ������ ���ִ� ���� : ���� ����� ����(��� ����)
--������ ������ ����

/*
- index
index�� primary key, unique ���� ���ǿ��� �ڵ����� �����ǰ�,
��ȸ�� ������ �� �ִ� hint ������ �մϴ�.
index�� ��ȸ�� ������ ������, �������ϰ� ���� �ε����� �����ؼ�
����ϸ� ������ ���� ���ϸ� ����ų �� �ֽ��ϴ�.
���� �ʿ��� ���� index�� ����ϴ� ���� �ٶ����մϴ�.
*/
SELECT * FROM employees
WHERE employee_id = 158;

--�ε��� ����
CREATE INDEX emp_salary_idx ON employees(salary); --F10���� �����ȹ Ȯ�� ����

/*
���̺� ��ȸ �� �ε����� ���� �÷��� �������� ����Ѵٸ�
���̺� ��ü ��ȸ�� �ƴ�, �÷��� ���� �ε����� �̿��ؼ� ��ȸ�� �����մϴ�.
�ε����� �����ϰ� �Ǹ� ������ �÷��� ROWID�� ���� �ε����� �غ�ǰ�, 
��ȸ�� ������ �� �ش� �ε����� ROWID�� ���� ���� ��ĵ�� �����ϰ� �մϴ�.
*/

DROP INDEX emp_salary_idx;

/*
- �ε����� ����Ǵ� ��� 
1. �÷��� WHERE �Ǵ� �������ǿ��� ���� ���Ǵ� ���
2. ���� �������� ���� �����ϴ� ���
3. ���̺��� ������ ���
4. Ÿ�� �÷��� ���� ���� null���� �����ϴ� ���.
5. ���̺��� ���� �����ǰ�, �̹� �ϳ� �̻��� �ε����� ������ �ִ� ��쿡��
 �������� �ʽ��ϴ�.
 ->PK ������
*/
