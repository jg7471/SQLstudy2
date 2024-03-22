SET SERVEROUTPUT ON;


--익명 블록 설정
DECLARE --변수를 선언하는 구간(선언부)
    emp_num NUMBER; --변수 선언
BEGIN --코드를 실행하는 구간(실행부)
    emp_num := 10; --대입 연산자
    DBMS_OUTPUT.put_line('Hello pl/sql!');
END;




DECLARE
    v_emp_name VARCHAR2(50);
    v_dep_name departments.department_name%TYPE;

BEGIN

    SELECT
        e.first_name,
        d.department_name
    
    INTO
        v_emp_name, v_dep_name --조회 결과를 변수에 대입
        
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    WHERE e.employee_id = 103;

    dbms_output.put_line(v_emp_name || '-' || v_dep_name);    

END; 




<<<<<<< HEAD
BEGIN
    dbms_output.put_line('트리거 실행!');
    v_total := :NEW.total; -- 주문 수량 얻어옴 5개 //--before트리거에서 사용 0) 20개 주문 들어옴
    v_product_no := :NEW.product_no; --주문 상품의 번호를 얻어옴 1번 //1.5) 확인

    --기존 데이터에서 조회하기
    SELECT 
        total --재고수량 파악
    INTO v_product_total --2)삽입 재고12개
    FROM product
    WHERE product_no = v_product_no; --1)상품 번호를 가지고 재고 수량조회
    
    IF v_product_total <= 0 THEN
        RAISE zero_total_exception;
    
    
    ELSIF v_total > v_product_total THEN
        RAISE quantity_shortage_exception;
    END IF;
        
    UPDATE product SET total = total - v_total
    WHERE product_no = v_product_no;
    
        EXCEPTION
        WHEN quantity_shortage_exception THEN

        RAISE_APPLICATION_ERROR(-20001, '주문하신 수량보다 재고가 적어서 주문 할 수 없습니다'); --고의 에러 발생문(20001 커스텀임)
        
        WHEN zero_total_exception THEN
        RAISE_APPLICATION_ERROR(-20001, '주문하신 재고가 없어서 주문 할 수 없습니다'); --고의 에러 발생문

END;




=======


DECLARE/IS --<procedure>
    v_max_empno employees.employee_id%TYPE;
    
BEGIN
    SELECT
        MAX(employee_id)
    INTO
        v_max_empno
    FROM employees;
    WHERE
    
    INSERT INTO emps
        (employee_id, last_name, email, hire_date, job_id)
    VALUES
        (v_max_empno + 1, 'steven', 'jobs', sysdate, 'CEO');
    IF - ELSIF - END
END



IF THEN
ELSIF
THEN
ELSE
ELSIF
END IF

CASE
WHEN THEN
ELSE
END CASE


DECLARE
    v_count NUMBER := 1;
WHILE '조건'/FOR i IN 1..9
LOOP
v_count := v_count +1; -- ++임
CONTINUE WHEN MOD(i, 2) = 0;

END LOOP



INSERT INTO board
        VALUES(b_seq.NEXTVAL, 'test'||v_num, 'title'||v_num); --시퀸스 삽입


CREATE PROCEDURE 함수명 (매개변수 IN OUT IN AND OUT)
CREATE OR REPLACE PROCEDURE 함수명 (매개변수)
EXEC () 실행
dbms_output.put_line


ALTER TABLE depts ADD CONSTRAINT depts_deptno_pk PRIMARY KEY(department_id); --테이블 수정 : 제약조건 변경@ 속성변경
>>>>>>> 6e8d7447f5a661392580a0948efdd4b5526b15bb
