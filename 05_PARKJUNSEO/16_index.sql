CREATE TABLE phone (
  phone_code INT PRIMARY KEY,   -- 기본키를 지정하였으므로 자동 인덱싱
  phone_name VARCHAR(100),
  phone_price DECIMAL(10, 2)
);

INSERT INTO phone (phone_code , phone_name , phone_price )
VALUES (1, 'galaxyS23', 1200000),
       (2, 'iPhone14pro', 1433000),
       (3, 'galaxyZfold3', 1730000);

SELECT * FROM phone;

SELECT * FROM phone WHERE phone_name = 'galaxyS23';
EXPLAIN SELECT * FROM phone WHERE phone_name = 'galaxys23';  -- EXPLAIN을 사용하면 SQL 실행 계획을 확인

-- phone_name에 index 추가하기
CREATE INDEX idx_name ON phone(phone_name);

SELECT * FROM phone WHERE phone_name = 'galaxyS23';
EXPLAIN SELECT * FROM phone WHERE phone_name = 'galaxys23';  -- EXPLAIN을 사용하면 SQL 실행 계획을 확인

-- index 삭제
DROP INDEX idx_name ON phone;
