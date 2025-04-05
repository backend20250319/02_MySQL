-- =====================
-- CONSTRAINTS
-- =====================
-- 제약조건
-- 테이블 작성 시 각 컬럼에 값 기록에 대한 제약조건을 설정할 수 있다.
-- 데이터 무결성 보장 목적으로 한다.
-- 입력/수정하는 데이터에 문제가 없는지 자동으로 검사해 주게 하기 위한 목적
-- PRIMARY KEY, NOT NULL, UNIQUE, CHECK, FOREIGN KEY

# 제약조건 조회
SELECT *
FROM information_schema.TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'menudb'
  AND table_name = 'tbl_menu';

# NOT NULL 제약조건: NULL값 허용하지 않는다.
DROP TABLE IF EXISTS user_notnull;
CREATE TABLE IF NOT EXISTS user_notnull (
                                            user_no INT NOT NULL,
                                            user_id VARCHAR(255) NOT NULL,
                                            user_pwd VARCHAR(255) NOT NULL,
                                            user_name VARCHAR(255) NOT NULL,
                                            gender VARCHAR(3),
                                            phone VARCHAR(255) NOT NULL,
                                            email VARCHAR(255)
) ENGINE=INNODB;

INSERT INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
    (2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_notnull;

-- NULL이 포함되면 오류 발생
INSERT INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (1, 'user01', null, '홍길동', '남', '010-1234-5678', 'hong123@gmail.com');


-- UNIQUE
DROP TABLE IF EXISTS user_unique;
CREATE TABLE IF NOT EXISTS user_unique (
                                           user_no INT NOT NULL UNIQUE, -- 컬럼레벨로 적용
                                           user_id VARCHAR(255) NOT NULL,
                                           user_pwd VARCHAR(255) NOT NULL,
                                           user_name VARCHAR(255) NOT NULL,
                                           gender VARCHAR(3),
                                           phone VARCHAR(255) NOT NULL UNIQUE,
                                           email VARCHAR(255),
                                           UNIQUE (phone) -- 테이블레벨로 적용
) ENGINE=INNODB;

INSERT INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
    (2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_unique;

INSERT INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (3, 'user01', 'pass01', '홍길동', '남', '010-1234-5670', 'hong123@gmail.com');
-- > 이미 삽입된 데이터에서 PHONE 값만 바꿔서는 오류가 발생함

-- ===============================
-- PRIMARY KEY
-- ===============================
-- 테이블에서 정확히 한 행을 식별하기 위해 사용할 컬럼을 의미한다.
-- 테이블에 대한 식별자 역할을 한다.(한 행씩 구분하는 역할을 한다.)
-- NOT NULL + UNIQUE 제약조건의 의미
-- 한 테이블 당 한 개만 설정할 수 있음
-- 컬럼 레벨, 테이블 레벨 둘 다 설정 가능하다.
-- 한 개 컬럼에 설정할 수도 있고, 여러 개의 컬럼을 묶어서 설정할 수도 있다.(복합키)

DROP TABLE IF EXISTS user_primarykey;
CREATE TABLE IF NOT EXISTS user_primarykey (
--     user_no INT PRIMARY KEY,
                                               user_no INT,
                                               user_id VARCHAR(255) NOT NULL,
                                               user_pwd VARCHAR(255) NOT NULL,
                                               user_name VARCHAR(255) NOT NULL,
                                               gender VARCHAR(3),
                                               phone VARCHAR(255) NOT NULL,
                                               email VARCHAR(255),
                                               PRIMARY KEY (user_no)
) ENGINE=INNODB;

INSERT INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
    (2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

desc user_primarykey;
SELECT * FROM user_primarykey;

INSERT INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (3, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com');
-- > primary key에는 이미 삽입된 값 또는 null이 들어갈 수 없다.

-- ================================
-- FOREIGN KEY
-- ================================
-- 참조(REFERENCES)된 다른 테이블에서 제공하는 값만 사용할 수 있다.
-- 참조무결성을 위배하지 않기 위해 사용한다.
-- FOREIGN KEY제약조건에 의해서 테이블간의 관계(RELATIONSHIP)가 형성된다.
-- 제공되는 값 외에는 NULL을 사용할 수 있다.
DROP TABLE IF EXISTS  user_grade;
CREATE TABLE IF NOT EXISTS user_grade(
    grade_code INT PRIMARY KEY ,
    grade_name VARCHAR(255) NOT NULL
) ENGINE = INNODB;

INSERT INTO user_grade
VALUES (10, '일반회원'),
       (20, '우수회원'),
       (30, '특별회원');

SELECT * FROM user_grade;

DROP TABLE IF EXISTS user_foreignkey;
CREATE TABLE IF NOT EXISTS user_foreignkey(
  user_no INT PRIMARY KEY ,
  user_id VARCHAR(255) NOT NULL ,
  user_pwd VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255),
#   grade_code INT NOT NULL,
  grade_code INT,
  FOREIGN KEY (grade_code)
      REFERENCES user_grade(grade_code)
) ENGINE=INNODB;

INSERT INTO user_foreignkey
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
    (2, 'user02', 'pass02', '유관순', '여', '010-7777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_foreignkey;

INSERT INTO user_foreignkey
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
    (3, 'user03', 'pass03', '이순신', '남'
    , '010-1234-5671', 'lee123@gmail.com', NULL);

DELETE FROM user_grade WHERE grade_code = 10;

-- ---------------------------------------------------------------
DROP TABLE IF EXISTS  user_grade;
CREATE TABLE IF NOT EXISTS user_grade(
                                         grade_code INT PRIMARY KEY ,
                                         grade_name VARCHAR(255) NOT NULL
) ENGINE = INNODB;

INSERT INTO user_grade VALUES (10, '일반회원');
INSERT INTO user_grade VALUES (20, '우수회원');
SELECT * FROM user_grade;


DROP TABLE IF EXISTS user_foreignkey;
CREATE TABLE IF NOT EXISTS user_foreignkey(
      user_no INT PRIMARY KEY ,
      user_id VARCHAR(255) NOT NULL ,
      user_pwd VARCHAR(255) NOT NULL,
      user_name VARCHAR(255) NOT NULL,
      gender VARCHAR(3),
      phone VARCHAR(255) NOT NULL,
      email VARCHAR(255),
      grade_code INT,
      FOREIGN KEY (grade_code)
          REFERENCES user_grade(grade_code)
      ON UPDATE SET NULL
      ON DELETE SET NULL
) ENGINE=INNODB;

INSERT INTO user_foreignkey
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
    (2, 'user02', 'pass02', '유관순', '여', '010-7777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_foreignkey;

-- 1. 부모 테이블의 grade_code 수정
UPDATE user_grade
   SET grade_code = 300
 WHERE grade_code = 10;

SELECT * FROM user_grade;
SELECT * FROM user_foreignkey;

-- 2. 부모 테이블의 행 삭제
DELETE FROM user_grade
 WHERE grade_code = 20;

SELECT * FROM user_grade;
SELECT * FROM user_foreignkey;

-- ------------------------------------------------------------
DROP TABLE user_foreignkey;
DROP TABLE IF EXISTS  user_grade;

CREATE TABLE IF NOT EXISTS user_grade(
                                         grade_code INT PRIMARY KEY ,
                                         grade_name VARCHAR(255) NOT NULL
) ENGINE = INNODB;


CREATE TABLE IF NOT EXISTS user_foreignkey(
      user_no INT PRIMARY KEY ,
      user_id VARCHAR(255) NOT NULL ,
      user_pwd VARCHAR(255) NOT NULL,
      user_name VARCHAR(255) NOT NULL,
      gender VARCHAR(3),
      phone VARCHAR(255) NOT NULL,
      email VARCHAR(255),
      grade_code INT,
      FOREIGN KEY (grade_code)
          REFERENCES user_grade(grade_code)
          ON UPDATE CASCADE
          ON DELETE CASCADE
) ENGINE=INNODB;

INSERT INTO user_grade VALUES (10, '일반회원');
INSERT INTO user_grade VALUES (20, '우수회원');

INSERT INTO user_foreignkey
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
    (2, 'user02', 'pass02', '유관순', '여', '010-7777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_grade;
SELECT * FROM user_foreignkey;

UPDATE user_grade
   SET grade_code = 300
 WHERE grade_code = 10;

SELECT * FROM user_grade;
SELECT * FROM user_foreignkey;

DELETE FROM user_grade
 WHERE grade_code = 300;

SELECT * FROM user_grade;
SELECT * FROM user_foreignkey;

-- =========================================
-- CHECK
-- =========================================
-- CHECK 제약 조건 위반시 허용하지 않는다.
DROP TABLE IF EXISTS user_check;
CREATE TABLE IF NOT EXISTS user_check (
      user_no INT AUTO_INCREMENT PRIMARY KEY,
      user_name VARCHAR(255) NOT NULL,
      gender VARCHAR(5) CHECK(gender IN ('남', '여')),
      age INT CHECK(age >= 19)
) ENGINE=INNODB;
SHOW CREATE TABLE user_check;

SELECT * FROM information_schema.TABLE_CONSTRAINTS; -- 테이블의 제약조건을 확인해 볼 수 있음

INSERT INTO user_check VALUES (null, '홍길동', '남', 25);
INSERT INTO user_check VALUES (null, '유관순', '여', 20);

INSERT INTO user_check VALUES (null, '안중근', '남성', 40); -- CHECK 제약 조건에 위배
INSERT INTO user_check VALUES (null, '유승제', '남', 18); -- CHECK 제약 조건에 위배


SELECT * FROM user_check;