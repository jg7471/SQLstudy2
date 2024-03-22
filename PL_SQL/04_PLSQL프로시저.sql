--mySQL���� ����

-- ���ν���(procedure) -> void �޼��� ����
-- Ư���� ������ ó���ϰ� ������� ��ȯ���� �ʴ� �ڵ� ��� (����)
-- ������ ���ν����� ���ؼ� ���� �����ϴ� ����� �ֽ��ϴ�.


CREATE PROCEDURE guguproc --���ν��� �̸� ����
    (p_dan IN NUMBER) --�Ű����� --IN/OUT ����
IS --PROCEDURE : IS ��� �͸����� DECLARE(�����) : �ʿ��� ���� ���� ���⿡ ����


BEGIN
    dbms_output.put_line(p_dan || '��');

    FOR i IN 1..9
    LOOP
        dbms_output.put_line(p_dan || 'x' || i || '=' || p_dan*i);
    END LOOP;
END;

--����
EXEC guguproc(37); --ȣ�� �� ȣ���� �� --���ԵǸ� ����

--------------------------------------------------------------------------------

--�Ű���(�μ�) ���� ���ν���
CREATE PROCEDURE p_test
IS --�����
    v_msg VARCHAR2(30) := 'Hello Procedure!';

BEGIN -- ���ۺ�
    dbms_output.put_line(v_msg);
END; --�����


--����
EXEC p_test; --() ��� ��


--------------------------------------------------------------------------------


-- IN �Է°��� ���� �� ���޹޴� ���ν���
CREATE PROCEDURE my_new_job_proc
    (
    p_job_id IN jobs.job_id%TYPE,--TYPE ���󰡰ڴ�
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE, --���� �׸�� �׳� Ÿ�� ������ ���ſ���(INSERT�� ���x)
    p_max_sal IN jobs.max_salary%TYPE
    )
IS --���� �Ұ�(������ ����μ�)

BEGIN
    INSERT INTO jobs --PROCEDURE�� ȣ���� �� ���޹��� ��
    VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    
    COMMIT;--�μ�Ʈ �������� ���������� Ŀ���ϰٴ�(�ѹ��ص� ���� �Ұ�)
END;

--����
EXEC my_new_job_proc('JOB1', 'test job1', 2000, 5000);

--��ȸ
SELECT * FROM jobs; --����Ȯ�� (Ŀ�Ա��� �Ϸ�)

--job_id�� Ȯ���ؼ�
--�̹� �����ϴ� �����Ͷ�� ����, ���ٸ� ���Ӱ� �߰�(job_id�� PK�̱� ����)



--------------------------------------------------------------------------------


CREATE OR REPLACE PROCEDURE my_new_job_proc -- ���ν��� ���� ����X CREATE ����O REPLACE : VIEW����
    (p_job_id IN jobs.job_id%TYPE, --TYPE ���󰡰ڴ�
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE,
    p_max_sal IN jobs.max_salary%TYPE
    )
IS
    v_cnt NUMBER := 0; --���� ���� Ȯ��

BEGIN
    --������ job_id�� �ִ������� üũ
    --�̹� �����Ѵٸ� 1, �������� �ʴ´ٸ� 0 -> v_cnt�� ����


    SELECT --�μ�Ʈ �ϱ����� �ߺ��� ��ȸ 0��)
        COUNT(*) --jobs�� p_job_id�� �ִ��� üũ 1��) �����̸Ӹ�Ű
        
    INTO   
        v_cnt --2��) ī��Ʈ �� ����, ������ 1 ������ 0
    
    FROM jobs
    
    WHERE job_id = p_job_id;
    IF v_cnt = 0 THEN --��ȸ ����� �����ٸ� INSERT
        INSERT INTO jobs
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    
    ELSE --��ȸ ����� �ִٸ� UPDATE
        UPDATE jobs
        SET job_title = p_job_title,
        min_salary = p_min_sal,
        max_salary = p_max_sal
        WHERE job_id = p_job_id;
        
    END IF;
    COMMIT;
END;



EXEC my_new_job_proc('JOB3', 'test_job3', 8000, 10000); --������ ������ ��ü ������ �߰�
SELECT * FROM jobs;

















--------------------------------------------------------------------------------
--�Ű���(�μ�)�� ����Ʈ ��(�⺻��) ����
CREATE OR REPLACE PROCEDURE my_new_job_proc -- ���ν��� ���� ����X CREATE ����O REPLACE : VIEW����
    (p_job_id IN jobs.job_id%TYPE,
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE := 0,
    p_max_sal IN jobs.max_salary%TYPE := 1000
    )
