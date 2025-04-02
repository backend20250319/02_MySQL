-- =====================================================================================================================================================================
-- CONSTRAINTS
-- =====================================================================================================================================================================
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


-- ===============================================================================================================================================================================
# NOT NULL 제약조건: NULL 값을 허용하지 않는다'
-- ===============================================================================================================================================================================
DROP TABLE IF EXISTS user_notnull;
CREATE TABLE IF NOT EXISTS user_notnull (
                                            user_no INT NOT NULL,     # 컬럼 레벨로 적용
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

SELECT * FROM user_notnull; -- 위의 방식처럼 한 번에 여러 행 입력 가능함



-- ===============================================================================================================================================================================
# UNIQUE : 중복값 허용하지 않음
-- ===============================================================================================================================================================================
DROP TABLE IF EXISTS user_unique;
CREATE TABLE IF NOT EXISTS user_unique (
                                           user_no INT NOT NULL UNIQUE ,   # 컬럼 레벨로 적용
                                           user_id VARCHAR(255) NOT NULL,
                                           user_pwd VARCHAR(255) NOT NULL,
                                           user_name VARCHAR(255) NOT NULL,
                                           gender VARCHAR(3),
                                           phone VARCHAR(255) NOT NULL UNIQUE,   # NOT NULL이 있으면 UNIQUE도 그 뒤에 작성
                                           email VARCHAR(255),
                                           UNIQUE (phone)     # 테이블 레벨로 적용 // # UNIQUE는 일반적으로 이런 방식으로 씀
                                           -- ex) UNIQUE(email, username) : email과 username을 조합했을 때 유일해야 함
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
    (3, 'user01', 'pass01', '홍길동', '남', '010-1234-5679', 'hong123@gmail.com');
-- 컬럼 레벨 UNIQUE: 하나의 컬럼에 대해서만 중복을 허용하지 않음. (email UNIQUE)
-- 테이블 레벨 UNIQUE: 두 개 이상의 컬럼 조합이 유니크하도록 설정 가능.



-- ===============================================================================================================================================================================
-- PRIMARY KEY
-- ===============================================================================================================================================================================
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
                                               PRIMARY KEY (user_no)   # 여기서 PRI (기본키) 지정
) ENGINE=INNODB;   # 이 경우 auto increment가 없기 때문에  primary key에 null이 들어갈 수 없음

