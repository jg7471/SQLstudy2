/*
���� 1.
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� // ���� ������� �����͸� ��� �ϼ��� 
(AVG(�÷�) ���)
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
-EMPLOYEES ���̺��� job_id�� IT_PROG�� ������� ��ձ޿����� ���� ������� 
�����͸� ����ϼ���
*/

--FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY


--�ؼ�
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT COUNT(*)
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees WHERE job_id = 'IT_PROG');





--���� �ۼ�
SELECT e.*

FROM employees e JOIN
(SELECT

FROM
    employees
ON;





--** SQL�� ���� ����
--FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY

/*
���� 2.
-DEPARTMENTS���̺��� manager_id�� 100�� �μ��� �����ִ� �������
��� ������ ����ϼ���.
*/

SELECT *
FROM employees
WHERE department_id = ( SELECT department_id FROM departments WHERE manager_id = 100);











--�ؼ�
SELECT * FROM employees
WHERE department_id = (SELECT department_id FROM departments
                        WHERE manager_id = 100); --SELECT department_id �ܺ�Ű

--���� �ۼ�
SELECT *
    FROM JOIN 
 9000   ( SELECT employees e 
    FROM
        departments d
    WHERE manager_id = 100
    )
ON e.manager_id = d.manager_id;

/*
���� 3.
-EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� 
����ϼ���
-EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
*/

SELECT *
FROM employees
WHERE manager_id IN ( SELECT manager_id FROM employees WHERE first_name = 'James');








--�ؼ�
SELECT * FROM employees
WHERE manager_id > (SELECT manager_id FROM employees
                    WHERE first_name = 'Pat');

SELECT * FROM employees
WHERE manager_id IN (SELECT manager_id FROM employees
                    WHERE first_name = 'James');


/*
���� 4.
-EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� 
�� ��ȣ, �̸��� ����ϼ���
*/
--FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY

--����
SELECT *
    FROM(
        SELECT ROWNUM AS RN, tbl.first_name
        FROM
            (
            SELECT * FROM employees
            ORDER BY first_name DESC
            ) tbl
        )
WHERE 41 > RN AND RN < 50;



--�ؼ�
SELECT * FROM
    (
    SELECT ROWNUM AS rn, tbl.first_name
        FROM
        (
        --��� ���� �������� : ���� Ȯ��
        SELECT * FROM employees
        ORDER BY first_name DESC
        ) tbl --��Ī --1�� �̸� ����
    )   --2�� RN(ROWNUM : ��ŷ)�ֱ�
WHERE rn BETWEEN 41 AND 50; --3�� �ڸ���




--���� �ۼ�
SELECT
    ROWNUM AS rn, tbl.*
    FROM
    (
    SELECT *
    FROM employees
    ORDER BY first_name DESC
    ) tbl
WHERE rn > 40 AND rn <= 50;

/*
���� 5.
-EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� 
�� ��ȣ, ���id, �̸�, ��ȭ��ȣ, �Ի����� ����ϼ���.
*/

SELECT * FROM 
    (
    SELECT ROWNUM AS RN, tbl.employee_id, tbl.first_name, tbl.phone_number, tbl.hire_date
    FROM
        (
        SELECT * FROM employees
        ORDER BY hire_date ASC
        )tbl
    )
WHERE RN > 30 AND RN <= 40;






--�ؼ�
SELECT * FROM
    (
    SELECT ROWNUM AS rn, tbl.employee_id, tbl.first_name,
    tbl.phone_number, tbl.hire_date
        FROM
        (--���� ���̺�
        SELECT * FROM employees
        ORDER BY hire_date ASC
        ) tbl --��Ī
    )   
WHERE rn BETWEEN 31 AND 40;


--���� �ۼ�
SELECT
    ROWNUM AS rn, tbl.*
    FROM
    (
    SELECT
        *
    FROM employees
    ORDER BY hire_date
    ) tbl
WHERE rn > 31 AND rn <= 40;



/*
���� 6.
employees���̺� departments���̺��� left �����ϼ���
����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
����) �������̵� ���� �������� ����
*/

--�ؼ�
SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name AS full_name,
    e.department_id,
    d.department_name

FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY e.employee_id;



--���� �ۼ�
SELECT e.employee_id, e.first_name || ' ' || e.last_name, e.department_id
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY e.department_id;



/*
���� 7.
���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
employees���̺� departments���̺��� left �����ϼ���
����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
����) �������̵� ���� �������� ����
*/

--����
SELECT e.employee_id, e.first_name, e.department_id,
    (
    SELECT d.department_name 
    FROM departments d
    WHERE e.department_id = d.department_id
    )AS departname
    FROM employees e
ORDER BY employee_id ASC;



--�ؼ�
SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name AS full_name,
    e.department_id, --SELECT�� �߰�
    (SELECT department_name --�μ���
    FROM departments d
    WHERE d.department_id = e.department_id)AS dept_name --WHERE���� JOIN
FROM employees e
ORDER BY e.employee_id;




/*
���� 8.
departments���̺� locations���̺��� left �����ϼ���
����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
����) �μ����̵� ���� �������� ����
*/

--���� �ۼ�
SELECT *
FROM departments d
LEFT JOIN locations l
ON d.location_id = l.location_id
ORDER BY d.department_id ASC;


--�ؼ�
SELECT
    d.department_id, d.department_name, d.manager_id, d.location_id,
    loc.street_address, loc.postal_code, loc.city
FROM departments d
LEFT JOIN locations loc
ON d.location_id = loc.location_id
ORDER BY department_id;


/*
���� 9.
���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
departments���̺� locations���̺��� �����ϼ���
����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
����) �μ����̵� ���� �������� ����
*/

--����
SELECT d.department_id, d.department_name, d.location_id, --��ǥ ����
    (
    SELECT loc.street_address
    FROM locations loc
    WHERE d.location_id = loc.location_id
    ), --��ǥ ����
    (
    SELECT loc.postal_code
    FROM locations loc
    WHERE d.location_id = loc.location_id
    ),
    (
    SELECT loc.city
    FROM locations loc
    WHERE d.location_id = loc.location_id
    )
FROM departments d
ORDER BY d.department_id ASC;

--�ؼ�
SELECT
    d.department_id, d.department_name, d.manager_id, d.location_id,
    (SELECT loc.street_address --�÷� ���� �� ���� JOIN�� �� ����
    FROM locations loc
    WHERE d.location_id = loc.location_id) AS street_address,
    (SELECT loc.postal_code
    FROM locations loc
    WHERE d.location_id = loc.location_id) AS postal_code,
    (SELECT loc.city
    FROM locations loc
    WHERE d.location_id = loc.location_id) AS city
FROM departments d
ORDER BY d.department_id;

--���� �ۼ�
SELECT * FROM
    (
    SELECT department_id
    FROM departments d
    WHERE d.location_id = l.location_id
    );

/*
���� 10.
locations���̺� countries ���̺��� left �����ϼ���
����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
����) country_name���� �������� ����
*/
--���� �ۼ�
SELECT *
FROM locations l
LEFT JOIN countries c
ON l.country_id = c.country_id
ORDER BY country_name ASC;


--�ؼ�
SELECT
    loc.location_id, loc.street_address, loc.city,
    c.country_id, c.country_name
FROM locations loc
LEFT JOIN countries c
ON loc.country_id = c.country_id
ORDER BY c.country_id;



/*
���� 11.
���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
locations���̺� countries ���̺��� �����ϼ���
����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
����) country_name���� �������� ����
*/

--����
SELECT
    l.location_id, l.street_address, l.city, l.country_id,
    (
    SELECT c.country_name
    FROM countries c
    WHERE l.country_id = c.country_id
    )
FROM locations l
ORDER BY l.country_id; --�ٱ��̸� �ٱ��� ����ض�





--���� �ۼ�
SELECT *
    (
    SELECT country_name
    FROM countries c
    WHERE c.country_id = l.country_id) AS tbl
FROM locations l;

--�ؼ�

SELECT
    loc.location_id, loc.street_address, loc.city, loc.country_id,  --�ִ��� ��Į�� �� ����ϰ� �Ϸ���
    (SELECT country_name 
    FROM countries c
    WHERE loc.country_id = c.country_id) AS country_name
FROM locations loc
ORDER BY loc.country_id;

/*
���� 12. 
employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 
11-20��° �����͸� ����մϴ�.
����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, 
�μ����̵�, �μ��̸� �� ����մϴ�.
����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.
*/

--����
SELECT * FROM(
    SELECT ROWNUM AS rn, tbl.*
        FROM(
        SELECT e.employee_id, e.first_name, e.phone_number, e.hire_date
        FROM employees e LEFT JOIN departments d
        ON e.employee_id = d.department_id
        ORDER BY hire_date ASC 
        )tbl
    )
WHERE rn > 11 AND rn < 20;


--���� �ۼ�
SELECT *
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE ;


--�ؼ�
SELECT * FROM
    (--ROWNUM ���� ���� ����
    SELECT ROWNUM AS rn, tbl.* --�ȿ��� SELECT �س��� tbl.*�ϸ� �� --2�� ROWNUM rn ����
        FROM 
        (
        SELECT
            e.employee_id, e.first_name, e.phone_number, e.hire_date,
            d.department_id, d.department_name
        FROM employees e LEFT JOIN departments d
        ON e.department_id = d.department_id
        ORDER BY hire_date --1�� ORDER ���� + with LEFT JOIN
        ) tbl
    )
WHERE rn > 10 AND rn <= 20; --3�� rn WHERE ���� 




/*
���� 13. 
--EMPLOYEES �� DEPARTMENTS ���̺��� JOB_ID�� SA_MAN ����� ������ LAST_NAME, JOB_ID, 
DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���.
*/

--�ؼ�
SELECT
    tbl.*, d.department_name
FROM 
    (--1�� ������
    SELECT
        last_name, job_id, department_id
    FROM employees
    WHERE job_id = 'SA_MAN'
    ) tbl
JOIN departments d --2�� JOIN
ON tbl.department_id = d.department_id; --�湮��

--���� �ۼ�
SELECT e.last_name, e.job_id, d.department_id, d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE job_id = 'SA_MAN';




/*
���� 14
-- DEPARTMENTS ���̺��� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
-- �ο��� ���� �������� �����ϼ���.
-- ����� ���� �μ��� ������� �ʽ��ϴ�.
*/







--�ؼ� ���1 :
SELECT
    d.department_id, d.department_name, d.manager_id,
    a.total
FROM departments d
JOIN
    (
    SELECT
        department_id, COUNT(*) AS total
    FROM employees
    GROUP BY department_id
    ) a
ON d.department_id = a.department_id
ORDER BY a.total DESC;

--�ؼ�2

SELECT
    d.department_id, d.department_name, d.manager_id,
    (
        SELECT
            COUNT(*) --1�� : employees���� �ο��� ī��Ʈ
        FROM employees e
        WHERE e.department_id = d.department_id
    ) AS total
FROM departments d
WHERE d.manager_id IS NOT NULL --2�� �����̸Ӹ�Ű�� NULL �μ� Ȯ��
ORDER BY total DESC; --2��

--�ؼ� 3 �߰�����(EXISTS) �߰�

SELECT
    d.department_id, d.department_name, d.manager_id,
    (
        SELECT
            COUNT(*)
        FROM employees e
        WHERE e.department_id = d.department_id
    ) AS total
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
)
ORDER BY total DESC;

