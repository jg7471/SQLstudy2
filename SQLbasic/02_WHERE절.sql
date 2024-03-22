SELECT *
FROM employees;

-- WHERE�� �� (������ ���� ��/�ҹ��ڸ� ����)
SELECT first_name, last_name, job_id
FROM employees
WHERE job_id = 'IT_PROG'; --it_prog �ȵ�(���ϴ� ����)

SELECT *
FROM employees
WHERE last_name = 'King';

SELECT *
FROM employees
WHERE department_id = 50; --'50', 50 //���� �μ���ȣ�� 50 : �Ϲ��� ����ȯ

SELECT *
FROM employees
WHERE hire_date = '04/01/30'; --��¥ ����

SELECT *
FROM employees
WHERE salary >= 15000
AND salary < 20000;

--�������� �� ����(BETWEEN, IN, LIKE)
SELECT * FROM employees
WHERE salary BETWEEN 15000 AND 20000; --��� ���� ����, ���� ����ӵ� ���� �� ����

SELECT * FROM employees
WHERE hire_date BETWEEN '03/01/01' AND '03/12/31';

--IN �������� ���(Ư�� ����� ���� �� ���)
SELECT * FROM employees
WHERE manager_id IN (100, 101, 102);

SELECT * FROM employees
WHERE job_id IN ('IT_PROG', 'AD VP');

--LIKE ������
--%�� ��� ���ڵ�, _�� �������� �ڸ�(��ġ)�� ǥ���� ��
--WHERE LIKE %���% --Ȩ������ �˻� ֪ : ��� ���ְ� ���̴� �� �˻�


SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '03%'; -- % �� : anything :03���θ� �����ϸ� �������

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%15'; -- �� % :anything :15�θ� �����ϸ� �������

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%05%'; -- �յ� ���X 05�� ���ԵǾ� ������ ��������

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '___05%'; -- ___�տ� ������ �ְ�(��) 05�� ���� % �׵ڴ� ���X

SELECT * FROM employees
WHERE commission_pct IS NULL; -- NULL ���� Ȯ��  NULL �� = ������ڷ� �� X

SELECT * FROM employees
WHERE commission_pct IS NOT NULL;

--AND, OR : AND >>> OR
SELECT * FROM employees
WHERE (job_id = 'IT_PROG'
OR job_id = 'FI_MGR') --1�� ����
AND salary >= 6000; --AND�� �켱 ����� : WHERE ���߿� ���� ��(IT_PROG�� ��ȸ ���� �ʾҴ�)->()��� �켱���� ���� --2�� ����

--�������� ���� (SELECT ������ ���� �������� ��ġ��)
--ASC : ascending ��������(�������� : �⺻��)
--DESC : descending ��������
SELECT * FROM employees
ORDER BY hire_date ASC; --�Ի����� ���� ������(ASC ��������)

SELECT * FROM employees
ORDER BY hire_date DESC; --�Ի����� ���� ������

SELECT * FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY first_name ASC;

SELECT * FROM employees
WHERE salary >= 5000
ORDER BY employee_id DESC; --ORDER BY �׻� ������

SELECT
    first_name,
    salary*12 AS pay --pay�� ��Ī
    
FROM employees
ORDER BY pay ASC; --pay(��Ī(����))�� ���� ���� ����

