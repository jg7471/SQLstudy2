--mySQL에도 존재

-- 프로시저(procedure) -> void 메서드 유사
-- 특정한 로직을 처리하고 결과값을 반환하지 않는 코드 덩어리 (쿼리)
-- 하지만 프로시저를 통해서 값을 리턴하는 방법도 있습니다.


CREATE PROCEDURE guguproc --프로시저 이름 생성
    (p_dan IN NUMBER) --매개변수 --IN/OUT 있음
IS --PROCEDURE : IS 사용 익명블록의 DECLARE(선언부) : 필요한 변수 있음 여기에 적기


BEGIN
    dbms_output.put_line(p_dan || '단');

    FOR i IN 1..9
    LOOP
        dbms_output.put_line(p_dan || 'x' || i || '=' || p_dan*i);
    END LOOP;
END;

--실행
EXEC guguproc(37); --호출 ： 호출할 때 --포함되면 오류

--------------------------------------------------------------------------------

--매개값(인수) 없는 프로시저
CREATE PROCEDURE p_test
IS --선언부
    v_msg VARCHAR2(30) := 'Hello Procedure!';

BEGIN -- 시작부
    dbms_output.put_line(v_msg);
END; --종료부


--실행
EXEC p_test; --() 없어도 됨


--------------------------------------------------------------------------------


-- IN 입력값을 여러 개 전달받는 프로시저
CREATE PROCEDURE my_new_job_proc
    (
    p_job_id IN jobs.job_id%TYPE,--TYPE 따라가겠다
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE, --위에 네모는 그냥 타입 맞출라고 쓴거에요(INSERT와 상관x)
    p_max_sal IN jobs.max_salary%TYPE
    )
IS --생략 불가(없으면 비워두셈)

BEGIN
    INSERT INTO jobs --PROCEDURE를 호출할 때 전달받은 값
    VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    
    COMMIT;--인서트 과정에서 에러없으면 커밋하겟다(롤백해도 복구 불가)
END;

--실행
EXEC my_new_job_proc('JOB1', 'test job1', 2000, 5000);

--조회
SELECT * FROM jobs; --내용확인 (커밋까지 완료)

--job_id를 확인해서
--이미 존재하는 데이터라면 수정, 없다면 새롭게 추가(job_id가 PK이기 때문)



--------------------------------------------------------------------------------


CREATE OR REPLACE PROCEDURE my_new_job_proc -- 프로시져 기존 존재X CREATE 존재O REPLACE : VIEW문법
    (p_job_id IN jobs.job_id%TYPE, --TYPE 따라가겠다
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE,
    p_max_sal IN jobs.max_salary%TYPE
    )
IS
    v_cnt NUMBER := 0; --존재 여부 확인

BEGIN
    --동일한 job_id가 있는지부터 체크
    --이미 존재한다면 1, 존재하지 않는다면 0 -> v_cnt에 저장


    SELECT --인서트 하기전에 중복값 조회 0번)
        COUNT(*) --jobs에 p_job_id가 있는지 체크 1번) 프라이머리키
        
    INTO   
        v_cnt --2번) 카운트 값 저장, 있으면 1 없으면 0
    
    FROM jobs
    
    WHERE job_id = p_job_id;
    IF v_cnt = 0 THEN --조회 결과가 없었다면 INSERT
        INSERT INTO jobs
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    
    ELSE --조회 결과가 있다면 UPDATE
        UPDATE jobs
        SET job_title = p_job_title,
        min_salary = p_min_sal,
        max_salary = p_max_sal
        WHERE job_id = p_job_id;
        
    END IF;
    COMMIT;
END;



EXEC my_new_job_proc('JOB3', 'test_job3', 8000, 10000); --기존값 있으면 대체 없으면 추가
SELECT * FROM jobs;

















--------------------------------------------------------------------------------
--매개값(인수)의 디폴트 값(기본값) 설정
CREATE OR REPLACE PROCEDURE my_new_job_proc -- 프로시져 기존 존재X CREATE 존재O REPLACE : VIEW문법
    (p_job_id IN jobs.job_id%TYPE,
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE := 0,
    p_max_sal IN jobs.max_salary%TYPE := 1000
    )