IS
    v_cnt NUMBER := 0; --���� ���� Ȯ��
    
BEGIN
    --������ job_id�� �ִ������� üũ
    --�̹� �����Ѵٸ� 1, �������� �ʴ´ٸ� 0 -> v_cnt�� ����


    SELECT --�μ�Ʈ �ϱ����� �ߺ��� ��ȸ 0��)
        COUNT(*) --jobs�� p_job_id�� �ִ��� üũ 1��) �����̸Ӹ�Ű
        
    INTO   
        v_cnt --2��) ī��Ʈ �� ����, ������ 1 ������ 0
    
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN --��ȸ ����� �����ٸ� INSERT
        INSERT INTO jobs
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    
    ELSE --��ȸ ����� �ִٸ� UPDATE
        UPDATE jobs
        
        SET job_title = p_job_title,
        min_salary = p_min_sal,
        max_salary = p_max_sal
        
        WHERE job_id = p_job_id;
        
    END IF;
    COMMIT;
END;

EXEC my_new_job_proc('JOB4', 'test job5'); --:= 0, := 1000, �⺻�� �����ؼ� �Է� ���ص� ����
SELECT * FROM jobs;


--------------------------------------------------------------------------------


--OUT, IN OUT �Ű����� ���
--OUT ������ ����ϸ� ���ν��� �ٱ������� ���� �����ϴ�
--OUT�� �̿��ؼ� ���� ���� �ٱ� �͸� ��Ͽ��� �����ؾ� �մϴ�

CREATE OR REPLACE PROCEDURE my_new_job_proc -- ���ν��� ���� ����X CREATE ����O REPLACE : VIEW����
    (p_job_id IN jobs.job_id%TYPE, --IN �ܺΰ� ����
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE := 0,
    p_max_sal IN jobs.max_salary%TYPE := 1000,
    p_result OUT VARCHAR2 --OUT ���ν��� ���ο��� �ٱ����� �������� ���� ����
    )
IS
    v_cnt NUMBER := 0; --���� ���� Ȯ��
    v_result VARCHAR2(100) := '�������� �ʴ� ���̶� INSERT ó�� �Ǿ����ϴ�';

BEGIN

    SELECT --�μ�Ʈ �ϱ����� �ߺ��� ��ȸ 0��)
        COUNT(*) --jobs�� p_job_id�� �ִ��� üũ 1��) �����̸Ӹ�Ű
        
    INTO   
        v_cnt --2��) ī��Ʈ �� ����, ������ 1 ������ 0
    
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN --��ȸ ����� �����ٸ� INSERT
        INSERT INTO jobs
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    
    ELSE --��ȸ ����� �ִٸ� UPDATE

        SELECT
            p_job_id || '�� �ִ�޿�:' || max_salary ||'�ּұ޿�' min_salary       
        INTO --��ȸ����� INTO�� ����
            v_result --��ȸ ����� ������ ����
            
        FROM jobs
        WHERE job_id = p_job_id;
                
    END IF;
    
    --OUT �Ű������� ��ȸ����� �Ҵ� -> �츮�� �˰��ִ� return ����� ����
    --OUT �Ű������� ���� �Ҵ��� ������ ���ν��� ���� �� ȣ��η� OUT������ ���� ���޵�
    p_result := v_result;
    
    COMMIT;
END;

--------------------------------------------------------------------------------
DECLARE
    msg VARCHAR2(100);

BEGIN
    my_new_job_proc('JOB2', 'test_job2', 2000, 8000, msg); --msg ȣ�� �Լ� @ : p_result OUT VARCHAR2
    dbms_output.put_line(msg);
    
    my_new_job_proc('CEO1', 'test_ceo1', 30000, 80000, msg);-- �������� �ʴ� ���̶� insert
    dbms_output.put_line(msg);
    
    --my_new_job_proc('CEO2', 'test_ceo2', 30000, 80000); --���� --msg ���� �־����
    --dbms_output.put_line(msg);
END;

SELECT * FROM jobs;

--�ڹ� : �Լ��� ȣ�⹮�� �ϳ���  ���ϰ�. �Ű������� ��밡��     msg := my

