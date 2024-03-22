/*
# �������� 
: SQL ���� �ȿ� �Ǵٸ� SQL�� �����ϴ� ���.
 ���� ���� ���Ǹ� ���ÿ� ó���� �� �ֽ��ϴ�.
 WHERE, SELECT, FROM ���� �ۼ��� �����մϴ�.

- ���������� ������� () �ȿ� �����.
 ������������ �������� 1�� ���Ͽ��� �մϴ�.
- �������� ������ ���� ����� �ϳ� �ݵ�� ���� �մϴ�.
- �ؼ��� ���� ���������� ���� ���� �ؼ��ϸ� �˴ϴ�.
*/

--�̸��� 'Nancy'�� ������� �޿��� ���� ��� ���ϱ�
SELECT salary FROM employees
WHERE first_name = 'Nancy';


SELECT first_name, salary FROM employees
WHERE salary > 12008;

-- ���������� Ȱ���� ����
SELECT first_name, salary FROM employees
WHERE salary > (SELECT salary FROM employees
                WHERE first_name = 'Nancy');

--employee_id�� 103���� ����� job_id�� ������ job_id�� ���� ����� ��ȸ
SELECT * FROM employees
WHERE job_id = (SELECT job_id FROM employees
                WHERE employee_id = 103);

--SQL <> JAVA !=
--���� ������ ���������� �����ϴ� ���� ���� ���� ������ ������(< <= <> => >)�� ����� �� X
--���� �� ������: �ַ� �� ������(=, >, <, <=, >=, <>)�� ����ϴ� ��� �ϳ��� ��� ��ȯ
--�̷� ��쿡�� ���� �� �����ڸ� ����ؾ� ��
SELECT * FROM employees
WHERE job_id = (SELECT job_id FROM employees
                WHERE last_name = 'King'); --���� : �������� ��� : last_name King 2��
                                           --������� job_id(1��) = ��������(2��) : ��� 1���̿��� �Ѵ� -> ������ �����ȣ ���



--���� �� ������(IN, ANY, ALL, EXISTS)



--IN : ��ȸ�� ����� � ���� �������� ��
SELECT * FROM employees
WHERE job_id IN (SELECT job_id FROM employees
                WHERE last_name = 'King'); --KING�̶�� JOB_ID

--first_name�� David�� ������� �޿��� ���� �޿��� �޴� ������� ��ȸ
SELECT * FROM employees
WHERE salary IN (SELECT salary FROM employees
                WHERE first_name = 'David'); --first_name�� David�� ������� �޿��� ���� �޿��� �޴� �����
                                             -- 4800 6800 9500 : �� �� �ϳ� ���� ��
                
--ANY, SOME(����Ŭ ���� ANY�� ������ ���) : ���� ���������� ���� ���ϵ� ������ ���� ���ؼ�
--�ϳ��� �����ϸ� ��ȸ ��� ���Ե�
--David��� ����� ���� ���ε�, �� �߿� ���� ���� �޿��� �޴� David���� �޿��� ���� ����� ��ȸ
SELECT * FROM employees
WHERE salary > ANY (SELECT salary FROM employees
                WHERE first_name = 'David'); --�������� ���� ���� ������� Ŀ����
                                             -- 4800 6800 9500 : ���� ���� 4800 �̻� 
                
--ALL : ���� ���������� ���� ���ϵ� ������ ���� ��� ���ؼ�
--���� �� ��ġ�ؾ� ��ȸ��� ���Ե�
--David��� ����� ���� ���ε�, �� �߿� ���� ���� �޿��� �޴� David���� �޿��� ���� ����� ��ȸ
SELECT * FROM employees
WHERE salary > ALL (SELECT salary FROM employees
                WHERE first_name = 'David');-- 4800 6800 9500 : ���� ū 9500 �̻� 
                
-- EXISTS : ���������� �ϳ� �̻��� ���� ��ȯ�ϸ� ������ ����
-- job_history�� �����ϴ� ������ employees���� �����Ѵٸ� ��ȸ��� ����
-- �������� ���� jh�� �ִ� id�� e�� �ִ� id�� ��ġ�� ������ 1�̶�� ���� ��ȸ
-- EXISTS �����ڰ� 1�� ��ȸ�� �� ��, �����Ͱ� �����Ѵٴ� ���� �Ǵ��Ͽ� employees���� �ش� ����� ��� ������ ��ȸ
SELECT * FROM employees e
WHERE EXISTS (SELECT 1 FROM job_history jh
             WHERE e.employee_id = jh.employee_id); --1 �÷��� ���翩�� Ȯ�� : *(�ϰų�) �� �� (true/flase Ȯ�θ�)
             --��ȸ�� �Ǹ� ��ü ��� �����ϰڴ�
             
SELECT * FROM employees e
WHERE EXISTS (SELECT 1 FROM departments d
              WHERE e.department_id = d.department_id);
              --oracle true - false ���� WHERE 1 = 2


SELECT * FROM employees e
WHERE EXISTS (SELECT 1 FROM departments d
             WHERE department_id = 90);


--------------------------------------------------------------------------------
--SELECT ���� �������� ���̱�
--��Į�� �������� ��� Ī�մϴ�
--��Į�� �������� : ���� ����� ���� ���� ��ȯ�ϴ� ��������. �ַ� SELECT ���̳�, WHERE ������ ����

SELECT
    e.first_name,
    d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY e.first_name;



