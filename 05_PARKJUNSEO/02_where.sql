-- ==============================
-- WHERE
-- ==============================

# WHERE 비교 연산자
-- 표현식 사이의 관계를 비교하기 위해 사용하고, 비교 결과는 논리 결과 중에 하나 (TRUE/FALSE/NULL)가 된다.
-- 단, 비교하는 두 컬럼 값/표현식은 서로 동일한 데이터 타입이어야 한다.

#   연산자                    설명
#   -------------------------------------------------------------------------------
#   =                        같다
#   >,<                      크다/작다
#   >=,<=                    크거나 같다/작거나 같다
#   <>,!=                    같지 않다 (^= 이런 거 없음)
#   BETWEEN AND              특정 범위에 포함되는지 비교 (A <= x <=B)
#   LIKE / NOT LIKE          문자 패턴 비교
#   IS NULL / IS NOT NULL    NULL 여부 비교
#   IN / NOT IN              비교 값 목록에 포함/미포함 되는지 여부 비교

# WHERE 논리 연산자
-- 여러 개의 제한 조건 결과를 하나의 논리결과로 만들어 줌 (&&,|| 사용불가)
-- AND &&    여러 조건이 동시에 TRUE일 경우에만 TRUE 값 반환
-- OR ||    여러 조건들 중에 어느 하나의 조건만 TRUE이면 TRUE값 반환
-- NOT !    조건에 대한 반대값으로 반환(NULL은 예외)
-- XOR        두 값이 같으면 거짓, 두 값이 다르면 참

-- [1. 비교연산자]
SELECT
       menu_name '메뉴 이름'
     , menu_price '가격'
     , orderable_status '주문 여부'
  FROM
       tbl_menu
WHERE
       orderable_status = 'N' ;

-- tbl_menu 테이블에서 가격이 13,000원인 메뉴이름, 메뉴가격, 주문여부 컬럼을 출력
SELECT
       menu_name
     , menu_price
     , orderable_status
  FROM
      tbl_menu
WHERE menu_price = 13000 ;

-- 같지 않을 연산자와 함께 WHERE절 사용
SELECT
       menu_name
     , menu_price
     , orderable_status
  FROM
       tbl_menu
WHERE
#      orderable_status <> 'Y'
#      orderable_status != 'Y'
#      orderable_status  = 'n'
       orderable_status  = 'N' ; /* MySQL은 비교나 검색을 수행할 때
                                기본적으로 대소문자 구분 없이 비교 및 검색이 가능함*/

-- 대소비교 연산자와 함께 WHERE절 사용
SELECT
       menu_name
     , menu_price
     , orderable_status
  FROM
       tbl_menu
WHERE
       menu_price > 20000 ;

SELECT
       menu_name
     , menu_price
     , orderable_status
FROM
       tbl_menu
WHERE
       menu_price <= 20000 ;

-- [2. AND 연산자와 함께 WHERE절 사용]
# 0은 FALSE, 0외의 숫자는 TRUE로 암시적 형변환 후 평가됨
# 문자열은 0으로 반환, FALSE로 평가
# NULL과의 연산결과는 NULL (0 && NULL 제외)

SELECT 1 AND 1, 2 && 2, -1 && 1 && 'abc';
SELECT 1 AND 0;
SELECT 0 AND 1; # 이게 더 연산이 빠름 (and는 false가 하나라도 있으면 false니까)
SELECT 1 AND 0, 0 AND 1, 0 AND 0, 0 AND NULL;  # 0 AND NULL은 0
SELECT 1 AND NULL; # NULL
SELECT 1 AND NULL, NULL AND NULL ;
SELECT 1 + NULL, 1 - NULL, 1 * NULL, 1 / NULL, 1 / 0; # NULL

-- 메뉴 테이블에서 주문여부가 Y이면서, 카테고리 코드가 10인 메뉴 목록을 조회
SELECT
       menu_price
     , menu_price
     , category_code
     , orderable_status
  FROM
       tbl_menu
