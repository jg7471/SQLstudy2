/*
trigger�� ���̺� ������ ���·ν�, INSERT, UPDATE, DELETE �۾��� ����� ��
Ư�� �ڵ尡 �۵��ǵ��� �ϴ� �����Դϴ�.
VIEW���� ������ �Ұ����մϴ�.

Ʈ���Ÿ� ���� �� ���� �����ϰ� F5 or F9��ư���� �κ� �����ؾ� �մϴ�.
�׷��� ������ �ϳ��� �������� �νĵǾ� ���� �������� �ʽ��ϴ�.
*/


CREATE TABLE tbl_test(
    id NUMBER(10),
    text VARCHAR2(20)
);

--�巡�� F5 or F9 ����
CREATE OR REPLACE TRIGGER trg_test --trg_����
    AFTER DELETE OR UPDATE --Ʈ������ ���� ����(���� Ȥ�� ���� ���Ŀ� ����)
    ON tbl_test -- Ʈ���Ÿ� ������ ���̺�
    FOR EACH ROW -- �� �࿡ ��� ����(���� ����. ���� �� �� ���� ����)
--DECLARE -- ���� ���� (���� �����Ұ� ����)

BEGIN
    dbms_output.put_line('Ʈ���Ű� ������'); --�����ϰ��� �ϴ� �ڵ带 begin - end ���̿� ����
END;





INSERT INTO tbl_test VALUES(1, '�����'); --Ʈ���� ����X ���� @ : --�μ�Ʈ Ʈ���� ����x
INSERT INTO tbl_test VALUES(2, '�����');
INSERT INTO tbl_test VALUES(3, '��û��');

UPDATE tbl_test SET text = '�谳��' WHERE id = 1; --��� -> ���� --Ʈ���� ����O
--���ۼ��� UPDATE(����� �߰� �Է�) -> AFTER DELETE OR UPDATE
DELETE FROM tbl_test WHERE id = 2; --Ʈ���� ����O
