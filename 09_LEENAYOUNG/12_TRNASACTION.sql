-- ===================================
-- TCL
-- ===================================
-- Transaction Control Language 트랜잭션 제어 언어
-- COMMIT, ROLLBACK, SAVEPOINT 등이 있다.

# 트랜잭션이란
-- 한꺼번에 수행되어야 할 최소의 작업 단위를 말한다.
-- 논리적 작업 단위 (LUW, Logical Units of Work)
-- 하나의 트랜잭션으로 이루어진 작업들은 반드시 한꺼번에 완료가 되어야 하며,
-- 그렇지 않은 경우에는 한꺼번에 취소 되어야 한다.

# 트랜잭션 ACID 원칙
-- 1. Atomicity : 원자성.
--      - 트랜잭션과 관련된 일은 모두 실행되던지 모두 실행되지 않도록 하던지를 보장하는 특성이다.
-- 2. Consistency : 일관성.
--      - 트랜잭션이 성공했다면, 데이터베이스는 그 일관성을 유지해야 한다.
--      - 일관성은 특정한 조건을 두고, 그 조건을 만족하는지를 확인하는 방식으로 검사할 수 있다.
-- 3. Isolation : 독립성.
--      - 트랜잭션을 수행하는 도중에 다른 연산작업이 끼어들지 못하도록 한다.
--      - 임계영역을 두는 것으로 달성할 수 있다. 기본적으로 READ_COMMITED 방식을 적용한다.
-- 4. Durability : 지속성.
--      - 성공적으로 트랜잭션이 수행되었다면, 그 결과는 완전히 반영이 되어야 한다.
--      - 완전히 반영되면 로그를 남기게 되는데, 후에 이 로그를 이용해서 트랜잭션 수행전 상태로 되돌릴 수 있어야 한다.
--      - 때문에 트랜잭션은 로그저장이 완료된 시점에서 종료가 되어야 한다.

# TCL 구분
-- 1. COMMIT : 트랜잭션 작업이 정상 완료 되면 변경 내용을 영구히 저장 (모든 savepoint 삭제)
-- 2. ROLLBACK : 트랜잭션 작업을 모두 취소하고 가장 최근 commit 시점으로 이동
-- 3. SAVEPOINT <savepoint명> : 현재 트랜잭션 작업 시점에 이름을 지정
--      하나의 트랜잭션 안에서 구역을 나눌수 있음
-- 4. ROLLBACK TO <savepoint명> : 트랜잭션 작업을 취소하고 savepoint 시점으로 이동

SET autocommit = 1;
-- 커밋 상태값 확인 쿼리
SHOW VARIABLES LIKE 'autocommit';


CREATE TABLE kb_bank (
                         id INT PRIMARY KEY ,
                         name VARCHAR(100) NOT NULL,
                         balance BIGINT CHECK(balance >= 0)
);

CREATE TABLE encore_bank (
                             id INT PRIMARY KEY ,
                             name VARCHAR(100) NOT NULL ,
                             balance BIGINT CHECK ( balance >= 0)
);

INSERT INTO kb_bank VALUES (1231, '홍길동', 1000000);
INSERT INTO encore_bank VALUES (456, '신사임당', 1000000);

SELECT * FROM kb_bank;
SELECT * FROM encore_bank;
ROLLBACK; -- 적용 안됨

START TRANSACTION ;
UPDATE kb_bank SET balance = balance - 100000 WHERE id = 1231;
UPDATE encore_bank SET balance = balance - 100000 WHERE id = 456;
ROLLBACK; -- 적용됨
COMMIT;

START TRANSACTION ;
SELECT menu_name, menu_price FROM tbl_menu;

INSERT INTO tbl_menu
VALUES (null, '딸기맛감자탕', 9500, 4, 'Y');

INSERT INTO tbl_menu(menu_code, menu_name, menu_price, category_code, orderable_status)
VALUES (null, '생딸기한우국밥', 15000, 4, 'Y');

INSERT INTO tbl_menu(menu_name, menu_price, category_code, orderable_status)
VALUES ('민트초코맛파전', 10000, 4, 'Y');

SAVEPOINT strawberry;
UPDATE tbl_menu SET menu_name = '수정된메뉴' WHERE menu_code = 5;
DELETE FROM tbl_menu WHERE menu_code = 7;

SELECT menu_code, menu_name, menu_price FROM tbl_menu;

ROLLBACK TO strawberry;
ROLLBACK ;