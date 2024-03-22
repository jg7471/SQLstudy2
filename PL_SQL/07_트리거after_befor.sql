/*
AFTER 트리거 - INSERT, UPDATE, DELETE 작업 이후에 동작하는 트리거를 의미합니다.
BEFORE 트리거 - INSERT, UPDATE, DELETE 작업 이전에 동작하는 트리거를 의미합니다.

:OLD = 참조 전 열의 값 (INSERT: 입력 전 자료, UPDATE: 수정 전 자료, DELETE: 삭제될 값) --before
:NEW = 참조 후 열의 값 (INSERT: 입력 할 자료, UPDATE: 수정 된 자료) --after

테이블에 UPDATE나 DELETE를 시도하면 수정, 또는 삭제된 데이터를 --백업테이블 작성시 자주 씀
별도의 테이블에 보관해 놓는 형식으로 트리거를 많이 사용합니다.

트리거 자체를 트랜잭션의 일부로 처리하기 때문에 COMMIT이나 ROLLBACK을 포함 할 수 없습니다.
*/

--예제0
CREATE TABLE tbl_user( --테이블 생성
    id VARCHAR2(20) PRIMARY KEY,
    name VARCHAR2(20),
    address VARCHAR2(30)
);



CREATE TABLE tbl_user_backup( --백업 테이블 생성
    id VARCHAR2(20) PRIMARY KEY,
    name VARCHAR2(20),
    address VARCHAR2(30),
<<<<<<< HEAD
    --백업전용
=======
    --백업용 추가입력
>>>>>>> 6e8d7447f5a661392580a0948efdd4b5526b15bb
    update_date DATE DEFAULT sysdate, -- 정보 변경 시간(기본값: INSERT 되는 시간) --인서트할 때 sysdate 자동 입력됨
    m_type VARCHAR2(10), -- 변경 타입 --삭제 or 수정
    m_user VARCHAR2(20) -- 변경한 사용자 --흔적
);



--AFTER 트리거 생성 여기 先 실행
CREATE OR REPLACE TRIGGER trg_user_backup
    --트리거 조건
    AFTER UPDATE OR DELETE
    ON tbl_user
    FOR EACH ROW --모든 행에 적용
    
DECLARE
    --트리거 몸통 : 변수선언 = --m_type
    v_type VARCHAR2(10);

BEGIN
    --현재 트리거가 발동된 상황이 UPDATE인지 DELETE인지 파악하는 조건문
    IF UPDATING THEN -- UPDATING은 시스템 자체에서 상태에 대한 내용을 지원하는 빌트인 <오라클>기본 구문. //INSERTING
        v_type := '수정'; --m_type
    ELSIF DELETING THEN
        v_type := '삭제';
    END IF;

    
    --본격적인 실행 구문 작성 (backup 테이블에 값을 INSERT
    -- -> 원본 테이블에서 UPDATE or DELETE 된 사용자의 정보 및 기타 정보)
    INSERT INTO tbl_user_backup
    VALUES(:OLD.id, :OLD.name, :OLD.address, sysdate, v_type, USER()); --기존 id, name , address : 업뎃/삭제 되기 전에 데이터입력됨(트리거)
    --날짜 update_date 안넣어도됨 자동입력(컬럼 적기 귀찮아서 적음)
    --USER() 함수 : 유저 계정명
    
END;



-- 확인!
INSERT INTO tbl_user VALUES('test01', 'kim', '서울');
INSERT INTO tbl_user VALUES('test02', 'lee', '경기');
INSERT INTO tbl_user VALUES('test09', 'hong', '부산');

SELECT * FROM tbl_user;
SELECT * FROM tbl_user_backup; --백업테이블 정보(수정,삭제) --직접 insert X, 트리거에 의해 자동 입력됨 : 수정시 이전 정보 입력됨!!
--@ 삭제 된거 확인

UPDATE tbl_user SET address = '인천' WHERE id = 'test01'; --원래 서울인데 -> 인천으로 변경
DELETE FROM tbl_user WHERE id = 'test02';



--240319
--예제1
--BEFORE 트리거 생성
CREATE OR REPLACE TRIGGER trg_user_insert
    BEFORE INSERT
    ON tbl_user --절대적으로 적용
    FOR EACH ROW

--DECLARE --생략 가능 @

