SELECT * FROM tbl_menu;

-- VIEW 생성
CREATE VIEW hansik AS
SELECT
    menu_code, menu_name, menu_price, category_code, orderable_status
FROM
    tbl_menu
WHERE
    category_code = 4;

-- 생성된 VIEW 조회
SELECT * FROM hansik;  -- 가상의 테이블이지만 DML 명령어가 가능함. 근데 거의 대부분 한 개 테이블에 대해서만 가능. 두개 이상의 테이블에 대해서는 거의 안됨
SELECT * FROM INFORMATION_SCHEMA.VIEWS;

-- 인라인뷰: 1회성 view

-- 수정 및 삭제: 가상의 테이블이지만 원본을 바꿀 수 있음
UPDATE hansik SET menu_name = '버터맛국밥', menu_price = 5700 WHERE menu_code = 8;
DROP VIEW hansik;

-- REPLACE도 가능함
CREATE OR REPLACE VIEW hansik AS
SELECT
    menu_code AS '메뉴코드', menu_name '메뉴명', category_name '카테고리명'
FROM
    tbl_menu a
        JOIN tbl_category b ON a.category_code = b.category_code
WHERE
    b.category_name = '한식';

SELECT * FROM hansik;