INSERT INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
    (2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_primarykey;
DESC user_primarykey;


-- ================================================================================================================================================================================
-- FOREIGN KEY
-- ================================================================================================================================================================================
-- 참조(REFERENCES)된 다른 테이블에서 제공하는 값만 사용할 수 있다.
-- 참조무결성을 위배하지 않기 위해 사용한다.
-- FOREIGN KEY제약조건에 의해서 테이블간의 관계(RELATIONSHIP)가 형성된다.
-- 제공되는 값 외에는 NULL을 사용할 수 있다.

DROP TABLE IF EXISTS  user_grade;
CREATE TABLE IF NOT EXISTS user_grade(
                                         grade_code INT PRIMARY KEY ,    # 기본키 등록
                                         grade_name VARCHAR(255) NOT NULL
) ENGINE = INNODB;

INSERT INTO user_grade
VALUES (10, '일반회원'),
       (20, '우수회원'),
       (30, '특별회원');

SELECT * FROM user_grade;

--

DROP TABLE IF EXISTS user_foreignkey;
CREATE TABLE IF NOT EXISTS user_foreignkey(
                                              user_no INT PRIMARY KEY ,
                                              user_id VARCHAR(255) NOT NULL ,
                                              user_pwd VARCHAR(255) NOT NULL,
                                              user_name VARCHAR(255) NOT NULL,
                                              gender VARCHAR(3),
                                              phone VARCHAR(255) NOT NULL,
                                              email VARCHAR(255),
                                              grade_code INT NOT NULL,    -- NOT NULL 주의
                                              FOREIGN KEY (grade_code)     -- 외래키
                                                  REFERENCES user_grade(grade_code)  -- 참조 대상 테이블
) ENGINE=INNODB;

INSERT INTO user_foreignkey
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
    (2, 'user02', 'pass02', '유관순', '여', '010-7777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_foreignkey;

-- grade_code INT NOT NULL 때문에 grade_code에 null을 넣으면 에러 (grade_code의 제약조건인 not null을 빼면 foreign key여도 null 값이 가능함)
INSERT INTO user_foreignkey
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
    (3, 'user01', 'pass01', '이순신', '남', '010-1234-5679', 'godofsea123@gmail.com', NULL)

-- ====================================================================================================================================================================================

DELETE FROM user_grade WHERE grade_code = 10 ;  -- user_grade 테이블에서 grade_code는 외래키 역할을 함. 부모 테이블에서 이걸 삭제하려면 그 전에 먼저 참조하고 있는 모든 자식 테이블의 값을 삭제한 후 진행해야 함

DROP TABLE IF EXISTS user_foreignkey;
CREATE TABLE IF NOT EXISTS user_foreignkey(
  user_no INT PRIMARY KEY ,
  user_id VARCHAR(255) NOT NULL ,
  user_pwd VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  grade_code INT,    -- NOT NULL 주의
  FOREIGN KEY (grade_code)     -- 외래키
   REFERENCES user_grade(grade_code)  -- 참조 대상 테이블
  #ON UPDATE SET NULL  -- 참조하는 부모 테이블의 기본 키(Primary Key)가 변경될 때, 해당 값을 참조하는 자식 테이블의 컬럼 값을 NULL로 설정 (외래키 제약조건) // ON DELETE SET NULL과 동시에 사용은 불가능
  ON DELETE SET NULL   -- 부모 테이블의 데이터가 삭제될 때, 해당 값을 참조하는 자식 테이블의 외래 키 값을 NULL로 설정하는 옵션 // ON UPDATE SET NULL과 동시에 사용은 불가능
) ENGINE=INNODB;

INSERT INTO user_grade VALUES (10, '일반회원');
INSERT INTO user_grade VALUES (20, '우수회원');
SELECT * FROM user_grade;

INSERT INTO user_foreignkey
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
    (2, 'user02', 'pass02', '유관순', '여', '010-7777-7777', 'yu77@gmail.com', 20);
SELECT * FROM user_foreignkey;

-- 1. 부모 테이블의 grade_code 수정 (ON UPDATE SET NULL)
UPDATE user_grade SET grade_code = 300 WHERE grade_code = 10;

-- 2. 부모 테이블의 행 삭제 (ON DELETE SET NULL)
DELETE FROM user_grade WHERE grade_code = 20;

-- ====================================================================================================================================================================

DROP TABLE user_foreignkey;
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
  ON UPDATE CASCADE   -- 부모 테이블의 키값을 바꿨을 떄 이를 참조하는 자식 테이블의 값도 바뀜
  ON DELETE CASCADE   -- 부모 테이블의 행을 삭제했을 때 이를 참조하는 자식 테이블의 행도 삭제됨
) ENGINE=INNODB;

INSERT INTO user_grade VALUES (20, '우수회원');

INSERT INTO user_foreignkey
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
    (2, 'user02', 'pass02', '유관순', '여', '010-7777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_grade;
SELECT * FROM user_foreignkey;

UPDATE user_grade SET grade_code = 300 WHERE grade_code = 10;  -- ON UPDATE CASCADE 덕분에 부모 테이블의 키값을 바꿨을 떄 이를 참조하는 자식 테이블의 값도 바뀜
DELETE FROM user_grade WHERE grade_code = 300;  -- ON DELETE CASCADE 덕분에 부모 테이블의 행을 삭제했을 때 이를 참조하는 자식 테이블의 행도 삭제됨

-- ================================================================================================================================================
-- CHECK
-- ================================================================================================================================================
-- CHECK 제약 조건 위반시 허용하지 않는다.
DROP TABLE IF EXISTS user_check;
CREATE TABLE IF NOT EXISTS user_check (
 user_no INT AUTO_INCREMENT PRIMARY KEY,
 user_name VARCHAR(255) NOT NULL,
 gender VARCHAR(5) CHECK(gender IN ('남', '여')),   -- gender 값은 '남' or '여'만 가능함
 age INT CHECK(age >= 19)                          -- 나이는 19세 이상만 가능함
) ENGINE=INNODB;
SHOW CREATE TABLE user_check;

SELECT * FROM information_schema.TABLE_CONSTRAINTS;  -- 제약조건들 확인하기

INSERT INTO user_check VALUES (null, '홍길동', '남', 22);
INSERT INTO user_check VALUES (null, '유관순', '여', 19);
INSERT INTO user_check VALUES (null, '안중근', '남성', 32);  -- '남'이 '남성'이라서 안됨
INSERT INTO user_check VALUES (null, '유승제', '남', 17);  -- 나이가 19세 미만이라 안됨
SELECT * FROM user_check;








