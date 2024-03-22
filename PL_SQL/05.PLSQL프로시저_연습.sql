/*
���ν����� divisor_proc
���� �ϳ��� ���޹޾� �ش� ���� ����� ������ ����ϴ� ���ν����� �����մϴ�.
*/

--�ؼ�

CREATE OR REPLACE PROCEDURE divisor_proc --�ߺ��̸� replace
    (p_num IN NUMBER)
    
IS
    v_count NUMBER := 0;

BEGIN
    FOR i IN 1..p_num
    LOOP
        IF MOD(p_num, i) = 0 THEN
            v_count := v_count + 1;--�⺻������ ���� 1�� �������ϱ�
        END IF;
    END LOOP;
    
    dbms_output.put_line('����� ����' || v_count || '��');
    
END;

EXEC divisor_proc(72);


--���� �ۼ�
DROP PROCEDURE divisor_proc
CREATE PROCEDURE divisor_proc
    (number1 IN NUMBER)
    
IS
    
    v_total NUMBER := 0;
    v_count NUMBER := 1;

BEGIN

    FOR i IN 2..number1
    LOOP
        FOR j IN 2..number1
        LOOP
            CONTINUE WHEN MOD(number1, i) = 0;
            dbms_output.put_line(number1 || '�� ���???' || i);
            v_count := v_count +1;    
        END LOOP;

        IF MOD(v_count, 2) = 0
           v_count := v_count +1;    
        END LOOP;
END;

EXEC divisor_proc(37);


/*
�μ���ȣ, �μ���, �۾� flag(I: insert, U:update, D:delete)�� �Ű������� �޾� 
depts ���̺� 
���� INSERT, UPDATE, DELETE �ϴ� depts_proc �� �̸��� ���ν����� ������.
�׸��� ���������� commit, ���ܶ�� �ѹ� ó���ϵ��� ó���ϼ���.
*/

--�ؼ�


--PROCEDURE ���� 
CREATE OR REPLACE PROCEDURE depts_proc
    (
        p_dept_id IN depts.department_id%TYPE, --p_dept_id �Է°�
        p_dept_name IN depts.department_name%TYPE,
        p_flag IN VARCHAR2
    )
IS
    v_cnt NUMBER := 0;

BEGIN

    --count ����
    --1) ��ȸ: ��ȸ�� ���� ���� v_cnt�� ����, 
    SELECT COUNT(*)
    INTO v_cnt
    FROM depts
    WHERE department_id = p_dept_id;
    
          
    --I U D ����
    --I�� ���
    IF p_flag = 'I' THEN
        INSERT INTO depts(department_id, department_name) --id�� name �÷���@
        VALUES(p_dept_id, p_dept_name); --id, name�� ����

    --U v_cnt 0�� ���
    ELSIF p_flag = 'U' THEN
        IF v_cnt = 0 THEN
            dbms_output.put_line('�����ϰ��� �ϴ� �μ��� �������� �ʽ��ϴ�.');
            RETURN; --v_cnt 0�� ��� ����
        END IF;        
    
    --U v_cnt 1�� ���
        UPDATE depts 
        SET department_name = p_dept_name --�ٲٰڴ�
        WHERE department_id = p_dept_id; --������

    --D v_cnt 0�� ���
    ELSIF p_flag = 'D' THEN
        IF v_cnt = 0 THEN
            dbms_output.put_line('�����ϰ��� �ϴ� �μ��� ����X');
            RETURN;
        END IF;        

    --D v_cnt 1�� ���        
        DELETE FROM depts
        WHERE department_id = p_dept_id;
    
    --I U D ���ܰ�
    ELSE
        dbms_output.put_line('�ش� flag�� ���� ������ �غ���� �ʾ���');
    END IF;
    
    COMMIT;

    
    --����ó��
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('���� �߻�');
            dbms_output.put_line('ERROR msg :' || SQLERRM); --�����޽���
            ROLLBACK;
            
END;





--PROCEDURE ����
EXEC depts_proc(400, '���ߺ�', 'I'); --�纻 ���̺�
EXEC depts_proc(400, '������', 'U');
EXEC depts_proc(400, '������', 'D');
EXEC depts_proc(400, '������', 'X');

