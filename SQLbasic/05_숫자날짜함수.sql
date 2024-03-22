
--�����Լ�
--ROUND(�ݿø�)
--���ϴ� �ݿø� ��ġ�� �Ű������� ����, ������ �ִ� �͵� ����
SELECT
    ROUND(3.1415, 3), ROUND(45.923, 0), ROUND(45.923, 1) --�ݿø� �ڸ���
FROM dual;

--TRUNC(����)
--������ �Ҽ��� �ڸ������� �߶�
SELECT
    TRUNC(3.1415, 3), TRUNC(45.923, 0), TRUNC(45.923, 1) --�ݿø� �ڸ���
FROM dual;

--ABS(���밪)
SELECT ABS(-34) FROM dual;

--CEIL(�ø�), FLOOR(����)
SELECT CEIL(3.14), FLOOR(3.14)
FROM dual;

--MOD(������ ������ ����)
SELECT
10 / 4, --10 % 4 --�ȵ� : MOD ���
MOD(10, 4) --������ 2
FROM DUAL;


------------------------------------------------------

--��¥�Լ�
--stsdate : ��ǻ���� ���� ��¥, �ð� ������ �����ͼ� �����ϴ� �Լ�
SELECT sysdate FROM dual; --���� ȯ�漳�� NLS : �ð� ���� ���� : RR/MM/DD HH24:MI:SSXFF
SELECT systimestamp FROM dual; --mm�ʱ��� +GMT

--��¥�� ������ �����մϴ�
SELECT sysdate + 1 FROM dual;  --���� ���� ������ ����.

--��¥Ÿ�԰� ��¥ Ÿ���� ���� ������ ����(����X)
SELECT
    first_name, sysdate - hire_date
FROM employees
ORDER BY hire_date ASC;

SELECT
    first_name,
    --(sysdate - hire_date) / 365 AS year --���
    (sysdate - hire_date) / 7 AS week --�ּ�
FROM employees;

-- ��¥ �ݿø�, ����
SELECT ROUND(sysdate) FROM dual; --12:00 ����:
SELECT ROUND(sysdate, 'year') FROM dual; --7/1 ����
SELECT ROUND(sysdate, 'month') FROM dual; --15�� ����
SELECT ROUND(sysdate, 'day') FROM dual; --�� ���� : �Ͽ��� first

SELECT TRUNC(sysdate) FROM dual;
SELECT TRUNC(sysdate, 'year') FROM dual; --�� �������� ����
SELECT TRUNC(sysdate, 'month') FROM dual; --�� �������� ����
SELECT TRUNC(sysdate, 'day') FROM dual; --�� �������� ���� : �Ͽ��� first


