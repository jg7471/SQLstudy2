/*
AFTER Ʈ���� - INSERT, UPDATE, DELETE �۾� ���Ŀ� �����ϴ� Ʈ���Ÿ� �ǹ��մϴ�.
BEFORE Ʈ���� - INSERT, UPDATE, DELETE �۾� ������ �����ϴ� Ʈ���Ÿ� �ǹ��մϴ�.

:OLD = ���� �� ���� �� (INSERT: �Է� �� �ڷ�, UPDATE: ���� �� �ڷ�, DELETE: ������ ��) --before
:NEW = ���� �� ���� �� (INSERT: �Է� �� �ڷ�, UPDATE: ���� �� �ڷ�) --after

���̺� UPDATE�� DELETE�� �õ��ϸ� ����, �Ǵ� ������ �����͸� --������̺� �ۼ��� ���� ��
������ ���̺� ������ ���� �������� Ʈ���Ÿ� ���� ����մϴ�.

Ʈ���� ��ü�� Ʈ������� �Ϻη� ó���ϱ� ������ COMMIT�̳� ROLLBACK�� ���� �� �� �����ϴ�.
*/

--����0
CREATE TABLE tbl_user( --���̺� ����
    id VARCHAR2(20) PRIMARY KEY,
    name VARCHAR2(20),
    address VARCHAR2(30)
);



CREATE TABLE tbl_user_backup( --��� ���̺� ����
    id VARCHAR2(20) PRIMARY KEY,
    name VARCHAR2(20),
    address VARCHAR2(30),
<<<<<<< HEAD
    --�������
=======
    --����� �߰��Է�
>>>>>>> 6e8d7447f5a661392580a0948efdd4b5526b15bb
    update_date DATE DEFAULT sysdate, -- ���� ���� �ð�(�⺻��: INSERT �Ǵ� �ð�) --�μ�Ʈ�� �� sysdate �ڵ� �Էµ�
    m_type VARCHAR2(10), -- ���� Ÿ�� --���� or ����
    m_user VARCHAR2(20) -- ������ ����� --����
);



--AFTER Ʈ���� ���� ���� � ����
CREATE OR REPLACE TRIGGER trg_user_backup
    --Ʈ���� ����
    AFTER UPDATE OR DELETE
    ON tbl_user
    FOR EACH ROW --��� �࿡ ����
    
DECLARE
    --Ʈ���� ���� : �������� = --m_type
    v_type VARCHAR2(10);

BEGIN
    --���� Ʈ���Ű� �ߵ��� ��Ȳ�� UPDATE���� DELETE���� �ľ��ϴ� ���ǹ�
    IF UPDATING THEN -- UPDATING�� �ý��� ��ü���� ���¿� ���� ������ �����ϴ� ��Ʈ�� <����Ŭ>�⺻ ����. //INSERTING
        v_type := '����'; --m_type
    ELSIF DELETING THEN
        v_type := '����';
    END IF;

    
    --�������� ���� ���� �ۼ� (backup ���̺� ���� INSERT
    -- -> ���� ���̺��� UPDATE or DELETE �� ������� ���� �� ��Ÿ ����)
    INSERT INTO tbl_user_backup
    VALUES(:OLD.id, :OLD.name, :OLD.address, sysdate, v_type, USER()); --���� id, name , address : ����/���� �Ǳ� ���� �������Էµ�(Ʈ����)
    --��¥ update_date �ȳ־�� �ڵ��Է�(�÷� ���� �����Ƽ� ����)
    --USER() �Լ� : ���� ������
    
END;



-- Ȯ��!
INSERT INTO tbl_user VALUES('test01', 'kim', '����');
INSERT INTO tbl_user VALUES('test02', 'lee', '���');
INSERT INTO tbl_user VALUES('test09', 'hong', '�λ�');

SELECT * FROM tbl_user;
SELECT * FROM tbl_user_backup; --������̺� ����(����,����) --���� insert X, Ʈ���ſ� ���� �ڵ� �Էµ� : ������ ���� ���� �Էµ�!!
--@ ���� �Ȱ� Ȯ��

UPDATE tbl_user SET address = '��õ' WHERE id = 'test01'; --���� �����ε� -> ��õ���� ����
DELETE FROM tbl_user WHERE id = 'test02';



--240319
--����1
--BEFORE Ʈ���� ����
CREATE OR REPLACE TRIGGER trg_user_insert
    BEFORE INSERT
    ON tbl_user --���������� ����
    FOR EACH ROW

--DECLARE --���� ���� @

