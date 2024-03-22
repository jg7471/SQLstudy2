/*
# PL/SQL : mySQL���� ����Ѱ� ���� -> JAVA������ ���� ����
- ����Ŭ���� �����ϴ� SQL ���α׷��� ����̴�.
- �Ϲ����� ���α׷��ְ��� ���̰� ������, ����Ŭ ���ο��� ������ ó���� ����
 ������ �� �� �ִ� ���������� �ڵ� �ۼ� ����Դϴ�.
- �������� �������� ��� ������ �ϰ� ó���ϱ� ���� �뵵�� ����մϴ�.
*/


--���� ��� : ctrl f10, �巡�� + f9(PLSQL ������)


SET SERVEROUTPUT ON; --��¹� Ȱ��ȭ --�巡�� �� �켱 ����


--�͸� ��� ����
DECLARE --������ �����ϴ� ����(�����)

    emp_num NUMBER; --���� ����

BEGIN --�ڵ带 �����ϴ� ����(�����)
    
    emp_num := 10; --���� ������ (���� JAVA�� =)
    DBMS_OUTPUT.put_line(emp_num);
    DBMS_OUTPUT.put_line('Hello pl/sql!');

END; --PL/SQL�� ������ ����(�����) --�巡�� �� F9 : �͸� ���




/*
- DML��
DDL(select isert update delete)���� ����� �Ұ����ϰ�, �Ϲ������� SQL���� SELECT ���� ����ϴµ�, 
Ư���� ���� SELECT�� �Ʒ��� INTO���� ����ؼ� ������ �Ҵ��� �� �ֽ��ϴ�.
*/

DECLARE
    v_emp_name VARCHAR2(50); --����� ����(���ڿ� Ÿ���� �������� �ʿ�)
    --v_dep_name VARCHAR2(50); --�μ��� ����
    v_dep_name departments.department_name%TYPE; --���� ���ϴ� �÷��� Ÿ�Կ� ���߱�(���� VARCHAR2(30 BYTE))

BEGIN

    SELECT
        e.first_name,
        d.department_name
    
    INTO --PL/SQL ����
        v_emp_name, v_dep_name --��ȸ ����� ������ ����
        
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id --department_name ǥ���Ϸ��� ����
    WHERE e.employee_id = 103;

    dbms_output.put_line(v_emp_name || '-' || v_dep_name);    

END; --�巡�� �� �� F9

SELECT * FROM employees;


-- 2. employees ���̺��� �����ȣ�� ���� ū ����� ã�Ƴ� �� (MAX �Լ� ���)
-- �� ��ȣ + 1������ �Ʒ��� ����� emps ���̺�
-- employee_id, last_name, email, hire_date, job_id�� �ű� �����ϴ� �͸� ����� ���弼��.
-- SELECT�� ���Ŀ� INSERT�� ����� �����մϴ�.
/*
<�����>: steven
<�̸���>: stevenjobs
<�Ի�����>: ���ó�¥
<JOB_ID>: CEO
*/



--���� �ۼ�
--DECLARE
--    v_dep_employee_id employees.employee_id%TYPE;
--    v_dep_last_name employees.last_name%TYPE;
--    v_dep_email employees.email%TYPE;
--    v_dep_hire_date employees.hire_date%TYPE;
--    v_dep_job_id employees.job_id%TYPE;
--    
--BEGIN
--
--    SELECT
--    e.employee_id, e.last_name, e.email, e.hire_date, e.job_id
--    
--    INTO
--
--    INSERT INTO employees
--    VALUES(999,'LEE','happysql','05/10/13',ST_MAN);
--    
--    FROM employees e
--    LEFT JOIN departments d
--    ON e.department_id = d.department_id
--    WHERE employee_id > MAX(employee_id)
--
--END;

--�ؼ�
DECLARE
    v_max_empno employees.employee_id%TYPE;
BEGIN
    SELECT
        MAX(employee_id)
    INTO
        v_max_empno
    FROM employees;
    
    INSERT INTO emps
        (employee_id, last_name, email, hire_date, job_id)
    VALUES
        (v_max_empno + 1, 'steven', 'stevenjobs', sysdate, 'CEO');
    
END;

SELECT * FROM emps;