SELECT
    e.first_name,
    (
        --��� first_name�� �� ���� �ݺ��ϰڴ� : SELECT�� �������� ��κ� left join ���
        SELECT
            department_name
        FROM departments d
        WHERE d.department_id = e.department_id
    ) AS department_name
FROM employees e
ORDER BY e.first_name;

--�� �μ��� �Ŵ��� �̸� ��ȸ
SELECT --���1 : ��Ʈ ��ħ
    d.*,
    e.first_name AS manager_name
FROM departments d
LEFT JOIN employees e
ON d.manager_id = e.employee_id --d�� �Ŵ����� ���̵� e�� �Ŵ��� ���̵�� ���ٸ�
ORDER BY d.manager_id; --LEFT JOIN
--departments d �� ���� : LEFT JOIN

SELECT --���2 :�� �ึ�� �������� ���� ����
    d.*,
    (
    SELECT
        first_name
    FROM employees e
    WHERE e.employee_id = d.manager_id @@@
    )AS manager_name

FROM departments d
ORDER BY d.manager_id;


/*
- ��Į�� ���������� ���κ��� ���� ��� : ����(���)
: �Լ�ó�� �� ���ڵ�� ��Ȯ�� <�ϳ��� ����>�� ������ ��.

- ������ ��Į�� ������������ ���� ��� : ����
: ��ȸ�� �÷��̳� �����Ͱ� ��뷮�� ���, �ش� �����Ͱ�
����, ���� ���� ����� ��� (sql �������� ������ �� �� �پ�ϴ�.)
*/


--�� �μ��� ��� �� ��(��Į��)



--���� �ۼ�
SELECT
    d.*,
    (
    SELECT
        first_name
    FROM employees e
    WHERE e.department_id = d.department_id
    )
FROM departments d;


--�ؼ�
SELECT
    d.*,
    (
    SELECT
        COUNT(*)
        FROM employees s
        WHERE e.department_id = d.department_id --d�� �����͸� e�� ��ġ ��Ŵ
        GROUP BY department_id
    ) AS �����
FROM departments d; --���ο��� ������ ����


SELECT
    d.department_name AS �μ���,
    COUNT(e.employee_id) AS �����
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.departmnet_id
GROUP BY e.department_id, d.department_name
ORDER BY ����� DESC;


--------------------------------------------------------------------------------
--from�� �������� : �ζ��� �� : ��ȸ ������ ������ ���̺�

-- �ζ��� �� (FROM ������ ���������� ���� ��.)
-- Ư�� ���̺� ��ü�� �ƴ� SELECT�� ���� �Ϻ� �����͸� ��ȸ�� ���� ���� ���̺�� ����ϰ� ���� ��. 
-- ������ ���س��� ��ȸ �ڷḦ ������ �����ؼ� ������ ���� ���.


-- salary�� ������ �����ϸ鼭 �ٷ� ROWNUM�� ���̸�
-- ROWNUM�� ������ ���� �ʴ� ��Ȳ�� �߻��մϴ�.
-- ����: ROWNUM�� ���� �ٰ� ������ ����Ǳ� ����. ORDER BY�� �׻� �������� ����.
-- �ذ�: ������ �̸� ����� �ڷῡ ROWNUM�� �ٿ��� �ٽ� ��ȸ�ϴ� ���� ���� �� ���ƿ�.

--SQL ������� FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
SELECT
    employee_id, first_name, salary, ROWNUM AS rn
FROM employees
ORDER BY salary DESC;


-- ROWNUM�� ���̰� ���� ������ �����ؼ� ��ȸ�Ϸ��� �ϴµ�,
-- ���� ������ �Ұ����ϰ�, ������ �� ���� ������ �߻��ϴ���.
-- ����: WHERE������ ���� �����ϰ� ���� ROWNUM�� SELECT �Ǳ� ������.
-- �ذ�: ROWNUM���� �ٿ� ���� �ٽ� �� �� �ڷḦ SELECT �ؼ� ������ �����ؾ� �ǰڱ���.

SELECT
    ROWNUM AS rn, tbl.*
    FROM
    (
    SELECT
        employee_id, first_name, salary
    FROM employees
    ORDER BY salary DESC
    ) tbl -- ���̺� ��Ī AS �� �ʿ�
WHERE rn > 10 AND rn <= 20; --between ����ص� ʦ : �����߻�

--SQL ������� FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
--���ʺ��� Ȯ�� : �μ���?

/*
���� ���� SELECT ������ �ʿ��� ���̺� ����(�ζ��� ��)�� ����.
�ٱ��� SELECT ������ ROWNUM�� �ٿ��� �ٽ� ��ȸ
���� �ٱ��� SELECT �������� �̹� �پ��ִ� ROWNUM�� ������ �����ؼ� ��ȸ.

** SQL�� ���� ����
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
*/

SELECT * --tb2.rn, tb2.salary --����Ŭ
    FROM
    (
    SELECT
        ROWNUM AS rn, tbl.*
        FROM
        (
        SELECT
            employee_id, first_name, salary
        FROM employees
        ORDER BY salary DESC
        ) tbl
    )--tb2
WHERE rn > 10 AND rn < 20;
--�Խ��� ����¡ �˰��� : 

--ANSI ���ι��
SELECT --@@@
    e.employee_id, e.salary,
    avg_salaries.average_salary
FROM employees e JOIN
(SELECT
    department_id,
    AVG(salary) AS average_salary
FROM
    employees
GROUP BY department_id) avg_salaries --���̺� ��Ī AS �� �ʿ�
ON e.department_id = avg_salaries.department_id;






