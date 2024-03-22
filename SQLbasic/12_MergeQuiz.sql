    
   --Merge ����



--1 ���� �ۼ�
INSERT INTO departments (department_id, department_name, manager_id, location_id)
VALUES (280, '����', null, 1800),
       (290, 'ȸ���', null, 1800),
       (300, '����', 301, 1800),
       (310, '�λ�', 302, 1800),
       (320, '����', 303, 1700);
       
SELECT * FROM departments;


--1 �ؼ�
CREATE TABLE depts AS (SELECT * FROM departments);
SELECT * FROM depts;

INSERT INTO depts (department_id, department_name, location_id)
VALUES(280, '����', 1800);

INSERT INTO depts (department_id, department_name, location_id)
VALUES(290, 'ȸ���', 1800);

INSERT INTO depts
VALUES(300, '����', 301, 1800);

INSERT INTO depts
VALUES(310, '�λ�', 302, 1800);      

INSERT INTO depts
VALUES(320, '����', 303, 1700);

SELECT * FROM depts;





--2.1 ���� �ۼ�
UPDATE departments
SET department_name = 'IT bank'
WHERE department_id = 210;

SELECT * FROM departments;

--2.1 �ؼ�
UPDATE depts SET department_name = 'IT_BANK'
WHERE department_name = 'IT Support';




--2.2 ���� �ۼ�
UPDATE depts
SET manager_id = 301
WHERE department_id = 290;
SELECT * FROM departments;

--2.2 �ؼ�
UPDATE depts SET manager_id = 301
WHERE department_id = 290;


--2.3 ���� �ۼ�
UPDATE departments
SET department_name = 'IT Help', manager_id = 303
WHERE department_id = 230;

--2.3 �ؼ�
UPDATE depts 
SET
    department_name = 'IT Help',
    manager_id = 303,
    location_id = 1800
WHERE department_name = 'IT Helpdesk';


--2.4 ���� �ۼ�
UPDATE departments
SET manager_id = 301
WHERE department_id IN ( SELECT department_id = 290, department_id = 300, department_id = 310, department_id = 320
                      FROM departments
                    )

--2.4 �ؼ�
UPDATE depts
SET manager_id = 301
WHERE department_id IN (290, 300, 310, 320);


--3.1 ���� �ۼ�
DELETE FROM departments
WHERE departments_id = 80;
            
--3.1 �ؼ�
DELETE FROM depts WHERE department_id = (SELECT department_id FROM depts
                                        WHERE department_name = '����');


            
--3.2 ���� �ۼ�
DELETE FROM departments
WHERE departments_id = 220;

--3.2 �ؼ�
DELETE FROM depts WHERE department_id = (SELECT department_id FROM depts
                                        WHERE department_name = 'NOC');


--4.1 ���� �ۼ�
DELETE FROM departments
WHERE departments_id > 200;

--4.1 �ؼ�
DELETE FROM depts WHERE department_id > 200;



--4.2 ���� �ۼ�
UPDATE departments
SET manager_id = 100
WHERE manager_id IS NOT NULL;

SELECT * FROM departments;


--4.2 �ؼ�
UPDATE depts
SET manager_id = 100
WHERE manager_id IS NOT NULL;



--4.4 ���� �ۼ�
MERGE INTO depts a --��Ī �ȱ�� �� �ٿ��� ��
    USING
        departments b --���������ε� �� (SELECT * FROM employees)
    ON
        (a.department_id = b.department_id)
WHEN MATCHED THEN
    UPDATE SET
        a.department_id = b.department_id
        a.manager_id = b.manager_id,
        a.location_id = b.location_id,
        
WHEN NOT MATCHED THEN
    INSERT VALUES
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct,
    
    b.manager_id, b.department_id,b.location_id);

SELECT * FROM Depts;


--4.4 �ؼ�
MERGE INTO depts a
    USING departments d
    ON (a.department_id = d.department_id)
WHEN MATCHED THEN
    UPDATE SET
        a.department_name = d.department_name,
        a.manager_id = d.manager_id,
        a.location_id = d.location_id

WHEN NOT MATCHED THEN
    INSERT VALUES
    (d.department_id, d.department_name, d.manager_id, d.location_id);
    
SELECT * FROM depts;



--5.1 ���� �ۼ�
CREATE TABLE jobs_it AS(SELECT * FROM jobs WHERE min_salary > 6000);
SELECT * FROM jobs_it;

--5.1 �ؼ�
CREATE TABLE jobs_it AS
(SELECT * FROM jobs WHERE min_salary > 6000);

SELECT * FROM jobs_it;
SELECT * FROM jobs;
--����

--5.2 ���� �ۼ�
INSERT INTO jobs_it
VALUES('IT_DEV', '����Ƽ������', 6000, 20000)
    ('NET_DEV', '��Ʈ��ũ������', 5000, 20000)
    ('SEC_DEV', '���Ȱ�����', 6000, 90000);

--5.2 �ؼ�
INSERT INTO jobs_it VALUES('IT_DEV', '����Ƽ������', 6000, 20000);
INSERT INTO jobs_it VALUES('NET_DEV', '��Ʈ��ũ������', 5000, 20000);
INSERT INTO jobs_it VALUES('SEC_DEV', '���Ȱ�����', 6000, 19000);



--5.4 ���� �ۼ�
MERGE INTO jobs_it a
    USING
        jobs b(WHERE min_salary > 0)
    ON
        (a.job_id = b.job_id)
WHEN MATCHED THEN
    UPDATE SET
        a.min_salary = b.min_salary
        a.max_salary = b.max_salary
        
WHEN NOT MATCHED THEN
    INSERT VALUES
    (b.job_id, b.job_title);

--5.4 �ؼ�
MERGE INTO jobs_it a
    USING (SELECT * FROM jobs WHERE min_salary > 5000) b
    ON (a.job_id = b.job_id)
WHEN MATCHED THEN
    UPDATE SET
        a.min_salary = b.min_salary,
        a.max_salary = b.max_salary

WHEN NOT MATCHED THEN
    INSERT VALUES
    (b.job_id, b.job_title, b.min_salary, b.max_salary);
        
SELECT * FROM jobs_it;