---------------------------------------------------
--1��������
--IN, OUT ���ÿ� ó��
CREATE OR REPLACE PROCEDURE my_param_test_proc
    (
    --IN : ��ȯ �Ұ�. �޴� �뵵�θ� ����
    p_var1 IN VARCHAR2,
    
    --OUT : �޴� �뵵�δ� �Ұ���
    --OUT�� �Ǵ� ������ ���ν����� ���� ��, �� �������� �Ҵ��� �ȵ�.
    p_var2 OUT VARCHAR2,
    
    --IN, OUT�� �� �� ������.
    p_var3 IN OUT VARCHAR2
    )
IS

BEGIN
    dbms_output.put_line('p_varl:' || p_var1); --IN ��µ�
    dbms_output.put_line('p_var2:' || p_var2); --OUT ���� ������������ �ұ��ϰ� ���ν��� ������ Ȯ�� �Ұ�
    dbms_output.put_line('p_var3:' || p_var3); --IN OUT : IN�� ������ ������ ����
    
    --p_var1 := '���1';--(�޴� �뵵��,�� �Ҵ� ������ �Ұ�:���ο� ������ ����Ұ�)
    p_var2 := '���2';--(�� ���� ����)
    p_var3 := '���3';--�ޱ� �������� �� ��
    
END;
    
    ----------------------------------
--2������    
DECLARE
    v_var1 VARCHAR2(10) := 'value1';
    v_var2 VARCHAR2(10) := 'value2'; --OUT ���ϰ� ����
    v_var3 VARCHAR2(10) := 'value3';
BEGIN
    my_param_test_proc(v_var1, v_var2, v_var3);
    
    dbms_output.put_line('v_var1: ' || v_var1);
    dbms_output.put_line('v_var2: ' || v_var2);
    dbms_output.put_line('v_var3: ' || v_var3);
    
END;

--RETURN: ���� ��ȯX, ���ν��� ���� ������ �� ���

--------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE my_new_job_proc
    (p_job_id IN jobs.job_id%TYPE,
     p_result OUT VARCHAR2 
    )
IS
    v_cnt NUMBER := 0;
    v_result VARCHAR2(100) := '�������� �ʴ� ���̶� INSERT ó�� �Ǿ����ϴ�.';
BEGIN
    
    SELECT
        COUNT(*)
    INTO
        v_cnt
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN --�� ��ȸ�Ͽ�, ������ ���� ����(�ٷ� �����ϱ⿡ �⺻��� ��ġX-> ELSE ���ʿ�, ����->��������)
        dbms_output.put_line(p_job_id || '�� ���̺� �������� �ʽ��ϴ�.');
        RETURN; -- ���ν��� ���� ����.
    END IF;
     
     
     
     
    SELECT --�⺻���
        p_job_id || '�� �ִ� ����: ' || max_salary || ', �ּ� ����: ' || min_salary
    INTO
        v_result 
    FROM jobs
    WHERE job_id = p_job_id;

    p_result := v_result;
    
    COMMIT;
END;


DECLARE
    msg VARCHAR2(100);
BEGIN 
    my_new_job_proc('merong', msg); --job id�� merong
    dbms_output.put_line(msg);
END;

--------------------------------------------------------------------------------

--����ó��
DECLARE
    v_num NUMBER := 0;

    /*
    OTHERS �ڸ��� ������ Ÿ���� �ۼ��� �ݴϴ�.
    ACCESS_INTO_NULL -> ��ü �ʱ�ȭ�� �Ǿ� ���� ���� ���¿��� ���.
    NO_DATA_FOUND -> SELECT INTO �� �����Ͱ� �� �ǵ� ���� ��
    ZERO_DIVIDE -> 0���� ���� ��
    VALUE_ERROR -> ��ġ �Ǵ� �� ����
    INVALID_NUMBER -> ���ڸ� ���ڷ� ��ȯ�� �� ������ ���
    */

BEGIN
    v_num := 10/0;
    EXCEPTION --SQL���� ���� �������� ����
        WHEN ZERO_DIVIDE THEN --���� ����
        dbms_output.put_line('0���� �����ø� �ȵǿ�');
        dbms_output.put_line('SQL ERROR CODE:' || SQLCODE); --SQLCODE ���� ����
        dbms_output.put_line('0���� �����ø� �ȵǿ�' || SQLERRM);
    WHEN OTHERS THEN --�ڹ� catch(exception) : ��� ���� �޾��ִ� ����
        --WHEN���� ������ ���ܰ� �ƴ� �ٸ� ���ܰ� �߻� �� OTHERS ����
        dbms_output.put_line('�� �� ���� ���� �߻�!');
        
        
    dbms_output.put_line('�͸��� ����');
END;