IS
    v_cnt NUMBER := 0; --존재 여부 확인
    
BEGIN
    --동일한 job_id가 있는지부터 체크
    --이미 존재한다면 1, 존재하지 않는다면 0 -> v_cnt에 저장


    SELECT --인서트 하기전에 중복값 조회 0번)
        COUNT(*) --jobs에 p_job_id가 있는지 체크 1번) 프라이머리키
        
    INTO   
        v_cnt --2번) 카운트 값 저장, 있으면 1 없으면 0
    
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN --조회 결과가 없었다면 INSERT
        INSERT INTO jobs
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    
    ELSE --조회 결과가 있다면 UPDATE
        UPDATE jobs
        
        SET job_title = p_job_title,
        min_salary = p_min_sal,
        max_salary = p_max_sal
        
        WHERE job_id = p_job_id;
        
    END IF;
    COMMIT;
END;

EXEC my_new_job_proc('JOB4', 'test job5'); --:= 0, := 1000, 기본값 세팅해서 입력 안해도 괜찮
SELECT * FROM jobs;


--------------------------------------------------------------------------------


--OUT, IN OUT 매개변수 사용
--OUT 변수를 사용하면 프로시저 바깥쪽으로 값을 보냅니다
--OUT을 이용해서 보낸 값은 바깥 익명 블록에서 실행해야 합니다

CREATE OR REPLACE PROCEDURE my_new_job_proc -- 프로시져 기존 존재X CREATE 존재O REPLACE : VIEW문법
    (p_job_id IN jobs.job_id%TYPE, --IN 외부값 받음
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE := 0,
    p_max_sal IN jobs.max_salary%TYPE := 1000,
    p_result OUT VARCHAR2 --OUT 프로시저 내부에서 바깥으로 내보내기 위한 변수
    )
IS
    v_cnt NUMBER := 0; --존재 여부 확인
    v_result VARCHAR2(100) := '존재하지 않는 값이라 INSERT 처리 되었습니다';

BEGIN

    SELECT --인서트 하기전에 중복값 조회 0번)
        COUNT(*) --jobs에 p_job_id가 있는지 체크 1번) 프라이머리키
        
    INTO   
        v_cnt --2번) 카운트 값 저장, 있으면 1 없으면 0
    
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN --조회 결과가 없었다면 INSERT
        INSERT INTO jobs
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    
    ELSE --조회 결과가 있다면 UPDATE

        SELECT
            p_job_id || '의 최대급여:' || max_salary ||'최소급여' min_salary       
        INTO --조회결과를 INTO에 대입
            v_result --조회 결과를 변수에 대입
            
        FROM jobs
        WHERE job_id = p_job_id;
                
    END IF;
    
    --OUT 매개변수에 조회결과를 할당 -> 우리가 알고있는 return 개념과 같다
    --OUT 매개변수에 값을 할당해 놓으면 프로시저 종료 후 호출부로 OUT변수의 값이 전달됨
    p_result := v_result;
    
    COMMIT;
END;

--------------------------------------------------------------------------------
DECLARE
    msg VARCHAR2(100);

BEGIN
    my_new_job_proc('JOB2', 'test_job2', 2000, 8000, msg); --msg 호출 함수 @ : p_result OUT VARCHAR2
    dbms_output.put_line(msg);
    
    my_new_job_proc('CEO1', 'test_ceo1', 30000, 80000, msg);-- 존재하지 않는 값이라 insert
    dbms_output.put_line(msg);
    
    --my_new_job_proc('CEO2', 'test_ceo2', 30000, 80000); --에러 --msg 변수 있어야함
    --dbms_output.put_line(msg);
END;

SELECT * FROM jobs;

--자바 : 함수의 호출문은 하나의  리턴값. 매개값으로 사용가능     msg := my

