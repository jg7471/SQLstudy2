

--���� Ŀ�� Ȱ��ȭ ���� Ȯ��
SHOW AUTOCOMMIT;

--���� Ŀ�� ON --����
SET AUTOCOMMIT ON;

--ATUO COMMIT OFF
SET AUTOCOMMIT OFF;

SELECT * FROM emps;

DELETE FROM emps WHERE employee_id = 100;

INSERT INTO emps
    (employee_id, last_name, email, hire_date, job_id)
VALUES
    (304, 'lee', 'lee1234@gmail.com', sysdate, 'test');

--�������� ��� ������ ������� ���(���)
--���� Ŀ�� �ܰ�� ȸ��(���ư���) �� Ʈ����� ����.
ROLLBACK; --������ commit �������� ���ư�(SAVEPOINT�� ���ư�)

SELECT * FROM emps
ORDER BY employee_id DESC;

--���̺� ����Ʈ ����(���� üũ ����Ʈ ����)
--�ѹ��� ����Ʈ�� ���� �̸��� �ٿ��� ����
--ANSI ǥ�� ������ �ƴϱ� ������ ���� X
SAVEPOINT insert_park; --���̺� ����Ʈ ����

INSERT INTO emps
    (employee_id, last_name, email, hire_date, job_id)
VALUES
    (305, 'park', 'park1234@gmail.com', sysdate, 'test');
    
ROLLBACK TO SAVEPOINT insert_park; --���̺� ����Ʈ�� ���ư���

--�������� ��� ������ ��������� ���������� �����ϸ鼭 Ʈ����� ����
--Ŀ�� �Ŀ��� ��� ����� ����ϴ��� �ǵ��� �� ����
COMMIT; --�ٽô� ���� Ŀ������ ���� �� ������(�ѹ鵵 ����)


--DML ������ ������ ����
--DDL ������ ��ü





--����

SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees WHERE job_id = 'IT_PROG' );

SELECT *
FROM departments
WHERE employee_id = (SELECT employee_id FROM departments WHERE manager_id = 100);

SELECT *
FROM employees
WHERE manager_id IN (SELECT manager_id FROM employees WHERE first_name = 'James');


