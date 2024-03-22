-- ���� ������
-- ���� �ٸ� ���� ����� ����� �ϳ��� ����, ��, ���̸� ���� �� �ְ� �� �ִ� ������
-- UNION(������ �ߺ�x), UNION ALL(������ �ߺ� o), INTERSECT(������), MINUS(������)
-- �� �Ʒ� column ������ ������ Ÿ���� ��Ȯ�� ��ġ�ؾ� �մϴ�.




--UNION -> �ߺ� �����͸� ������� ����
SELECT --10��
    employee_id, first_name, hire_date --���̵� ���Ʒ� ���ƾ� ���� ���ƾ���
FROM employees
WHERE hire_date LIKE '04%'
UNION --�ߺ��� ������� �ʴ� ������(Michael ���ߺ�)
SELECT --2��
    employee_id, first_name, hire_date
FROM employees
WHERE department_id = 20;




-- UNION ALL -> �ߺ� ������ ���
SELECT --10��
    employee_id, first_name, hire_date
FROM employees
WHERE hire_date LIKE '04%'
UNION ALL --�ߺ��� ����ϴ� ������(Michael �ߺ�)
SELECT --2��
    employee_id, first_name, hire_date
FROM employees
WHERE department_id = 20;




--INTERSECT ������
SELECT --10��
    employee_id, first_name, hire_date
FROM employees
WHERE hire_date LIKE '04%'
INTERSECT
SELECT --2��
    employee_id, first_name, hire_date
FROM employees
WHERE department_id = 20;




--MINUS
SELECT --10�� --������
    employee_id, first_name, hire_date
FROM employees
WHERE hire_date LIKE '04%'
MINUS --Michael(�ߺ���) ���ܵ�
SELECT --2��
    employee_id, first_name, hire_date
FROM employees
WHERE department_id = 20;



SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20
MINUS
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%';