DELETE FROM employees
WHERE employee_id = 207;








--���� �ۼ�
SELECT tbl.* , COUNT(department_id) AS members
FROM (
    SELECT tbl.* 
        FROM(
            SELECT department_id, department_name, manager_id
            FROM departments
            WHERE manager_id IS NOT NULL
        )tbl
    GROUP BY department_id;
    )
ORDER BY COUNT(members) DESC;



/*
���� 15
--�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���.
--�μ��� ����� ������ 0���� ����ϼ���.
*/


--�ؼ� ���1 : ��ɷ�
SELECT
    d.*,
    loc.street_address, loc.postal_code,
    NVL(tbl.result, 0) AS �μ�����ձ޿� --NVL(�÷�(if nulll), ��ȯ�� Ÿ�ٰ�)
FROM departments d

JOIN locations loc
ON d.location_id = loc.location_id


LEFT JOIN ( --��� �޿��� � ���ϱ�
    SELECT --�����
        department_id,
        TRUNC(AVG(salary), 0) AS result
    FROM employees
    GROUP BY department_id
) tbl
ON d.department_id = tbl.department_id


ORDER BY tbl.result;




--�ؼ� ���2
SELECT
    d.*,
    loc.street_address, loc.postal_code,
    NVL(
    (
        SELECT
            TRUNC(AVG(salary), 0)
        FROM employees e
        WHERE e.department_id = d.department_id
    ),
    0) AS �μ�����ձ޿�

