SET SERVEROUTPUT ON;


--�͸� ��� ����
DECLARE --������ �����ϴ� ����(�����)
    emp_num NUMBER; --���� ����
BEGIN --�ڵ带 �����ϴ� ����(�����)
    emp_num := 10; --���� ������
    DBMS_OUTPUT.put_line('Hello pl/sql!');
END;




DECLARE
    v_emp_name VARCHAR2(50);
    v_dep_name departments.department_name%TYPE;

BEGIN

    SELECT
        e.first_name,
        d.department_name
    
    INTO
        v_emp_name, v_dep_name --��ȸ ����� ������ ����
        
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    WHERE e.employee_id = 103;

    dbms_output.put_line(v_emp_name || '-' || v_dep_name);    

END; 




<<<<<<< HEAD
BEGIN
    dbms_output.put_line('Ʈ���� ����!');
    v_total := :NEW.total; -- �ֹ� ���� ���� 5�� //--beforeƮ���ſ��� ��� 0) 20�� �ֹ� ����
    v_product_no := :NEW.product_no; --�ֹ� ��ǰ�� ��ȣ�� ���� 1�� //1.5) Ȯ��

    --���� �����Ϳ��� ��ȸ�ϱ�
    SELECT 
        total --������ �ľ�
    INTO v_product_total --2)���� ���12��
    FROM product
    WHERE product_no = v_product_no; --1)��ǰ ��ȣ�� ������ ��� ������ȸ
    
    IF v_product_total <= 0 THEN
        RAISE zero_total_exception;
    
    
    ELSIF v_total > v_product_total THEN
        RAISE quantity_shortage_exception;
    END IF;
        
    UPDATE product SET total = total - v_total
    WHERE product_no = v_product_no;
    
        EXCEPTION
        WHEN quantity_shortage_exception THEN

        RAISE_APPLICATION_ERROR(-20001, '�ֹ��Ͻ� �������� ��� ��� �ֹ� �� �� �����ϴ�'); --���� ���� �߻���(20001 Ŀ������)
        
        WHEN zero_total_exception THEN
        RAISE_APPLICATION_ERROR(-20001, '�ֹ��Ͻ� ��� ��� �ֹ� �� �� �����ϴ�'); --���� ���� �߻���

END;




=======


DECLARE/IS --<procedure>
    v_max_empno employees.employee_id%TYPE;
    
BEGIN
    SELECT
        MAX(employee_id)
    INTO
        v_max_empno
    FROM employees;
    WHERE
    
    INSERT INTO emps
        (employee_id, last_name, email, hire_date, job_id)
    VALUES
        (v_max_empno + 1, 'steven', 'jobs', sysdate, 'CEO');
    IF - ELSIF - END
END



IF THEN
ELSIF
THEN
ELSE
ELSIF
END IF

CASE
WHEN THEN
ELSE
END CASE


DECLARE
    v_count NUMBER := 1;
WHILE '����'/FOR i IN 1..9
LOOP
v_count := v_count +1; -- ++��
CONTINUE WHEN MOD(i, 2) = 0;

END LOOP



INSERT INTO board
        VALUES(b_seq.NEXTVAL, 'test'||v_num, 'title'||v_num); --������ ����


CREATE PROCEDURE �Լ��� (�Ű����� IN OUT IN AND OUT)
CREATE OR REPLACE PROCEDURE �Լ��� (�Ű�����)
EXEC () ����
dbms_output.put_line


ALTER TABLE depts ADD CONSTRAINT depts_deptno_pk PRIMARY KEY(department_id); --���̺� ���� : �������� ����@ �Ӽ�����
>>>>>>> 6e8d7447f5a661392580a0948efdd4b5526b15bb
