/*
프로시저명 divisor_proc
숫자 하나를 전달받아 해당 값의 약수의 개수를 출력하는 프로시저를 선언합니다.
*/

--해설

CREATE OR REPLACE PROCEDURE divisor_proc --중복이면 replace
    (p_num IN NUMBER)
    
IS
    v_count NUMBER := 0;

BEGIN
    FOR i IN 1..p_num
    LOOP
        IF MOD(p_num, i) = 0 THEN
            v_count := v_count + 1;--기본적으로 모든수 1로 나눠지니까
        END IF;
    END LOOP;
    
    dbms_output.put_line('약수의 개수' || v_count || '개');
    
END;

EXEC divisor_proc(72);


--내가 작성
DROP PROCEDURE divisor_proc
CREATE PROCEDURE divisor_proc
    (number1 IN NUMBER)
    
IS
    
    v_total NUMBER := 0;
    v_count NUMBER := 1;

BEGIN

    FOR i IN 2..number1
    LOOP
        FOR j IN 2..number1
        LOOP
            CONTINUE WHEN MOD(number1, i) = 0;
            dbms_output.put_line(number1 || '의 약수???' || i);
            v_count := v_count +1;    
        END LOOP;

        IF MOD(v_count, 2) = 0
           v_count := v_count +1;    
        END LOOP;
END;

EXEC divisor_proc(37);


/*
부서번호, 부서명, 작업 flag(I: insert, U:update, D:delete)을 매개변수로 받아 
depts 테이블에 
각각 INSERT, UPDATE, DELETE 하는 depts_proc 란 이름의 프로시저를 만들어보자.
그리고 정상종료라면 commit, 예외라면 롤백 처리하도록 처리하세요.
*/

--해설


--PROCEDURE 생성 
CREATE OR REPLACE PROCEDURE depts_proc
    (
        p_dept_id IN depts.department_id%TYPE, --p_dept_id 입력값
        p_dept_name IN depts.department_name%TYPE,
        p_flag IN VARCHAR2
    )
IS
    v_cnt NUMBER := 0;

BEGIN

    --count 세기
    --1) 조회: 조회된 행의 개수 v_cnt에 대입, 
    SELECT COUNT(*)
    INTO v_cnt
    FROM depts
    WHERE department_id = p_dept_id;
    
          
    --I U D 조건
    --I일 경우
    IF p_flag = 'I' THEN
        INSERT INTO depts(department_id, department_name) --id와 name 컬럼에@
        VALUES(p_dept_id, p_dept_name); --id, name값 대입

    --U v_cnt 0일 경우
    ELSIF p_flag = 'U' THEN
        IF v_cnt = 0 THEN
            dbms_output.put_line('수정하고자 하는 부서가 존재하지 않습니다.');
            RETURN; --v_cnt 0일 경우 종료
        END IF;        
    
    --U v_cnt 1일 경우
        UPDATE depts 
        SET department_name = p_dept_name --바꾸겠다
        WHERE department_id = p_dept_id; --누구를

    --D v_cnt 0일 경우
    ELSIF p_flag = 'D' THEN
        IF v_cnt = 0 THEN
            dbms_output.put_line('삭제하고자 하는 부서가 존재X');
            RETURN;
        END IF;        

    --D v_cnt 1일 경우        
        DELETE FROM depts
        WHERE department_id = p_dept_id;
    
    --I U D 예외값
    ELSE
        dbms_output.put_line('해당 flag에 대한 동작이 준비되지 않았음');
    END IF;
    
    COMMIT;

    
    --예외처리
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('예외 발생');
            dbms_output.put_line('ERROR msg :' || SQLERRM); --에러메시지
            ROLLBACK;
            
END;





--PROCEDURE 실행
EXEC depts_proc(400, '개발부', 'I'); --사본 테이블
EXEC depts_proc(400, '영업부', 'U');
EXEC depts_proc(400, '영업부', 'D');
EXEC depts_proc(400, '영업부', 'X');

