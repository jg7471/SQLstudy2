/*
# �����̶�?
- ���� �ٸ� ���̺� ���� ������ ���谡 �����Ͽ�
 1�� �̻��� ���̺��� �����͸� ��ȸ�ϱ� ���ؼ� ����մϴ�.
- SELECT �÷�����Ʈ FROM ���δ���� �Ǵ� ���̺� (1�� �̻�)
  WHERE ���� ���� (����Ŭ ���� ����)
*/

-- employees ���̺��� �μ� id�� ��ġ�ϴ� department ���̺��� �μ� id�� ã�Ƽ�
-- SELECT ���Ͽ� �ִ� �÷����� ����ϴ� ������

--ORACLE�� JOIN
SELECT
    e.first_name,
    d.department_name --�ܺΰ�
FROM employees e, departments d
WHERE e.department_id = d.department_id; --�Ϲ� �����̶� ���� �����



--ANSI�� JOIN : ��� ����
SELECT
    e.first_name, -- first_name ����� ����(���� �Ӽ�)
    d.department_name,
    d.department_id -- e, d ���� ������ ����
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;
/*
������ ���̺� ���������� �����ϴ� �÷��� ��쿡��
���̺� �̸��� �����ص� �����մϴ�. �׷���, �ؼ��� ��Ȯ���� ����
���̺� �̸��� �ۼ��ϼż� �Ҽ��� ǥ���� �ִ� ���� �ٶ����մϴ�.
���̺� �̸��� �ʹ� �� �ÿ��� ALIAS�� �ۼ��Ͽ� Ī�մϴ�.
�� ���̺� ��� ������ �ִ� �÷��� ��� �ݵ�� ����� �ּž� �մϴ�.
*/

--3���� ���̺��� �̿��� ���� ����(INNER JOIN)
--��������: ���� ���ǿ� ��ġ�ϴ� �ุ ��ȯ�ϴ� ����
--���� ���ǿ� ��ġ���� �ʴ� �����ʹ� ��ȸ ��󿡼� ����
SELECT
    e.first_name, e.last_name, e.department_id, e.job_id,
    d.department_id,
    j.job_title
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id --department_id ��ġ���� ���� ������(null) ���ܽ� �� ������ : ���� join
AND e.job_id = j.job_id; --���� join ���� ���x



SELECT
    e.first_name, e.last_name, e.department_id,
    d.department_id,
    j.job_title,
    loc.city
FROM
    employees e,
    departments d,
    jobs j,
    locations loc
WHERE e.department_id = d.department_id
    AND e.job_id = j.job_id
    AND d.location_id = loc.location_id
    AND loc.state_province = 'California'; --oracle�� �Ϲ� ������ ���� ���� ���Ŀ� �ۼ��� ��.

--�ܺ� join (+)
/*
��ȣ ���̺��� ��ġ�Ǵ� ������ ����Ǵ� ���� ���ΰ��� �ٸ���
��� �� ���̺� ���� ���� ������ �ش� row���� ��ȸ �����
��� ���ԵǴ� ������ ���� : �Խ��ǿ� �ۼ� 0 ���� ��ȸ X
*/

SELECT
    e.first_name,
    d.department_name,
    loc.city
FROM employees e, departments d, locations loc --e ����, d �پ����� ��
WHERE e.department_id = d.department_id(+) --Kimberely ����(department_id = null) : ���� join���� ������
AND d.location_id = loc.location_id(+); --�ܺ� join �����ϰ� ������ (+) �߰��ؾ��� : ����join >> �ܺ�join �켱

/*
employees ���̺��� �����ϰ�, departments ���̺��� �������� �ʾƵ�
(+)�� ���� ���� ���̺��� �������� �Ͽ� departments ���̺��� ���ο�
�����϶�� �ǹ̸� �ο��ϱ� ���� ��ȣ�� ���Դϴ�.
�ܺ������� ����ߴ���, ���Ŀ� ���� ������ ���ȭ��
���������� �켱������ �ν��մϴ�.
*/


--�ܺ� ���� ���� �� ��� ���ǿ� (+)�� �ٿ��� �ϸ�
--�Ϲ� ���ǿ��� (+)�� ������ ������ �����Ͱ� �����Ǵ� ������ �߻�
SELECT
    e.employee_id, e.first_name,
    jh.start_date, jh.end_date, jh.job_id    
FROM employees e, job_history jh
WHERE e.employee_id = jh.employee_id(+) --e ���� jh ���� : �ܺ�����
AND jh.department_id(+) = 80; --�ܺ� ���νÿ� �Ϲ����ǿ��� (+) �ٿ�����




