-- =======================================
-- DQL
-- =======================================
-- DML 하위 분류
-- Data Query Language 데이터 질의 언어
-- 테이블의 데이터를 검색/조회하는 명령어
-- 조회결과를 ResultSet (결과집합)이라 하면, 0행이상을 가질 수 있다.
-- 특정테이블, 특정행, 시각화할 컬럼, 정렬방식등을 선택할 수 있다.


/*
      DQL 구조
    SELECT 컬럼명    (5) -- 필수
      FROM 테이블명  (1) -- 필수
     WHERE 조건절(필터링) (2)
     GROUP BY 그룹핑 (3)
     HAVING 조건절(그룹핑에 대해 필터링) (4)
     ORDER BY 정렬기준 (6)


SELECT : 조회하고자 하는 컬럼명을 기술한다. 여러 개를 기술하고자 하면
             쉼표(,)로 구분하고 모든 컬럼 조회시 '*'을 사용
FROM   : 조회 대상 컬럼이 포함된 테이블명을 기술
WHERE  :
          행을 선택하는 조건을 기술한다.
          여러 개의 제한 조건을 포함할수 있으며, 각각의 제한 조건은 논리
          연산자로 연결한다.
          제한 조건을 만족시키는 행들만 ResultSet에 포함된다.
ORDER BY : 정렬한 컬럼을 기준으로 오름(ASC)/내림차순(DESC) 지정
*/

SELECT * FROM tbl_menu;

SELECT
        menu_code
    ,   menu_name
    ,   menu_price
    ,   category_code
    ,   orderable_status
    FROM tbl_menu;

SELECT
        category_code
    ,   category_name
    ,   ref_category_code
    FROM tbl_category;

SELECT menu_name
     , category_name
FROM tbl_menu
         JOIN tbl_category 1..n<->1:
ON tbl_menu.category_code = tbl_category.category_code;


SELECT 7 + 3;

SELECT 10 * 2;
SELECT 6% 3,  6 % 4;
SELECT CONCAT('유', '', '관순');

SELECT CONCAT('메뉴 이름은', menu_name, '이고, 가격은'
        ,menu_price, '원 입니다')
    FROM tbl_menu;

SELECT  7 + 3 AS '합';
SELECT now() '현재시간'; -- 별칭을 달 때 별칠에 특수기호나 칸띄우기가 필요하면싱글퀘테이션을
                        -- 반드시 추가한다

-- 리터럴(값)
-- 임의로 지정한 문자열은 SELECT 절에 사용하면, 테이블에 존재하는 데이터처럼 사용할 수 있다.
-- 문자 혹은 날짜 리터럴은 '' 기호를 사용해야한다.
-- 리터럴은 ResultSet의 모든 행에 반복표시 된다.
SELECT
        menu_name 메뉴이름,
        menu_price + (menu_price * .1) AS "부가세포함 가격" ,
        '원'
    FROM tbl_menu
ORDER BY 2 DESC;

-- DISTINCT
-- 컬럼에 포함된 중복 값을 한번씩만 표시하고자 할 때 사용
-- SELECT문에 한번만 사용가능하고, 여러 컬럼에 대해서 사용하면,
-- 두 컬럼값에 대해 중복값을 제거한다.

-- 단일 열 DISTINCT
SELECT
        DISTINCT tbl_menu.category_code
    FROM tbl_menu;

-- NULL값을 포함한 열의 DISTINCT
SELECT
        DISTINCT tbl_category.ref_category_code
    FROM tbl_category;

-- 열이 여러개인 DISTINCT
SELECT
        DISTINCT category_code
       , orderable_status
    FROM tbl_menu;
