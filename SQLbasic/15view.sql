/*
view�� �������� �ڷḸ ���� ���� ����ϴ� ���� ���̺��� �����Դϴ�.
��� �⺻ ���̺�� ������ ���� ���̺��̱� ������
�ʿ��� �÷��� ������ �θ� ������ ������ ���ϴ�.
��� �������̺�� ���� �����Ͱ� ���������� ����� ���´� �ƴմϴ�.
�並 ���ؼ� �����Ϳ� �����ϸ� ���� �����ʹ� �����ϰ� ��ȣ�� �� �ֽ��ϴ�.

ex �İ��������� ���̺� ����?, ���ȼ���
VIEW(�ܼ�, ����) : INSERT ��ʦ, �뷮 ��
*/

SELECT * FROM user_sys_privs; --����Ŭ ����

--�ܼ� �� : �ϳ��� ���̺��� �̿��Ͽ� ������ ��
--���� �÷����� �Լ� ȣ�⹮, ����� �� ���� ���� ǥ����(first_name || ' ' || last_name)�̸� �ȵ�
SELECT
    employee_id,
    first_name || ' ' || last_name,
    job_id,
    salary
FROM employees
WHERE department_id = 60;

CREATE VIEW view_emp AS ( --�ܼ� VIEW ���� : �ϳ��� TABLE�� ������� ���� 
    SELECT
        employee_id,
        first_name || ' ' || last_name AS full_name, --���� ǥ����
        job_id,
        salary
    FROM employees
    WHERE department_id = 60
);


SELECT * FROM view_emp
WHERE salary >= 6000;

--���� VIEW : JOIN�� �ȵ�� ���� ª������
--���� ���̺��� �����Ͽ� �ʿ��� �����͸� �����ϰ� ���� Ȯ���� ���� ���
CREATE VIEW view_emp_dept_job AS (
    SELECT
        e.employee_id,
        e.first_name || ' ' || last_name AS full_name,
        d.department_name,
        j.job_title
    
    FROM employees e
    
    LEFT JOIN departments d
    ON e.department_id = d.department_id --JOIN ����
    
    LEFT JOIN jobs j
    ON e.job_id = j.job_id
)
ORDER BY employee_id;

SELECT * FROM view_emp_dept_job;



--VIEW ���� (CREATE OR REPLACE VIEW ����)
--���� �̸����� �ش� ������ ����ϸ� �����Ͱ� ����Ǹ鼭 ���Ӱ� ������
CREATE OR REPLACE VIEW view_emp_dept_job AS (
    SELECT
        e.employee_id,
        e.first_name || ' ' || last_name AS full_name,
        d.department_name,
        j.job_title,
        e.salary --�÷��߰�
    
    FROM employees e
    
    LEFT JOIN departments d
    ON e.department_id = d.department_id --JOIN ����
    
    LEFT JOIN jobs j
    ON e.job_id = j.job_id
)
ORDER BY employee_id;

SELECT * FROM view_emp_dept_job;


SELECT
    job_title,
    AVG(salary) AS avg
    
FROM view_emp_dept_job
GROUP BY job_title
ORDER BY avg DESC; --SQL ������ ��������

--VIEW ����
DROP VIEW view_emp;


/*
VIEW�� INSERT�� �Ͼ�� ��� ���� ���̺��� �ݿ��� �˴ϴ�.
�׷��� VIEW�� INSERT, UPDATE, DELETE�� ���� ���� ������ �����ϴ�.
���� ���̺��� NOT NULL�� ��� VIEW�� INSERT�� �Ұ����մϴ�.
VIEW���� ����ϴ� �÷��� ������ ��쿡�� �ȵ˴ϴ�.
*/

--�� ��° �÷��� 'full_name'�� ����(virtual column)�̱� ������ INSERT �ȵ�
INSERT INTO view_emp_dept_job --VIEW INSERT �ϸ� ���� TABLE���� ������ ��
VALUES(300, 'test', 'test', 'test', 10000); --����


--JOIN�� VIEW(���� view)�� ��쿡�� �ѹ��� ���� ��ʦ
INSERT INTO view_emp_dept_job
    (employee_id, department_name, job_title, salary) --department_name PK
VALUES(300, 'test', 'test', 10000);
--���� VIEW INSERT ��ʦ, READ ONLY


--���� ���̺� �÷� �� NOT NULL �÷��� �����ϰ�, �ش� �÷��� view�� ������ �� ���ٸ�, INSERT ��ʦ
INSERT INTO view_emp --�ܼ�view
    (employee_id, job_id, salary)
VALUES(300, 'test', 10000);

--DELETE
DELETE FROM view_emp
WHERE employee_id = 107; --VIEW���� 107 ������ ->���� ���̺� ������ : �׷����� ��������

SELECT * FROM view_emp; --VIEW
SELECT * FROM employees; --����

ROLLBACK;

--WITH CHECK OPTION ->���� ���� �÷�
--VIEW�� ������ �� ����� ���� �÷��� VIEW�� ���ؼ� ������ �� ���� ���ִ� Ű����

CREATE OR REPLACE VIEW view_emp_test AS (
    SELECT
    employee_id,
    first_name,
    last_name,
    email,
    hire_date,
    job_id,
    department_id
    
    FROM employees
    WHERE department_id = 60
)
WITH CHECK OPTION CONSTRAINT view_emp_test_ck; --CONSTRAINT view_emp_test_ck �̸� ����(�ɼ�) : ���Ἲ ����

SELECT * FROM view_emp_test;

UPDATE view_emp_test
SET department_id = 100 --WHERE department_id = 60 ���ǿ� ����
WHERE employee_id = 107;

--�б� ���� VIEW READ ONLY(DML ���� ���� : SELECT�� ���)

CREATE OR REPLACE VIEW view_emp_test AS (
    SELECT
    employee_id,
    first_name,
    last_name,
    email,
    hire_date,
    job_id,
    department_id
    
    FROM employees
    WHERE department_id = 60
)
WITH READ ONLY;