--depts_deptno_pk �̸� ����
ALTER TABLE depts ADD CONSTRAINT depts_deptno_pk PRIMARY KEY(department_id); --���̺� ���� : �������� ����@
--���̺� : �� - ���ʸ�� - �������� ���� ����
EXEC depts_proc(80, '������', 'I'); --���� : �����̸Ӹ�Ű �ߺ� : ����ó�� �����ϴ��� Ȯ���� �� : INSERT�� �ȵ�
--DEPARTMENT ID : PK �ߺ��ȵ�!, �ߺ�ó��X

SELECT * FROM depts;



--���� �ۼ�
CREATE TABLE dept (
    d_department_id IN departments.department_id%TYPE
    d_department_name IN departments.department_name%TYPE
    flag OUT ?
)


DECLARE depts_proc
    (
    d_department_id,
    d_department_name,
    flag(I, U, D)
    )
BEGIN
    IF flag = I
        INSERT INTO depts
        VALUES(d_department_id, d_departmnet_name, flag)
    
        ELSE IF flag = U
            UPDATE INTO depts
            VALUES(d_department_id, departmnet_name, flag)
    
        ELSE IF flag = D
            DELETE INTO depts
            VALUES(d_department_id, departmnet_name, flag)
    
        COMMIT;
    
    ELSE
    ROLLBACK;
    END IF;
    
END;




/*
employee_id�� ���޹޾� employees�� �����ϸ�,
�ټӳ���� out�ϴ� ���ν����� �ۼ��ϼ���. (�͸��Ͽ��� ���ν����� ����)
���ٸ� exceptionó���ϼ���
*/



CREATE OR REPLACE PROCEDURE emp_hire_proc
    (
        p_emp_id IN employees.employee_id%TYPE, --gpt2. p_emp_id�� �Է����� �޾Ƽ� �ش� ����� �Ի����� ã���ϴ�.
        p_year OUT NUMBER --�̾Ƴ�
    )
IS
    --v_hire_date DATE; --DATE Ÿ������ ���� ���� : ���1
    v_hire_date employees.hire_date%TYPE; -- ���2 --Ÿ�Կ� ����
    
BEGIN

    SELECT
        hire_date --2)WHERE�� ��ġ�ϴ� hire_date --576 ����
        
    INTO v_hire_date --3)�����ϰڴ� --576 ����� ���� --gpt3. hire_date�� v_hire_date ������ �Ҵ��մϴ�.
    
    FROM employees
    WHERE employee_id = p_emp_id; --1)�ܺη� ���� ���� ID(�Ű�����)

    --p_year := TRUNC((sysdate - v_hire_date)/365, 0) --�Ҵ�, 0���� �Ⱦ��� ����
    p_year := TRUNC((sysdate - v_hire_date) / 365); --4) �Ҵ�  --gpt4. ���� ��¥�� �Ի��� ���� ���̸� ����Ͽ� p_year�� �Ҵ��մϴ�.

    
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line(p_emp_id || '��(��) ���� ������ �Դϴ�.'); --576 ���� �߻�
        p_year := 0;
    
END;






DECLARE --�͸��� ����(OUT������ �����ϱ� ����) @
    v_year NUMBER; --OUT ������ ������ ����
    
BEGIN
    emp_hire_proc(100, v_year); --emp_hire_proc ����� --576(���� ���) --100(�ִ� ���)
    IF v_year > 0 THEN
        dbms_output.put_line('�ټӳ��: ' || v_year || '��');
    END IF;
    
END;













--���� �ۼ�
CREATE OR REPLACE PROCEDURE my_new_job_proc
    (    
    e_employee_id IN employees.employee_id%TYPE
    )
IS
    v_cnt NUMBER := 0; 

BEGIN

    SELECT 
        COUNT(*)
        TRUNC((sysdate - hire_date) / 365)- 
        
    INTO
        v_cnt --delete �� ���� ���������� Ȯ���Ϸ���
    
    FROM employees
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN
        INSERT INTO employees
        VALUES(employee_id);
    
    ELSE --��ȸ ����� �ִٸ� UPDATE
        UPDATE jobs
        SET employee_id = e_employee_id
        WHERE employee_id = e_employee_id;
        
        
    END IF;
    COMMIT;
END;