FROM departments d
JOIN locations loc
ON d.location_id = loc.location_id
ORDER BY �μ�����ձ޿� DESC;











--���� �ۼ�
SELECT
d.*, loc.street_address, AVG(d.salary)



SELECT department_id, --�����
       TRUNC(AVG(salary), 0) AS result
FROM departments d
GROUP BY department_id


    LEFT JOIN
    empolyees e 
    ON
    e.department_id = d.department_id
    
    LEFT JOIN
    locations loc
    ON
    loc.location_id = d.location_id

WHERE salary = AVG(d.salary);

/*
���� 16
-���� 15 ����� ���� DEPARTMENT_ID�������� �������� �����ؼ� 
ROWNUM�� �ٿ� 1-10 ������ ������ ����ϼ���.
*/

--�ؼ� :���1
SELECT * FROM
    (
    SELECT ROWNUM AS rn, tbl2.*
        FROM
        (
        SELECT
            d.*,
            loc.street_address, loc.postal_code,
            NVL(tbl.result, 0) AS �μ�����ձ޿� --null�� ��, ��� 0ǥ��
        FROM departments d
        JOIN locations loc
        ON d.location_id = loc.location_id
        LEFT JOIN ( --��� �޿��� � ���ϱ�
            SELECT 
                department_id, --�����
                TRUNC(AVG(salary), 0) AS result
            FROM employees
            GROUP BY department_id
        ) tbl
        ON d.department_id = tbl.department_id
        ORDER BY d.department_id DESC
        ) tbl2
    )
WHERE rn > 10 AND rn <= 20;

--���� �ۼ�
SELECT *
    FROM(
        SELECT ROWNUM AS RN, tbl.*
        FROM
            (

            SELECT
            d.*, loc.street_address, AVG(d.salary)
            
            FROM 
            departments d
            
            LEFT JOIN
            empolyees e 
            ON
            e.department_id = d.department_id
            
            LEFT JOIN
            locations loc
            ON
            loc.location_id = d.location_id
            
            WHERE salary = AVG(d.salary)

            ) tbl
        )
WHERE 0 > RN AND RN < 11;



    
    
    
    
    

    
    
    
    
    
    