--depts_deptno_pk 이름 설정
ALTER TABLE depts ADD CONSTRAINT depts_deptno_pk PRIMARY KEY(department_id); --테이블 수정 : 제약조건 변경@
--테이블 : 열 - 연필모양 - 제약조건 편집 가능
EXEC depts_proc(80, '영업부', 'I'); --에러 : 프라이머리키 중복 : 예외처리 동작하는지 확인한 것 : INSERT라 안됨
--DEPARTMENT ID : PK 중복안됨!, 중복처리X

SELECT * FROM depts;



--내가 작성
CREATE TABLE dept (
    d_department_id IN departments.department_id%TYPE
    d_department_name IN departments.department_name%TYPE
    flag OUT ?
)


DECLARE depts_proc
    (
    d_department_id,
    d_department_name,
    flag(I, U, D)
    )
BEGIN
    IF flag = I
        INSERT INTO depts
        VALUES(d_department_id, d_departmnet_name, flag)
    
        ELSE IF flag = U
            UPDATE INTO depts
            VALUES(d_department_id, departmnet_name, flag)
    
        ELSE IF flag = D
            DELETE INTO depts
            VALUES(d_department_id, departmnet_name, flag)
    
        COMMIT;
    
    ELSE
    ROLLBACK;
    END IF;
    
END;




/*
employee_id를 전달받아 employees에 존재하면,
근속년수를 out하는 프로시저를 작성하세요. (익명블록에서 프로시저를 실행)
없다면 exception처리하세요
*/



CREATE OR REPLACE PROCEDURE emp_hire_proc
    (
        p_emp_id IN employees.employee_id%TYPE, --gpt2. p_emp_id를 입력으로 받아서 해당 사원의 입사일을 찾습니다.
        p_year OUT NUMBER --뽑아냄
    )
IS
    --v_hire_date DATE; --DATE 타입으로 변수 선언 : 방법1
    v_hire_date employees.hire_date%TYPE; -- 방법2 --타입에 맞춤
    
BEGIN

    SELECT
        hire_date --2)WHERE의 일치하는 hire_date --576 없음
        
    INTO v_hire_date --3)대입하겠다 --576 담기지 않음 --gpt3. hire_date를 v_hire_date 변수에 할당합니다.
    
    FROM employees
    WHERE employee_id = p_emp_id; --1)외부로 부터 받은 ID(매개변수)

    --p_year := TRUNC((sysdate - v_hire_date)/365, 0) --할당, 0쓰나 안쓰나 동일
    p_year := TRUNC((sysdate - v_hire_date) / 365); --4) 할당  --gpt4. 현재 날짜와 입사일 간의 차이를 계산하여 p_year에 할당합니다.

    
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line(p_emp_id || '은(는) 없는 데이터 입니다.'); --576 에러 발생
        p_year := 0;
    
END;






DECLARE --익명블록 생성(OUT변수에 전달하기 위해) @
    v_year NUMBER; --OUT 변수에 전달할 변수
    
BEGIN
    emp_hire_proc(100, v_year); --emp_hire_proc 연결고리 --576(없는 사번) --100(있는 사번)
    IF v_year > 0 THEN
        dbms_output.put_line('근속년수: ' || v_year || '년');
    END IF;
    
END;













--내가 작성
CREATE OR REPLACE PROCEDURE my_new_job_proc
    (    
    e_employee_id IN employees.employee_id%TYPE
    )
IS
    v_cnt NUMBER := 0; 

BEGIN

    SELECT 
        COUNT(*)
        TRUNC((sysdate - hire_date) / 365)- 
        
    INTO
        v_cnt --delete 때 없는 데이터인지 확인하려고
    
    FROM employees
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN
        INSERT INTO employees
        VALUES(employee_id);
    
    ELSE --조회 결과가 있다면 UPDATE
        UPDATE jobs
        SET employee_id = e_employee_id
        WHERE employee_id = e_employee_id;
        
        
    END IF;
    COMMIT;
END;


