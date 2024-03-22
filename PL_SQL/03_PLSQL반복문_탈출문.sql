--WHILE��

DECLARE
    v_total NUMBER := 0;
    v_count NUMBER := 1;

BEGIN
    WHILE v_count <= 10 --end
    LOOP
        v_total := v_total + v_count;
        v_count := v_count +1; --step : ++ ���� : DB���� ����(���̽㵵 ����)
    
    END LOOP;
    dbms_output.put_line(v_total);

END;

--Ż�⹮

DECLARE
    v_total NUMBER := 0;
    v_count NUMBER := 1;

BEGIN
    WHILE v_count <= 10 --end
    LOOP
    
        EXIT WHEN v_count = 5; --EXIT = break ���� ����
        
        
        v_total := v_total + v_count;
        v_count := v_count +1; --step : ++ ���� : DB���� ����(���̽㵵 ����)
    
    END LOOP;
    dbms_output.put_line(v_total);

END;

--FOR��
DECLARE
    v_num NUMBER := 7;

BEGIN
    FOR i IN 1..9 -- .�� 2�� �ۼ��ؼ� ���� ǥ��
    LOOP
        dbms_output.put_line(v_num || 'x' || i || '=' || v_num*i);
    
    END LOOP;
    
END;

--CONTINUE��
DECLARE
    v_num NUMBER := 7;

BEGIN
    FOR i IN 1..9 -- .�� 2�� �ۼ��ؼ� ���� ǥ��
    LOOP
        CONTINUE WHEN MOD(i, 2) = 0; --����Ŭ %���� ���� -> MOD ���
        dbms_output.put_line(v_num || 'x' || i || '=' || v_num*i);
    
    END LOOP;
    
END;


--------------------------------------------------------------------------------
-- 1. ��� �������� ����ϴ� �͸� ����� ���弼��. (2 ~ 9��)
-- ¦���ܸ� ����� �ּ���. (2, 4, 6, 8)
-- ����� ����Ŭ ������ �߿��� �������� �˾Ƴ��� �����ڰ� �����. (% ����~)

--�ؼ� 1)
BEGIN
    FOR num IN 2..9
    LOOP
        IF MOD(num, 2) = 0 THEN
            dbms_output.put_line('������ ' || num || '��');
            FOR row IN 1..9
            LOOP
                dbms_output.put_line(num || ' x ' || row || ' = ' || num*row);
            END LOOP;
            dbms_output.put_line('------------------------------------------------');
        END IF;
    END LOOP;
END;

--�ؼ� 2)
BEGIN
    FOR num IN 2..9
    LOOP
        CONTINUE WHEN MOD(num, 2) = 1;
        dbms_output.put_line('������ ' || num || '��');
        FOR row IN 1..9
        LOOP
            dbms_output.put_line(num || ' x ' || row || ' = ' || num*row);
        END LOOP;
        dbms_output.put_line('------------------------------------------------');
    END LOOP;
END;



--���� �ۼ�
DECLARE --DECLARE ��� ��(��������)
    i NUMBER; --���� ��� ��
    j NUMBER; --���� ��� ��

BEGIN
    FOR i IN 2..9
    LOOP
        dbms_output.put_line(i||'��');
        
        FOR j IN 1..9
        LOOP
        dbms_output.put_line(i || '*' || j || '=' || i*j);
    
        END LOOP;
    END LOOP;
    
END;




-- 2. INSERT�� 300�� �����ϴ� �͸� ����� ó���ϼ���.
-- board��� �̸��� ���̺��� ���弼��. (bno, writer, title �÷��� �����մϴ�.)
-- bno�� SEQUENCE�� �÷� �ֽð�, writer�� title�� ��ȣ�� �ٿ��� INSERT ������ �ּ���.
-- ex) 1, test1, title1 -> 2 test2 title2 -> 3 test3 title3 ....

--�ؼ�
------------------����
--���̺� ����
CREATE TABLE board(
    bno NUMBER PRIMARY KEY, --������X �⺻ 38
    writer VARCHAR2(30),
    title VARCHAR2(30)
);

--������ ����
CREATE SEQUENCE b_seq 
    START WITH 1 --���� ���� : ���۰�
    INCREMENT BY 1 --���� ���� : ������
    MAXVALUE 10000 --�ִ밪
    NOCYCLE --: ��ȯ ����
    NOCACHE;

--�ݺ��� ����(������ ����)
DECLARE
    v_num NUMBER := 1;
BEGIN
    WHILE v_num <= 300
    LOOP
        INSERT INTO board -- ���̺� �����͸� ����
        VALUES(b_seq.NEXTVAL, 'test'||v_num, 'title'||v_num);
        
        v_num := v_num + 1;
    END LOOP;
END;

--��ȸ+����
SELECT * FROM board
ORDER BY bno DESC; --�ڹٿ����� �ۼ� �����ϳ� ���ҽ� ���� ����


--Ŀ��
COMMIT;--DB�� ������Ʈ




















--���� �ۼ�
CREATE TABLE board (
    bno NUMBER(10),
    writer VARCHAR2(14),
    title VARCHAR2(15)    
);

CREATE SEQUENCE board_seq
    START WITH 1
    INCREMENT BY 1 
    MAXVALUE 300
    MINVALUE 1
    NOCACHE
    NOCYCLE;


INSERT INTO board_seq
VALUES(bno_seq.NEXTVAL, 'a', 'a');





