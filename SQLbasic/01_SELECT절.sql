

-- Oracle�� �� �� �ּ�
/*
������ �ּ�
*/

-- SELECT [�÷���(� �� ����)] FROM [���̺� �̸�]
SELECT
    employee_id, 
    first_name, 
    last_name
FROM
    employees; -- * ALL�� �ǹ� --sql ��ҹ��� ����X but ���ʴ� Ű���� �빮��//�ĺ��� �ҹ���
    --������ �̷��� ������

SELECT email, phone_number, hire_date
From employees;

-- �÷��� ��ȸ�ϴ� ��ġ���� * / + - ������ �����մϴ�
SELECT
    employee_id,
    first_name,
    last_name,
    salary,
    salary + salary *0.6 as ������ --��ȸ�� ���� --���� �����ʹ� ������ ����
FROM employees;

--NULL ���� Ȯ��(���� 0�̳� ������� �ٸ� ����)
SELECT department_id, commission_pct --������
FROM employees;

SELECT
    first_name AS ��, --alias(�÷���, ���̺���� �̸��� �����ؼ� ��ȸ)
    last_name AS �̸�,
    salary AS �޿�    
FROM employees;



/*
����Ŭ�� Ȭ����ǥ�� ���ڸ� ǥ���ϰ�, ���ڿ� �ȿ� Ȭ����ǥ Ư����ȣ��
ǥ���ϰ� �ʹٸ� ''�� �� �� �������� ���ø� �˴ϴ�.
���ڿ� �����ȣ�� || �Դϴ�. ���ڿ��� ���� ������ ������� �ʽ��ϴ�.
*/
SELECT
    first_name || ' ' || last_name ||'''s salay is ' || salary AS �޿�����
FROM employees; --FROM���� �ۼ�// SQL FROM���� ���� ���� ����� -- '('')Ȭ����ǥ


--DISTINCT(�ߺ� ���� ����)
SELECT department_id FROM employees;
SELECT DISTINCT department_id FROM employees; --�ߺ� ���� : �и���

--ROWNUM,ROWID --�ּҰ�
--ROWNUM : ������ ���� ��ȯ�Ǵ� �� ��ȣ�� ��� (����¡ �� �� ��)
--ROWID : �����ͺ��̽� ���� ���� �ּҸ� ��ȯ(�� �� ���� ����)
SELECT ROWNUM, ROWID, employee_id
FROM employees;
