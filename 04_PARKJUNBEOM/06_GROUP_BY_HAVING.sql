-- =============================
-- GROUP BY
-- =============================
-- 별도의 그룹지정없이 사용한 그룹함수(SUM,AVG,COUNT,MIN,MAX)는 전체를 하나의 그룹으로 처리한다.
-- 세부적인 그룹지정을 위해서는 group by절을 이용한다.
-- 메뉴가 존재하는 카테고리 그룹 조회
-- 같은 카테고리_코드를 가진 메뉴끼리 하나의 그룹으로 처리된다.
-- 일반 컬럼을 조회해도 해당 그룹의 첫번째 컬럼값만 반환한다.

SELECT
      category_code
    , COUNT(*)
FROM tbl_menu
GROUP BY
      category_code; -- COUNT 함수를 활용해서 카테고리별 메뉴 개수 조회

-- AVG 함수 활용
-- 카테고리별 메뉴 가격 평균
SELECT
      category_code
    , AVG(menu_price)
FROM
      tbl_menu
GROUP BY
      category_code;

-- 2개 이상의 그룹 생성
SELECT
      category_code
    , menu_price
    , AVG(menu_price)
FROM
      tbl_menu
GROUP BY
      category_code, menu_price;

-- =========================
-- HAVING
-- =========================
-- group by로 정해진 그룹에 대해 조건을 설정할 때는 HAVING절에 기술한다.
-- 같은 조건절이지만 WHERE절에는 그룹함수 사용이 불가하다.
SELECT
      category_code
    , COUNT(*)
FROM
      tbl_menu
GROUP BY
      category_code
HAVING
      COUNT(*) > 1;

-- 그룹함수는 WHERE절에서 호출이 불가
# SELECT
#     category_code
#      , COUNT(*)
# FROM
#     tbl_menu
# HAVING
#     COUNT(*) > 1
# GROUP BY
#     category_code;

-- ==============================
-- ROLLUP
-- ==============================
-- 컬럼 한 개를 활용한 ROLLUP(카테고리별 총합)
SELECT category_code
     , SUM(menu_price)
FROM tbl_menu
Group By category_code
WITH ROLLUP;

SELECT
       category_code
     , menu_price
     , SUM(menu_price)
FROM
       tbl_menu
Group By
       category_code
     , menu_price
WITH ROLLUP;