BEGIN
    --INSERT 예정인 name의 값에서 첫글자만 추출 후 뒤에 *을 3개 붙이겠다
    :NEW.name := SUBSTR(:NEW.name, 1, 1) || '***'; --들어가려는 새로운 name의 값 ex)손** 인스터 예정인 name의 값을 1글자만 떼서 tbl_user에 대입/// LTRIM 사용해도 됨
    --:NEW 들어가려는 새로운 값
    
    --substr(자를 문자열, 시작인덱스 ,길이)
    --여기선 ROLLBACK; 불가 : TRIGGER에서 트랜잭션 불가(바깥에선 사용 가능)
END;



--데이터 삽입 tbl_user 
INSERT INTO tbl_user VALUES('test07', '메롱이', '대전');--INSERT 백업 동작xx : INSERT, UPDATE, DELETE 되기 前에 미리 처리하겠다!!
INSERT INTO tbl_user VALUES('test05', '김오라클', '광주');

ROLLBACK;









--예제2
-- 주문 히스토리
CREATE TABLE order_history (
    history_no NUMBER(5) PRIMARY KEY,
    order_no NUMBER(5), --상품번호 고유값X(중복구매)
    product_no NUMBER(5),
    total NUMBER(10),
    price NUMBER(10)
);


-- 상품
CREATE TABLE product(
    product_no NUMBER(5) PRIMARY KEY,
    product_name VARCHAR2(20),
    total NUMBER(5),
    price NUMBER(5)
);



--시퀀스 생성
CREATE SEQUENCE order_history_seq NOCYCLE NOCACHE; --좌측 메뉴에서 시퀀스 확인도 가능
CREATE SEQUENCE product_seq NOCYCLE NOCACHE;


--더미 데이터 삽입
INSERT INTO product VALUES(product_seq.NEXTVAL, '피자', 100, 10000);
INSERT INTO product VALUES(product_seq.NEXTVAL, '치킨', 100, 20000);
INSERT INTO product VALUES(product_seq.NEXTVAL, '햄버거', 10, 5000);

SELECT * FROM product;






--주문 히스토리에 데이터가 들어오면 실행하는 트리거
CREATE OR REPLACE TRIGGER trg_order_history --trg_관례
    BEFORE INSERT
    ON order_history
    FOR EACH ROW
    
DECLARE
    --변수 선언
    v_total NUMBER;
    v_product_no NUMBER;
    v_product_total NUMBER;
    --커스텀 에러 생성
    quantity_shortage_exception EXCEPTION; --EXCEPTION타입 변수 생성(에러 커스텀하기 위해)
    zero_total_exception EXCEPTION;

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
    
    IF v_product_total <= 0 THEN -- 재고가 없는 경우
        RAISE zero_total_exception; --에러 고의 발생
    
    
    ELSIF v_total > v_product_total THEN --주문수량이 재고수량보다 많은 경우
        RAISE quantity_shortage_exception;
    END IF;
        
    --재고 수량이 넉넉하다면 주문수량만큼 재고수량 조정(정상적일 때)
    UPDATE product SET total = total - v_total
    WHERE product_no = v_product_no;
    
        EXCEPTION
        WHEN quantity_shortage_exception THEN
        -- 오라클에서 제공하는 사용자 정의 예외를 발생시키는 함수 : RAISE_APPLICATION_ERROR(번호, 출력값)
        -- 첫번째 매개값: 에러 코드 (사용자 정의 예외 -20000 ~ -20999까지)
        -- 두번째 매개값: 에러 메세지
        RAISE_APPLICATION_ERROR(-20001, '주문하신 수량보다 재고가 적어서 주문 할 수 없습니다'); --고의 에러 발생문(20001 커스텀임)
        
        WHEN zero_total_exception THEN
        RAISE_APPLICATION_ERROR(-20001, '주문하신 재고가 없어서 주문 할 수 없습니다'); --고의 에러 발생문

END;

                                --history_no PRIMARY KEY, order_no, product_no, total, price
INSERT INTO order_history VALUES(order_history_seq.NEXTVAL, 200, 1, 5, 50000); --주문번호(200) 중복O : 동시에 여러 상품 구매
INSERT INTO order_history VALUES(order_history_seq.NEXTVAL, 200, 2, 1, 20000);
INSERT INTO order_history VALUES(order_history_seq.NEXTVAL, 200, 3, 5, 25000); -- 다써봐 --ORA-20002 오류

SELECT * FROM order_history;
SELECT * FROM product;

--트리거 내에서 예외가 발생하면 수행중인 INSERT 작업은 중단되며 ROLLBACK이 진행됨 : AFTER trigger도 동일
INSERT INTO order_history VALUES(order_history_seq.NEXTVAL, 203, 1, 100, 1000000); --재고가 없음 --ORA-20001 오류