---------------------------------------------------
--1번컴파일
--IN, OUT 동시에 처리
CREATE OR REPLACE PROCEDURE my_param_test_proc
    (
    --IN : 반환 불가. 받는 용도로만 가능
    p_var1 IN VARCHAR2,
    
    --OUT : 받는 용도로는 불가능
    --OUT이 되는 시점은 프로시저가 끝날 때, 그 전까지는 할당이 안됨.
    p_var2 OUT VARCHAR2,
    
    --IN, OUT이 둘 다 가능함.
    p_var3 IN OUT VARCHAR2
    )
IS

BEGIN
    dbms_output.put_line('p_varl:' || p_var1); --IN 출력됨
    dbms_output.put_line('p_var2:' || p_var2); --OUT 값을 전달했음에도 불구하고 프로시저 내에서 확인 불가
    dbms_output.put_line('p_var3:' || p_var3); --IN OUT : IN의 성질을 가지고 있음
    
    --p_var1 := '결과1';--(받는 용도라,값 할당 재정의 불가:새로운 값으로 변경불가)
    p_var2 := '결과2';--(빈 변수 보냄)
    p_var3 := '결과3';--받기 내보내기 다 됨
    
END;
    
    ----------------------------------
--2번실행    
DECLARE
    v_var1 VARCHAR2(10) := 'value1';
    v_var2 VARCHAR2(10) := 'value2'; --OUT 리턴값 없음
    v_var3 VARCHAR2(10) := 'value3';
BEGIN
    my_param_test_proc(v_var1, v_var2, v_var3);
    
    dbms_output.put_line('v_var1: ' || v_var1);
    dbms_output.put_line('v_var2: ' || v_var2);
    dbms_output.put_line('v_var3: ' || v_var3);
    
END;

--RETURN: 값의 반환X, 프로시저 강제 종료할 때 사용

--------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE my_new_job_proc
    (p_job_id IN jobs.job_id%TYPE,
     p_result OUT VARCHAR2 
    )
IS
    v_cnt NUMBER := 0;
    v_result VARCHAR2(100) := '존재하지 않는 값이라 INSERT 처리 되었습니다.';
BEGIN
    
    SELECT
        COUNT(*)
    INTO
        v_cnt
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN --값 조회하여, 없으면 강제 종료(바로 종료하기에 기본기능 일치X-> ELSE 노필요, 리턴->강제종료)
        dbms_output.put_line(p_job_id || '는 테이블에 존재하지 않습니다.');
        RETURN; -- 프로시저 강제 종료.
    END IF;
     
     
     
     
    SELECT --기본기능
        p_job_id || '의 최대 연봉: ' || max_salary || ', 최소 연봉: ' || min_salary
    INTO
        v_result 
    FROM jobs
    WHERE job_id = p_job_id;

    p_result := v_result;
    
    COMMIT;
END;


DECLARE
    msg VARCHAR2(100);
BEGIN 
    my_new_job_proc('merong', msg); --job id가 merong
    dbms_output.put_line(msg);
END;

--------------------------------------------------------------------------------

--예외처리
DECLARE
    v_num NUMBER := 0;

    /*
    OTHERS 자리에 예외의 타입을 작성해 줍니다.
    ACCESS_INTO_NULL -> 객체 초기화가 되어 있지 않은 상태에서 사용.
    NO_DATA_FOUND -> SELECT INTO 시 데이터가 한 건도 없을 때
    ZERO_DIVIDE -> 0으로 나눌 때
    VALUE_ERROR -> 수치 또는 값 오류
    INVALID_NUMBER -> 문자를 숫자로 변환할 때 실패한 경우
    */

BEGIN
    v_num := 10/0;
    EXCEPTION --SQL에서 가장 마지막에 넣음
        WHEN ZERO_DIVIDE THEN --에러 종류
        dbms_output.put_line('0으로 나누시면 안되여');
        dbms_output.put_line('SQL ERROR CODE:' || SQLCODE); --SQLCODE 에러 종류
        dbms_output.put_line('0으로 나누시면 안되여' || SQLERRM);
    WHEN OTHERS THEN --자바 catch(exception) : 모든 에러 받아주는 구문
        --WHEN으로 설정한 예외가 아닌 다른 예외가 발생 시 OTHERS 실행
        dbms_output.put_line('알 수 없는 예외 발생!');
        
        
    dbms_output.put_line('익명블록 종료');
END;