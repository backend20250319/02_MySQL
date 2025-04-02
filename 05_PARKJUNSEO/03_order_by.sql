-- ------------------------------------------
-- ORDER BY
-- ------------------------------------------
-- RESULTSET 행에 대해 정렬을 할 때 사용하는 구문
-- SELECT 구문의 가장 마지막에 작성하며, 실행순서도 가장 마지막에 수행된다.

/*
SELECT
       컬럼1,컬럼2,컬럼3...
  FROM
       테이블명
 WHERE
       조건절
ORDER BY
       컬럼명|별칭|컬럼순서 정렬방식[NULLS FIRST | LAST] -- LAST 기본값

 */
/*
데이터 정렬 방법
--------------------------------------------------------------------------------------------------------
       NUMBER              CHARACTER              DATE                        NULL
---------------------------------------------------------------------------------------------------------
 ASC    작은수 -> 큰수         사전수            빠른날 -> 늦은날                 맨아래 행
                                                                      (NULL 값이 맨 아래로감)
 DESC   큰수 -> 작은수         사전역순          늦은날 -> 빠른날                 맨 위 행
                                                                      (NULL 값이 맨 위로감)
----------------------------------------------------------------------------------------------------------*/

SELECT
       menu_code
     , menu_name
     , menu_price
  FROM
       tbl_menu
 ORDER BY
    -- menu_price ASC;
    -- menu_price; (default는 ASC라서 생략 가능함)
       menu_price DESC;

-- ORDER BY 절을 사용하여 결과 집합을 여러 열로 정렬
SELECT
        menu_code
      , menu_name
      , menu_price
  FROM
        tbl_menu
 ORDER BY
        menu_price DESC, menu_name ASC; # 가격으로 먼저 내림차순 정렬 후 가격이 같으면 이름별로 오름차순 정렬

--

SELECT
       menu_code  -- 1
     , menu_name  -- 2
     , menu_price -- 3
FROM
       tbl_menu
ORDER BY
       3 DESC; -- menu_price가 3번이니까 menu_price를 기준으로 내림차순 한다는 뜻

-- 별칭으로 지정해서 정렬
SELECT
       menu_code  AS "메뉴코드"
     , menu_name  메뉴명
     , menu_price "메뉴 가격"
FROM
       tbl_menu
ORDER BY
       "메뉴 가격" DESC;

-- ORDER BY절을 사용하여 연산결과로 결과집합 정렬
SELECT
       menu_code  메뉴코드
     , menu_name  메뉴명
     , menu_code * menu_price 결과
FROM
       tbl_menu
ORDER BY
       3 DESC ;

-- FIELD(검색할 문자열, target1, target2, ...) : 검색문자열과 일치하는 타겟의 인덱스 반환
SELECT FIELD('A', 'A','B','C');  -- 1
SELECT FIELD('B', 'A', 'B', 'C'); -- 2

--

SELECT
       FIELD(orderable_status, 'Y', 'N')
  FROM
       tbl_menu;

-- ORDER BY 절을 사용하여 사용자 지정 목록을 활용한 데이터 정렬

SELECT
       menu_name
     , orderable_status
  FROM
       tbl_menu
 ORDER BY
       FIELD(orderable_status, 'Y', 'N');

-- NULL
-- 오름차순 시 NULL값은 맨 위에 온다 (DEFAULT)
-- 내림차순 시 NULL값은 맨 밑에 온다 (DEFAULT)

SELECT
        category_code
      , category_name
      , ref_category_code
  FROM
        tbl_category
 ORDER BY
        # ref_category_code;
        ref_category_code DESC ;

-- 오름차순 시 NULL 마지막
SELECT
       category_code
     , category_name
     , ref_category_code
  FROM
    tbl_category
 ORDER BY
#     ref_category_code IS NULL ASC;
       ref_category_code IS NULL;  # IS NULL은 NULL인 값을 찾아서 올려주는 건데, 이걸 오름차순으로 해버리니 마지막으로 가는 것임

-- 내림차순 시 NULL 마지막
SELECT
       category_code
     , category_name
     , ref_category_code
  FROM
       tbl_category
ORDER BY
       ref_category_code DESC;

-- 내림차순 시 NULL 처음
SELECT
       category_code
     , category_name
     , ref_category_code
  FROM
       tbl_category
 ORDER BY
       ref_category_code IS NULL DESC;  # IS NULL은 NULL인 값을 찾아서 올려주는 건데, 이걸 내림차순으로 해버리니 처음으로 가는 것임



