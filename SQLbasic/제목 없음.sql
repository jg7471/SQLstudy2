

SELECT * FROM (
SELECT ROWNUM rn, tb.* FROM (
SELECT first_name
FROM employees
ORDER BY first_name DESC
)tb
)
WHERE rn > 40 AND rn < 50;


SELECT e.employee_id, (
    SELECT d.department_name
    FROM departments d
    WHERE d.department_id = e.department_id
    )tb
FROM employees e;


SELECT tb.* FROM(
    SELECT ROWNUM AS rn, tb.*
    FROM(
        SELECT tb.*
            FROM (
                SELECT e.employee_id, e.first_name, e.phone_number, e.hire_date
                FROM employees e LEFT JOIN departments d
                ON e.department_id = d.department_id
            )tb
            ORDER BY hire_date DESC
     )
);


SELECT department_name, tb.*
FROM 
    (
        SELECT last_name, job_id, department_id
        FROM employees
        WHERE job_id = 'SA_MAN'
    ) tb

JOIN departments d
ON d.department_id = tb.department_id;



SELECT d.department_id, d.department_name, d.manager_id,(
    SELECT COUNT(*)
    FROM employees e
    WHERE d.department_id = e.department_id
    ) tb
FROM departments d
WHERE d.department_id IS NOT NULL
ORDER BY tb DESC;


SELECT
    d.*
    NVL(tb.reslut,0)
    loc.street_address, loc.postal_code
FROM departmnets d

JOIN locations loc
ON d.location_id = loc.location_id

LEFT JOIN employees e
WHERE
    (
        SELECT
        AVG(salary) as result
        
        FROM employees
        GROUP BY department_id
    )tb
ON d.department_id = e.employee_id



