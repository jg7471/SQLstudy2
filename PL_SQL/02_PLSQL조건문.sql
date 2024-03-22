
--IF�� �����غ���
DECLARE
    v_salary NUMBER := 0;
    v_department_id NUMBER := 0;
BEGIN
    
    --ROUND �ݿø�
    v_department_id := ROUND(DBMS_RANDOM.VALUE(10, 110), -1);   --10~120 --�ڸ��� -1���� �ݿø� : 32 ->30, 67 -> 70 : 10���� ����
    dbms_output.put_line('������ ����: ' || v_department_id);
    
    SELECT
        salary
    INTO
        v_salary
    FROM employees
    WHERE department_id = v_department_id
    AND ROWNUM = 1; -- ù° ���� ���ؼ� ������ ����.
    --IF/END IF ��ȣ ���´�� END IF; ���


    IF
        v_salary <= 5000
    THEN
        dbms_output.put_line('�޿��� �� ����!');
    ELSIF
        v_salary <= 9000
    THEN
        dbms_output.put_line('�޿��� �߰���!');
    ELSE
        dbms_output.put_line('�޿��� ����!');
    END IF; --END�� �����ٰ� �ؾ���
END;

--SET SERVEROUTPUT ON; --��¹� Ȱ��ȭ --�巡�� �� �켱 ����
--�巡�� �ϰ� F9

--���� ����
--ORA-06550: �����ڵ� ���ۿ� �˻�
--PLS-00103: �����ڵ� ���ۿ� �˻�


-- CASE��
DECLARE
-- ���� �߰���
    v_salary NUMBER := 0;  --v:value(����)
    v_department_id NUMBER := 0;
BEGIN
    
    v_department_id := ROUND(DBMS_RANDOM.VALUE(10, 110), -1); 
    dbms_output.put_line('������ ����: ' || v_department_id);
    
    SELECT
        salary
    INTO
        v_salary
    FROM employees
    WHERE department_id = v_department_id
    AND ROWNUM = 1; -- ù° ���� ���ؼ� ������ ����.
    
    -- CASE��
    CASE
        WHEN v_salary <= 5000 THEN
            dbms_output.put_line('�޿��� �� ����!');
        WHEN v_salary <= 9000 THEN
            dbms_output.put_line('�޿��� �߰���!');
        ELSE
            dbms_output.put_line('�޿��� ����!');
    END CASE; --CASE�� ����
    
END;



-- ��ø IF��
DECLARE
    v_salary NUMBER := 0;
    v_department_id NUMBER := 0;
    v_commission NUMBER := 0;
BEGIN
    v_department_id := ROUND(DBMS_RANDOM.VALUE(10, 110), -1);
    dbms_output.put_line('������ ����: ' || v_department_id);
    
    SELECT
        salary, commission_pct --1)����
    INTO
        v_salary, v_commission --2)����
    FROM employees
    WHERE department_id = v_department_id
    AND ROWNUM = 1; -- ù° ���� ���ؼ� ������ ����. --ROWNUM �� ��ȣ�� ���
  
    IF v_commission > 0 THEN
        IF v_commission > 0.15 THEN
            dbms_output.put_line('Ŀ�̼��� 15% �̻��Դϴ�.');
            dbms_output.put_line(v_salary * v_commission);
        END IF; --END IF 1��)
    ELSE
        dbms_output.put_line('Ŀ�̼��� ����� �Ф�');
    END IF; --END IF 2��)
    
END;