WHERE
       orderable_status = 'Y'
  AND
       category_code = 10;

-- 메뉴 테이블에서 메뉴가격이 5000원보다 크고, 카테고리 코드가 10인 메뉴를 출력해주세요
-- 단, 컬럼은 메뉴코드, 메뉴이름, 메뉴가격, 카테고리코드, 주문여부만 출력
SELECT
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM
       tbl_menu
WHERE
       menu_price > 5000
  AND
       category_code = 10;

-- [3. OR 연산자와 함께 WHERE절 사용]
SELECT 1 OR 1, 1 OR 0, 0 OR 1;   # or의 경우 1 or 0이 더 빠름
SELECT 0 OR 0;
SELECT 1 OR NULL;
SELECT 0 OR NULL, NULL OR NULL; # NULL이 나옴

-- 메뉴 테이블에서 메뉴가격이 5000원보다 크거나 카테고리 코드가 10인 메뉴를 출력해주세요
-- 단, 컬럼은 메뉴코드, 메뉴이름, 메뉴가격, 카테고리코드, 주문여부만 출력
SELECT
       menu_code
     , menu_price
     , category_code
     , orderable_status
FROM
       tbl_menu
WHERE
       menu_price > 5000
  OR
       category_code = 10;

-- 우선순위
-- 나열한 AND랑 OR 중에서 AND의 우선순위가 높다. (AND 먼저 연산한다는 뜻)
SELECT 1 OR 0 AND 0;
SELECT (1 OR 0) AND 0; # 괄호 먼저 연산 -> 0이 나옴

-- 카테고리 번호가 4 또는 가격이 9000원이면서 메뉴 번호가 10보다 큰 메뉴를 조회하시오.
-- 모든 칼럼을 조회
SELECT
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM
       tbl_menu
WHERE
       category_code = 4
   OR
       menu_price = 9000
   AND
       menu_code > 10;

-- [4. BETWEEN 연산자]
# 숫자, 문자열, 날짜/시간 값의 범위 안에 있다면 TRUE를 반환하는 연산자
SELECT
        menu_name
      , menu_price
      , category_code
  FROM
        tbl_menu
 WHERE
        menu_price >= 10000
   AND
        menu_price <= 25000;
# 이걸 BETWEEN 연산자를 활용하여 더 간단하게 작성할 수 있음
SELECT
       menu_name
     , menu_price
     , category_code
FROM
       tbl_menu
WHERE
       menu_price  BETWEEN 10000 AND 25000;
# 우선순위에 따라 BETWEEN을 쓸지 말지 결정 (가독성면에서도)

-- 사전 등재순으로 문자열 비교 가능
SELECT
       menu_name
     , menu_price
     , category_code
FROM
    tbl_menu
WHERE
       menu_name  BETWEEN '가' AND '마'
ORDER BY
       menu_price;

-- BETWEEN 부정도 가능함
SELECT
       menu_name
     , menu_price
     , category_code
FROM
       tbl_menu
WHERE
       menu_price NOT BETWEEN 10000 AND 25000;


-- [5. LIKE 연산자]

-- 비교하려는 값이 지정한 특정 패턴을 만족시키면 TRUE를 리턴하는 연산자로 '%', ''를 와일드카드로 사용할 수있다.

-- 와일드카드란? 다른 문자로 대체가능한 특수한 의미를 가진 문자
-- 1. '%' 글자가 없든지, 글자가 1개 이상 여러개를 의미한다.
-- 2. 개수에 따라 문자 1개를 의미한다 _가 3개라면 문자 3개를 의미한다.

-- %의 위치에 따라서 검색
-- %문자     : 문자로 끝나는 내용만
-- 문자%     : 문자로 시작하는 내용만
-- %문자%    : 문자가 포함되어 있는 내용만

SELECT
        menu_name
      , menu_price
  FROM
        tbl_menu
