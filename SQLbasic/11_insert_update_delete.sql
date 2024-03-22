

--INSERT
--���̺� ���� Ȯ��
DESC departments; --NOT NULL �ʼ���

--INSERT ù��° ���(��� �÷� �����͸� �� ���� �����ؼ� ����)
INSERT INTO departments
VALUES(300, '���ߺ�', 100, 1500); --VALUES ? �� ����

VALUES(300, '���ߺ�')--���� --�÷��� �������� �ʰ� ���� �ִ� ���� ��� ���� �� ����Ѵ�(NULL ��� ���� �������)

SELECT * FROM departments; --������ ��ȸ
ROLLBACK;--������ ���� ���(���� ������ �ٽ� �ڷ� ������ Ű����)

/*
�̸�              ��?       ����           
--------------- -------- ------------ 
DEPARTMENT_ID   NOT NULL NUMBER(4)   --�ʼ�(������Ÿ�� number) 
DEPARTMENT_NAME NOT NULL VARCHAR2(30)--�ʼ�
MANAGER_ID               NUMBER(6)   --�ɼ�
LOCATION_ID              NUMBER(4)   --�ɼ�
*/

--INSERT�� �ι�° ��� (���� �÷��� �����ϰ� ����, NOT NULL �÷��� Ȯ���ϼ���)
INSERT INTO departments
    (department_id, department_name)
VALUES
    (300, '���ߺ�');
--VALUES�� �� ���Խ� ���� �Է�(NOT NULL ����), INSERT INTO�� ������ ���� ���� ����

ROLLBACK;

INSERT INTO departments
    (department_id, location_id) --���� -> department_name�� NOT NULL
VALUES
    (301, 1500);--DEPARTMENT_NAME �ʼ��� �̻���
    
    
--�纻 ���̺� ����
--�纻 ���̺��� ������ �� �׳� �����ϸ� -> ��ȸ�� �����ͱ��� ��� ����
--WHERE ���� false(1=2) �����ϸ� -> ���̺��� ������ ����ǰ� �����ʹ� ���� X
--CTAS(����)���� �÷��� ������ �����͸� ������ ��, ��������(PrimaryKey, ForginKey...)�� �������� ����

CREATE TABLE emps AS
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE 1 = 2); -- 2 flase : ������ ������ ����x : ������ ����

SELECT * FROM emps;
DROP TABLE emps; -- ���̺� ����

-- INSERT (��������)
INSERT INTO emps
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE department_id = 50);

SELECT * FROM emps
WHERE employee_id = 120;

--INSERT ��� (�÷�����X �ѹ���, ���ϴ� �÷���, ��������)
--------------------------------------------------------------------------------
--UPDATE
--UPDATE ���̺��̸� SET �÷�=��, �÷�=��... WHERE ������ ��������(����)
CREATE TABLE emps AS
(SELECT * FROM employees); --���̺� ���� ����

SELECT * FROM emps;

--UPDATE�� ������ ���� ������ ������ �� �������� �� �����ؾ� �մϴ�
--�׷��� ������ ���� ����� ��ü ���̺�� ������(�ϰ�����)
UPDATE emps SET salary = 30000;
ROLLBACK;

UPDATE emps SET salary = 30000
WHERE employee_id = 100;
SELECT * FROM emps;

ROLLBACK;

UPDATE emps SET salary = salary + salary*0.1 --����
WHERE employee_id = 100;

UPDATE emps
SET phone_number = '010.5421.1286', manager_Id = 102 --100���� phone_number, manager_Id ������
WHERE employee_id = 100;

--UPDATE(��������)
UPDATE emps --100���� job_id, salary, manager_id�� 101�� ����
SET (job_id, salary, manager_id) =
    (
        SELECT job_id, salary, manager_id
        FROM emps
        WHERE employee_id = 100
    )
WHERE employee_id = 101;


--DELETE
--DELETE�� WHERE�� �������� ������ ���̺� ��ü���� ����� �˴ϴ�

--DELETE * FROM emps 
--WHERE employee_id = 103; --�Ұ� : ������� �� ��(����), �÷� �ϳ��� ����� ������ UPDATE

--DELETE ������ ����� ���� ����!!

DELETE FROM emps; --���� ���ҽ� ��ü ����

DELETE FROM emps
WHERE employee_id = 103;

SELECT * FROM emps;


--DELETE(��������)
DELETE FROM emps
WHERE department_id = (SELECT department_id FROM departments
                        WHERE department_name = 'IT');
                        
                        
