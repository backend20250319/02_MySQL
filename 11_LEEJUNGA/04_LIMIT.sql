-- ==============================
-- LIMIT
-- ==============================
-- LIMIT 절은 SELECT문의 결과 집합에서 반환할 행의 수를 제한하는데 사용된다.
-- Top-n분석, 페이징 처리에 응용할 수 있다.

# LIMIT [offset,] row_count;
-- offset : 시작할 행의 번호(인덱스 체계)
-- row_count : 이후 행부터 반환 받을 행의 개수

-- 전체 행 조회
SELECT
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY
    menu_price DESC;

-- 2번행부터 5번행까지 조회
SELECT
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY
    menu_price DESC
LIMIT 1, 5;

-- 상위 다섯줄의 행만 조회
SELECT
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY
    menu_price DESC,
    menu_name ASC
LIMIT 5;

-- 페이징 처리
-- 1페이지
SELECT
    *
FROM
    tbl_menu
ORDER BY
    menu_code ASC
LIMIT 0, 5;

-- 2페이지
SELECT
    *
FROM
    tbl_menu
ORDER BY
    menu_code ASC
LIMIT 5, 5;