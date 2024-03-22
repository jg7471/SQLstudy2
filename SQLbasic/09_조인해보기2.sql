
SELECT * FROM info;
SELECT * FROM auth;

--�̳� (����) ���� : ���� ���� �´� �ֵ鸸 ��µ�
SELECT *
FROM info i --���̺� ����
INNER JOIN auth a
ON i.auth_id = a.auth_id; --���� ����

-- ORACLE ����(����Ŭ ���� �����̶� �� �̻� �ۼ����� �ʰڽ��ϴ�)
SELECT *
FROM info i, auth a
WHERE i.auth_id = a.auth_id;



-- auth_id �÷��� �׳� ���� ��ȣ�ϴ� ��� ��ϴ�.
-- �� ������ ���ʿ� ��� �����ϴ� �÷��̴ϱ�
--�÷��� ���̺� �̸��� ���̴���, ��Ī�� ���ż� Ȯ���ϰ� �����ϼ���
SELECT
    a.auth_id, i.title, i.content, a.name -- auth_id �ߺ��̶� �Ҽ� ��Ȯ��, �ظ��ؼ� �ٸ� �͵� �Ҽ� ����
FROM info i
JOIN auth a --(INNER) JOIN ���� ���� : default : inner join
ON i.auth_id = a.auth_id;


--�ʿ��� �����͸� ��ȸ�ϰڴ� (�Ϲ�����) ��� �Ѵٸ�
--WHERE ������ ���� ������ ��
--JOIN �� ON
SELECT
    a.auth_id, i.title, i.content, a.name
FROM info i
JOIN auth a
ON i.auth_id = a.auth_id
WHERE a.name = '�̼���';


--�ƿ���(�ܺ�) ���� ENSI --���� LEFT (OUTER) JOIN �̶�� �� (INNER) JOIN
SELECT *
FROM info i LEFT OUTER JOIN auth a --info i ����(�� ����) auth a ����(���� ���ɼ�)
ON i.auth_id = a.auth_id;


--����Ŭ �ܺ�����
SELECT *
FROM info i, auth a
WHERE i.auth_id = a.auth_id(+);


--RIGHT �ܺ� ���� (���� left ���) RIGHT (OUTER) JOIN
SELECT *
FROM info i RIGHT OUTER JOIN auth a --auth a ����(�� ����) info i ����(���� ���ɼ�)
ON i.auth_id = a.auth_id;


--FULL ���� : �¿� ���̺� ��� �о�ǥ�� �ϴ� �ܺ� ���� FULL (OUTER) JOIN
SELECT *
FROM info i FULL OUTER JOIN auth a --info i ����(�� ����) auth a ����(���� ���ɼ�)
ON i.auth_id = a.auth_id;

--CROSS JOIN�� JOIN ������ �������� �ʱ� ������
--�ܼ��� ��� �÷��� ���� JOIN�� �����մϴ�
--�����δ� ���� ������� �ʽ��ϴ� : ���迡 ���� ��ó��, SQL D
--�� �÷� �� * �� =

--ANSI ��Ÿ��
SELECT * FROM info
CROSS JOIN auth;

--����Ŭ ��Ÿ��
SELECT * FROM info, auth;

--���� �� ���̺� ���� -> Ű ���� ã�� ������ �����ؼ� ���� �˴ϴ�. @@@@
SELECT *
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN locations loc ON d.location_id = loc.location_id;



/*
- ���̺� ��Ī a, i�� �̿��Ͽ� LEFT OUTER JOIN ���.
- info, auth ���̺� ���
- job �÷��� scientist�� ����� id, title, content, job�� ���.
*/

--�ش�
SELECT *
FROM info i RIGHT OUTER JOIN auth a
ON i.auth_id = a.auth_id;



--���� �ۼ� :  LEFT�� �ۼ��� ��� �� ����
SELECT *
FROM info i LEFT OUTER JOIN auth a
ON i.auth_id = a.auth_id
WHERE a.job = 'scientist';


--���� �����̶� ���� ���̺� ������ ������ ���մϴ�
--���� ���̺� �÷��� ���� ������ �����ϴ� ���� ��Ī���� ������ �� ����մϴ�.
SELECT
    e1.employee_id, e1.first_name, e1.manager_id,
    e2.first_name, e2.employee_id

FROM employees e1
JOIN employees e2
ON e1.manager_id = e2.employee_id
ORDER BY e1.employee_id;