BEGIN
    --INSERT ������ name�� ������ ù���ڸ� ���� �� �ڿ� *�� 3�� ���̰ڴ�
    :NEW.name := SUBSTR(:NEW.name, 1, 1) || '***'; --������ ���ο� name�� �� ex)��** �ν��� ������ name�� ���� 1���ڸ� ���� tbl_user�� ����/// LTRIM ����ص� ��
    --:NEW ������ ���ο� ��
    
    --substr(�ڸ� ���ڿ�, �����ε��� ,����)
    --���⼱ ROLLBACK; �Ұ� : TRIGGER���� Ʈ����� �Ұ�(�ٱ����� ��� ����)
END;



--������ ���� tbl_user 
INSERT INTO tbl_user VALUES('test07', '�޷���', '����');--INSERT ��� ����xx : INSERT, UPDATE, DELETE �Ǳ� �� �̸� ó���ϰڴ�!!
INSERT INTO tbl_user VALUES('test05', '�����Ŭ', '����');

ROLLBACK;









--����2
-- �ֹ� �����丮
CREATE TABLE order_history (
    history_no NUMBER(5) PRIMARY KEY,
    order_no NUMBER(5), --��ǰ��ȣ ������X(�ߺ�����)
    product_no NUMBER(5),
    total NUMBER(10),
    price NUMBER(10)
);


-- ��ǰ
CREATE TABLE product(
    product_no NUMBER(5) PRIMARY KEY,
    product_name VARCHAR2(20),
    total NUMBER(5),
    price NUMBER(5)
);



--������ ����
CREATE SEQUENCE order_history_seq NOCYCLE NOCACHE; --���� �޴����� ������ Ȯ�ε� ����
CREATE SEQUENCE product_seq NOCYCLE NOCACHE;


--���� ������ ����
INSERT INTO product VALUES(product_seq.NEXTVAL, '����', 100, 10000);
INSERT INTO product VALUES(product_seq.NEXTVAL, 'ġŲ', 100, 20000);
INSERT INTO product VALUES(product_seq.NEXTVAL, '�ܹ���', 10, 5000);

SELECT * FROM product;






--�ֹ� �����丮�� �����Ͱ� ������ �����ϴ� Ʈ����
CREATE OR REPLACE TRIGGER trg_order_history --trg_����
    BEFORE INSERT
    ON order_history
    FOR EACH ROW
    
DECLARE
    --���� ����
    v_total NUMBER;
    v_product_no NUMBER;
    v_product_total NUMBER;
    --Ŀ���� ���� ����
    quantity_shortage_exception EXCEPTION; --EXCEPTIONŸ�� ���� ����(���� Ŀ�����ϱ� ����)
    zero_total_exception EXCEPTION;

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
    
    IF v_product_total <= 0 THEN -- ��� ���� ���
        RAISE zero_total_exception; --���� ���� �߻�
    
    
    ELSIF v_total > v_product_total THEN --�ֹ������� ���������� ���� ���
        RAISE quantity_shortage_exception;
    END IF;
        
    --��� ������ �˳��ϴٸ� �ֹ�������ŭ ������ ����(�������� ��)
    UPDATE product SET total = total - v_total
    WHERE product_no = v_product_no;
    
        EXCEPTION
        WHEN quantity_shortage_exception THEN
        -- ����Ŭ���� �����ϴ� ����� ���� ���ܸ� �߻���Ű�� �Լ� : RAISE_APPLICATION_ERROR(��ȣ, ��°�)
        -- ù��° �Ű���: ���� �ڵ� (����� ���� ���� -20000 ~ -20999����)
        -- �ι�° �Ű���: ���� �޼���
        RAISE_APPLICATION_ERROR(-20001, '�ֹ��Ͻ� �������� ��� ��� �ֹ� �� �� �����ϴ�'); --���� ���� �߻���(20001 Ŀ������)
        
        WHEN zero_total_exception THEN
        RAISE_APPLICATION_ERROR(-20001, '�ֹ��Ͻ� ��� ��� �ֹ� �� �� �����ϴ�'); --���� ���� �߻���

END;

                                --history_no PRIMARY KEY, order_no, product_no, total, price
INSERT INTO order_history VALUES(order_history_seq.NEXTVAL, 200, 1, 5, 50000); --�ֹ���ȣ(200) �ߺ�O : ���ÿ� ���� ��ǰ ����
INSERT INTO order_history VALUES(order_history_seq.NEXTVAL, 200, 2, 1, 20000);
INSERT INTO order_history VALUES(order_history_seq.NEXTVAL, 200, 3, 5, 25000); -- �ٽ�� --ORA-20002 ����

SELECT * FROM order_history;
SELECT * FROM product;

--Ʈ���� ������ ���ܰ� �߻��ϸ� �������� INSERT �۾��� �ߴܵǸ� ROLLBACK�� ����� : AFTER trigger�� ����
INSERT INTO order_history VALUES(order_history_seq.NEXTVAL, 203, 1, 100, 1000000); --��� ���� --ORA-20001 ����
