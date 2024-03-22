
--�׷��Լ� AVG, MAX, MIN, SUM, COUNT : ����Ϸ��� �׷��� �ؾ� ��
--�׷�ȭ�� ���� ���� ������ �׷��� ���̺� ��ü�� �˴ϴ�.
SELECT
    AVG(salary),
    MAX(salary),
    MIN(salary),
    SUM(salary),
    COUNT(salary)
FROM employees;

SELECT COUNT(*) --�� ���� ��
FROM employees;

SELECT COUNT(first_name) FROM employees; --�䷸�Ե� ��(���� ���� ���)
SELECT COUNT(commission_pct) FROM employees; --null�� �ƴ� ���� ��
SELECT COUNT(manager_id) FROM employees;

SELECT * FROM employees;

--�μ����� �׷�ȭ, �׷��Լ��� ���
SELECT
    department_id,
    AVG(salary) --department_id(�� �μ�)�� ���
FROM employees
GROUP BY department_id; --�ش� �׸� �׷�ȭ

-- ������ ��
-- �׷� �Լ��� �ܵ������� ���� ���� ��ü ���̺��� �׷��� ����� ������
-- �Ϲ� �÷��� ���ÿ� �׳� ��µ� ���� �����ϴ�. �׷��� �ʿ��մϴ�.
SELECT
    department_id,
    AVG(salary)
FROM employees; --����

-- GROUP BY���� ����� �� GROUP ���� ������ ���� �÷��� ��ȸ �Ұ�
SELECT
    job_id,
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id; --����(job_id ����)

-- ��GROUP BY�� 2�� �̻� ��� : �ߺ� �߻�
SELECT
    job_id,
    department_id,
    AVG(salary)
FROM employees
GROUP BY job_id, department_id;

--GROUP BY�� ���� �׷�ȭ �� �� ������ �� ��� HAVING�� ���
--WHERE�� �Ϲ� ������ GROUP BY ���� ���� ����
SELECT
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 100000;
--SQL ������� FROM -> WHERE -> GROUP BY -> HAVING -> SELECT(��� ����) -> ORDER BY(��� ��밡��) : ȿ���� : �׷��� WHERE (salary) > 10000; �Ұ�
--ORDER BY ���� �Ʒ�

SELECT
    job_id,
    count(*)
FROM employees
GROUP BY job_id
HAVING COUNT(*) >= 5; --count�� 5 �̻�

--�μ� ���̵� 50 �̻��� �͵��� �׷�ȭ ��Ű��, �׷� �޿� ����� 5000 �̻� ��ȸ
--���� �ۼ�
SELECT
    department_id, AVG(salary)
FROM employees
WHERE salary > 5000
GROUP BY department_id
HAVING department_id > 50
ORDER BY AVG(salary) DESC;

--�ش�
SELECT
    department_id,
    AVG(salary) AS ���
FROM employees
WHERE department_id >= 50
GROUP BY department_id
HAVING AVG(salary) >= 5000
ORDER BY ��� DESC;

    



/*
���� 1.
1-1. ��� ���̺��� JOB_ID�� ��� ���� ���ϼ���.
1-2. ��� ���̺��� JOB_ID�� ������ ����� ���ϼ���. ������ ��� ������ �������� �����ϼ���.
*/

--�ؼ�
SELECT
    job_id,
    COUNT(*),
    AVG(salary) AS ��տ���
FROM employees
GROUP BY job_id
ORDER BY ��տ��� DESC;



--���� �ۼ� 1��
SELECT
    job_id, salary
FROM employees
GROUP BY job_id, salary
HAVING AVG (salary) > 1
ORDER BY salary DESC;

--���� �ۼ� 2��
SELECT COUNT(job_id), AVG(salary), job_id
FROM employees
GROUP BY job_id
ORDER BY AVG(salary) DESC;






/*
���� 2.
��� ���̺��� �Ի� �⵵ �� ��� ���� ���ϼ���.
(TO_CHAR() �Լ��� ����ؼ� ������ ��ȯ�մϴ�. �׸��� �װ��� �׷�ȭ �մϴ�.)
*/

--�ؼ�
SELECT
    TO_CHAR(hire_date, 'yy') AS �Ի�⵵,
    COUNT(*) AS �����
FROM employees
GROUP BY TO_CHAR(hire_date, 'yy')
ORDER BY �Ի�⵵;

--���� �ۼ� 1��
SELECT
    first_name, TO_CHAR(hire_date, '99/99/99 99:99:99')
FROM employees
WHERE hire_date LIKE '__'
GROUP BY first_name, hire_date
ORDER BY hire_date DESC;


--�����ۼ� 2��
SELECT
    hire_date,
    COUNT(TO_CHAR(hire_date, 'YY/MM/DD HH:MI:SS'))
FROM employees
WHERE hire_date LIKE '__%'
GROUP BY COUNT(TO_CHAR(hire_date, 'YY/MM/DD HH:MI:SS'))
ORDER BY hire_date;


--���� �ۼ� 3��
SELECT
    TO_CHAR(hire_date, 'yy'),
    COUNT(*)
FROM employees
GROUP BY TO_CHAR(hire_date, 'yy')
ORDER BY TO_CHAR(hire_date, 'yy') DESC;











/*
���� 3.
�޿��� 5000 �̻�(WHERE �Ϲ�����)�� ������� �μ��� ��� �޿��� ����ϼ���. 
�� �μ� ��� �޿��� 7000�̻�(GROUP �׷�ȭ����)�� �μ��� ����ϼ���.
*/


--���� �ۼ�
SELECT department_id, salary
FROM employees
WHERE salary >= 5000
HAVING
    AVG (salary) >= 7000
GROUP BY department_id, salary    
ORDER BY salary DESC;


    
    

/*
���� 4.
��� ���̺��� commission_pct(Ŀ�̼�) �÷��� null�� �ƴ� �������
department_id(�μ���) salary(����)�� ���, �հ�, count�� ���մϴ�.
���� 1) ������ ����� Ŀ�̼��� �����Ų �����Դϴ�.
���� 2) ����� �Ҽ� 2° �ڸ����� ���� �ϼ���.
*/


--���� �ۼ� 2��
SELECT
    department_id,
    TRUNC(AVG(salary + salary*commission_pct), 2),
    SUM(salary + salary*commission_pct)
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id;





--���� �ۼ� 1��
SELECT TRUNC(salary), COUNT (department_id)
WHERE commission_pct IS NOT NULL
FROM employees
HAVING 
    AVG (salary) >= 1
    SUM (salary) >= 1
    COUNT(department_id) >= 5
GROUP BY department_id, salary;



--�ؼ�
SELECT
    department_id,
    TRUNC(AVG(salary + salary*commission_pct), 2) AS avg_salary,
    SUM(salary + salary*commission_pct) AS sum,
    COUNT(*) AS count
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id;