WHERE
        menu_name LIKE '%마늘%' ;  # 따옴표 쓰기

--

SELECT
       menu_name
     , menu_price
FROM
       tbl_menu
WHERE
       menu_name LIKE '마%' ;

--

SELECT
       menu_name
     , menu_price
FROM
       tbl_menu
WHERE
       menu_name LIKE '%밥' ;

-- 주스 앞글자가 6글자인 메뉴 조회
-- 앞에 원하는 글자가 너무 많아지면 그만큼 _를 다 쳐야하지만, 보통 문자열을 잘라서 중요한 문자열만 사용함
SELECT
       menu_name
     , menu_price
FROM
       tbl_menu
WHERE
       menu_name LIKE '______쥬스' ;

--

SELECT
       menu_name
     , menu_price
FROM
       tbl_menu
WHERE
       menu_name LIKE '%갈치%' ;

-- 갈치가 포함된 문자열 제외
SELECT
    menu_name
     , menu_price
FROM
    tbl_menu
WHERE
    menu_name NOT LIKE '%갈치%' ;

-- IN 연산자
# OR와 비슷함
# BETWEEN AND
# IN OR
-- ex) 카테고리 코드가 4, 5, 6인 메뉴를 조회하세요.
SELECT
        menu_name
      , category_code
  FROM
        tbl_menu
 WHERE
        category_code = 4
    OR
        category_code = 5
    OR
        category_code = 6;

-- IN 활용
SELECT
       menu_name
     , category_code
FROM
       tbl_menu
WHERE
       category_code IN (4, 5, 6);

-- 부정 가능
SELECT
       menu_name
     , category_code
FROM
       tbl_menu
WHERE
       category_code NOT IN (4, 5, 6);

-- IS NULL (NULL인 것만)
SELECT
        category_code
      , category_name
      , ref_category_code
  FROM
        tbl_category
 WHERE
        ref_category_code IS NULL;

-- NULL 처리 함수를 통해서 찾을 수 있음
-- IFNULL(표현식, 값): NULL인 애를 '값'으로 바꿈
SELECT
       category_code
     , category_name
     , ref_category_code
 FROM
       tbl_category
WHERE
       IFNULL(ref_category_code, 0) = 0;  # NULL인 애들을 0으로 바꾸었을 때, IFNULL이 0인 애들

-- 이런 것도 가능함 (NULL이면 0으로 표기해서 IFNULL이라는 새로운 칼럼 형성)
SELECT
       category_code
     , category_name
     , ref_category_code
     , IFNULL(ref_category_code, 0)
FROM
       tbl_category;

--
SELECT
       category_code
     , category_name
     , ref_category_code
     , IFNULL(ref_category_code, 0)
FROM
       tbl_category
WHERE
       IFNULL(ref_category_code, 0) = 0; # IFNULL이라는 컬럼이 0인 애들만 출력

--
SELECT
       category_code
     , category_name
     , ref_category_code
     , IFNULL(ref_category_code, 0)
  FROM
       tbl_category
 WHERE
       COALESCE(ref_category_code, 0) = 0; # IFNULL이랑 같음

-- 부정표현
SELECT
       category_code
     , category_name
     , ref_category_code
  FROM
       tbl_category
 WHERE
       ref_category_code IS NOT NULL;

-- 실습문제
-- tbl_escape_watch 테이블에서 description 컬럼에 99.99라는 글자가 들어가있는 행만 추출하세요
# escape 문자: \%, \", \' 등등
create table tbl_escape_watch(
                                watchname varchar(40),
                                description varchar(200)
);
insert into tbl_escape_watch values('금시계', '순금 99.99% 함유 고급시계');
insert into tbl_escape_watch values('은시계', '고객 만족도 99.99점를 획득한 고급시계');

SELECT
        watchname
      , description
  FROM
        tbl_escape_watch
 WHERE
        description like '%99.99\%%';
