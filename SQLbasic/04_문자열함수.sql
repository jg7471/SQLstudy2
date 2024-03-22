
SELECT * FROM dual; --TEST�� ���̺�(������ �׽�Ʈ)

/*
dual�̶�� ���̺��� sys�� �����ϴ� ����Ŭ�� ǥ�� ���̺�μ�,
���� �� �࿡ �� �÷��� ��� �ִ� dummy ���̺� �Դϴ�.
�Ͻ����� ��� �����̳� ��¥ ���� � �ַ� ����մϴ�.
��� ����ڰ� ������ �� �ֽ��ϴ�.
*/

-- lower(�ҹ���), initcap(�ձ��ڸ� �빮��), upper(�빮��)
SELECT
'abcDEF', lower('abcDEF'), initcap('abcDEF'), upper('abcDEF')
FROM dual;

SELECT
last_name
    last_name,
    LOWER(last_name),
    INITCAP(last_name),
    UPPER(last_name)
FROM employees;

SELECT
    salary
FROM employees
WHERE LOWER(last_name) = 'austin'; --�̸� ��ҹ��� ���� --LOWER �ҹ��ڷ� �˻� : �ڹ� or SQL���� ó���ؾ�


--length(����), instr(���� ã��, ������ 0 ��ȯ, ������ �ε��� ��)
SELECT
    'abcdef', LENGTH('avcdef'), INSTR('abcdef', 'b') --idx 1���� ����(������ 0���� ����, ���� ���װ� Ư���Ѱ�)
FROM dual;

SELECT
    first_name, 
    LENGTH(first_name),
    INSTR(first_name, 'a')
FROM employees;

--substr(�ڸ� ���ڿ�, �����ε��� ,����)
--substr(�ڸ� ���ڿ�, �����ε���) ->���ڿ� ������
--�ε��� 1���� ����
--concat(���� ����) *�Ű��� �ΰ� �ۿ� -> 3�� �̻� : OR -> CONCAT �� �Ⱦ�
--mysql CONCAT ���� ���� : OR ����

SELECT
    'abcdef' AS ex,
    SUBSTR('abcdef',2 ,4), --2���� 4���� �ڸ�(�ڹ� �̸�)
    SUBSTR('abcdef',2), --������
    CONCAT('abc', '123') --���� -- concat�� �Ű��� 2�� �ۿ� �ȹ���
FROM dual;

SELECT
    first_name,
    SUBSTR(first_name, 1, 3),
    CONCAT(first_name, last_name)
FROM employees;

--LPAD, RPAD (��/���� ������ ���ڿ��� ä���)
SELECT
    LPAD('abc', 10, '*'), --�������� + ä�﹮�� = 10 (������ ���� �� : ��ȭ��ȣ)
    RPAD('abc', 10, '*')
FROM dual;

--LTRIM(), RTRIM()
--LTRIM(param1, param2) -> param2�� ���� param1���� ã�Ƽ� ����(���ʺ���)
SELECT
    LTRIM('javascript_java', 'java') --javascript_java���� java��� ���ڸ� ����
FROM dual;

--RTRIM(param1, param2) -> param2�� ���� param1���� ã�Ƽ� ����(�����ʺ���)
SELECT
    RTRIM('javascript_java', 'java')
FROM dual;

--TRIM() : ���� ��������
SELECT TRIM('            java           ') FROM dual;

--REPLACE(str, old, new) --���� ��ü
SELECT
    REPLACE('My dream is a president', 'president', 'programmer')
FROM dual;

SELECT
    REPLACE(REPLACE('My dream is a president', 'president', 'programmer'), ' ', '��')
FROM dual; --���� ���� ������

--�ڹ� : �Լ��� ȣ�⹮�� �ٸ� �Լ��� �Ű�������
--�Լ��� ���ϰ��� �ٸ��Լ��� �Ű������� ��밡��

SELECT
    REPLACE(CONCAT('hello', '(world!'), '!', '?')
FROM dual;




