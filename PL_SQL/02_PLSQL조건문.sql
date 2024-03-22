
--IF문 연습해보기
DECLARE
    v_salary NUMBER := 0;
    v_department_id NUMBER := 0;
BEGIN
    
    --ROUND 반올림
    v_department_id := ROUND(DBMS_RANDOM.VALUE(10, 110), -1);   --10~120 --자리수 -1에서 반올림 : 32 ->30, 67 -> 70 : 10단위 생성
    dbms_output.put_line('생성된 난수: ' || v_department_id);
    
    SELECT
        salary
    INTO
        v_salary
    FROM employees
    WHERE department_id = v_department_id
    AND ROWNUM = 1; -- 첫째 값만 구해서 변수에 저장.
    --IF/END IF 괄호 없는대신 END IF; 사용


    IF
        v_salary <= 5000
    THEN
        dbms_output.put_line('급여가 좀 낮음!');
    ELSIF
        v_salary <= 9000
    THEN
        dbms_output.put_line('급여가 중간임!');
    ELSE
        dbms_output.put_line('급여가 높음!');
    END IF; --END문 끝났다고 해야함
END;

--SET SERVEROUTPUT ON; --출력문 활성화 --드래그 후 우선 실행
--드래그 하고 F9

--오류 보고
--ORA-06550: 오류코드 구글에 검색
--PLS-00103: 오류코드 구글에 검색


-- CASE문
DECLARE
-- 변수 추가함
    v_salary NUMBER := 0;  --v:value(관례)
    v_department_id NUMBER := 0;
BEGIN
    
    v_department_id := ROUND(DBMS_RANDOM.VALUE(10, 110), -1); 
    dbms_output.put_line('생성된 난수: ' || v_department_id);
    
    SELECT
        salary
    INTO
        v_salary
    FROM employees
    WHERE department_id = v_department_id
    AND ROWNUM = 1; -- 첫째 값만 구해서 변수에 저장.
    
    -- CASE문
    CASE
        WHEN v_salary <= 5000 THEN
            dbms_output.put_line('급여가 좀 낮음!');
        WHEN v_salary <= 9000 THEN
            dbms_output.put_line('급여가 중간임!');
        ELSE
            dbms_output.put_line('급여가 높음!');
    END CASE; --CASE문 종료
    
END;



-- 중첩 IF문
DECLARE
    v_salary NUMBER := 0;
    v_department_id NUMBER := 0;
    v_commission NUMBER := 0;
BEGIN
    v_department_id := ROUND(DBMS_RANDOM.VALUE(10, 110), -1);
    dbms_output.put_line('생성된 난수: ' || v_department_id);
    
    SELECT
        salary, commission_pct --1)셀렉
    INTO
        v_salary, v_commission --2)인투
    FROM employees
    WHERE department_id = v_department_id
    AND ROWNUM = 1; -- 첫째 값만 구해서 변수에 저장. --ROWNUM 행 번호를 출력
  
    IF v_commission > 0 THEN
        IF v_commission > 0.15 THEN
            dbms_output.put_line('커미션이 15% 이상입니다.');
            dbms_output.put_line(v_salary * v_commission);
        END IF; --END IF 1번)
    ELSE
        dbms_output.put_line('커미션이 없어요 ㅠㅠ');
    END IF; --END IF 2번)
    
END;