# -- =================================
# -- BUILT IN FUNCTIONS
# -- =================================
# -- 하나의 큰 프로그램에서 반복적으로 사용되는 부분들을 분리하여 작성해 놓은 작은 서브 프로그램으로, 호출하며 값을 전달하면
# -- 수행결과를 리턴하는 방식으로 사용된다.
# -- 호출(값 전달) -> 작업 수행 -> 결과값 리턴
#
# API Doc
# -- https://dev.mysql.com/doc/refman/8.0/en/built-in-function-reference.html
# -- https://www.w3schools.com/mysql/mysql_ref_functions.asp
#
# 함수의 유형
# -- 단일행처리 함수 : 각 행마다 반복 호출되어서 호출된 수만큼 결과를 리턴한다.
# -- 1. 문자처리 함수
# -- 2. 숫자처리 함수
# -- 3. 날짜시간처리 함수
# -- 4. 기타함수
# -- 그룹함수 : 여러행들이 그룹으로 형성되어 적용된다. 그룹당 1개의 결과를 리턴한다.

-- =====================================
-- 문자처리함수
-- =====================================

-- ASCII(아스키 코드), CHAR(숫자)
-- ASCII: 아스키 코드값 추출
-- CHAR : 아스키 코드로 문자 추출
SELECT ASCII('A'), CHAR(65);

-- BIT_LENGTH(문자열), CHAR_LENGTH(문자열), LENGTH(문자열)
-- BIT_LENGTH: 할당된 비트 크기 반환
-- CHAR_LENGTH: 문자열의 길이 반환
-- LENGTH: 할당된 BYTE 크기
SELECT
    menu_name,
    BIT_LENGTH(menu_name),
    CHAR_LENGTH(menu_name),
    LENGTH(menu_name)
FROM
    tbl_menu;

-- CONCAT(문자열1, 문자열2, ...), CONCAT_WS(구분자, 문자열1, 문자열2, ...)
-- CONCAT: 문자열을 이어붙임
-- CONCAT_WS: 구분자와 함께 문자열을 이어붙임
SELECT CONCAT('호랑이', '기린', '원숭이');
SELECT CONCAT_WS(',','호랑이', '기린', '원숭이');
SELECT CONCAT_WS('-','2025', '03', '21');

-- ELT(위치, 문자열1, 문자열2, ...), FIELD(찾을 문자열, 문자열1, 문자열2, ...)
-- FIELD: 찾을 문자열 위치 반환
-- ELT: 해당 위치의 문자열 반환
SELECT
    ELT(2, '사과', '딸기', '바나나'), -- 딸기
    FIELD('딸기', '사과', '딸기', '바나나'); -- 2

-- FIND_IN_SET(찾을 문자열, 문자열 리스트)
-- FIND_IN_SET: 찾을 문자열의 위치 반환, 문자열 리스트의 구분자는 반드시 ,여야 한다.
SELECT  FIND_IN_SET('바나나', '사과,딸기,바나나'); -- 3

-- ORDER BY에서 특정 레코드를 끌어올리기 위한 용도로 사용할 수 있다.
SELECT * FROM tbl_menu ORDER BY FIND_IN_SET(menu_code, 12) DESC, FIND_IN_SET(menu_code, 16) DESC; -- 광고 맨 위에 띄워주는 느낌

-- INSTR(기준 문자열, 부분 문자열)
-- INSTR: 기준 문자열에서 부분 문자열의 시작 위치 반환

-- LOCATE(부분 문자열, 기준 문자열)
-- LOCATE: INSTR과 동일하고 순서는 반대

SELECT
    INSTR('사과딸기바나나', '딸기'),
    LOCATE('딸기', '사과딸기바나나');

-- FORMAT(숫자, 소수점 자릿수)
-- FORMAT: 1000단위마다 콤마(,) 표시를 해 주며 소수점 아래 자릿수(반올림)까지 표현한다.
-- FORMAT(number, decimal_places)
SELECT FORMAT(123412341234.4523, 5);

SELECT
    menu_code,
    FORMAT(menu_price, 0) "단위"
FROM
    tbl_menu;

-- INSERT(기준 문자열, 위치, 길이, 삽입할 문자열)
-- INSERT: 기준 문자열의 위치부터 길이만큼을 지우고 삽입할 문자열을 끼워 넣는다.
SELECT INSERT('내 이름은 아무개 입니다.', 7, 3, '홍길동'); -- 내 이름은 홍길동 입니다.

SELECT INSTR(menu_name, '쥬스'),
       INSERT(menu_name, INSTR(menu_name, '쥬스'), 2, 'JUICE')
FROM tbl_menu
WHERE menu_name LIKE '%쥬스%';

-- LEFT(문자열, 길이), RIGHT(문자열, 길이)
-- LEFT: 왼쪽에서 문자열의 길이만큼을 반환
-- RIGHT: 오른쪽에서 문자열의 길이만큼을 반환
SELECT LEFT('HELLO World', 4), RIGHT('Hello World', 5);

-- UPPER(문자열), LOWER(문자열)
-- UPPER: 소문자를 대문자로 변경
-- LOWER: 대문자를 소문자로 변경
SELECT LOWER('Hello World'), UPPER('Hello World');

-- LPAD(문자열, 길이, 채울 문자열), RPAD(문자열, 길이, 채울 문자열)
-- LPAD: 문자열을 길이만큼 왼쪽으로 늘린 후에 빈 곳을 문자열로 채운다.
-- RPAD: 문자열을 길이만큼 오른쪽으로 늘린 후에 빈 곳을 문자열로 채운다.
SELECT LPAD('왼쪽', 6, '@');
SELECT RPAD('오른쪽', 6, '@');
-- 881122-1******
SELECT RPAD('881122-1', 14, '*');

-- LTRIM(문자열), RTRIM(문자열)
-- LTRIM: 왼쪽 공백 제거
-- RTRIM: 오른쪽 공백 제거
SELECT LTRIM('     왼쪽'), RTRIM('오른쪽      ');

-- TRIM(문자열), TRIM(방향 자를_문자열 FROM 문자열)
-- TRIM은 기본적으로 앞뒤 공백을 제거하지만
-- 방향(LEADING(앞), BOTH(양쪽), TRAILING(뒤))이 있으면
-- 해당 방향에 지정한 문자열을 제거할 수 있다.
SELECT TRIM('      MYSQL   '), TRIM(BOTH '@' FROM '@@@@@MYSQL@@@@');

-- REPEAT(문자열, 횟수)
-- REPEAT: 문자열을 횟수만큼 반복
SELECT REPEAT('재밌어1 ', 100);

-- REPLACE(문자열, 찾을 문자열, 바꿀 문자열)
-- REPLACE: 문자열에서 문자열을 찾아 치환
SELECT  REPLACE('마이SQL', '마이', 'My');

-- REVERSE(문자열)
-- REVERSE: 문자열의 순서를 거꾸로 뒤집는다.
SELECT REVERSE('stressed');

-- SPACE(길이)
-- SPACE: 길이만큼의 공백을 반환
SELECT CONCAT('제 이름은', SPACE(5), '이고, 나이는 ', SPACE(3), '세입니다. ')  나이소개;

-- SUBSTRING(문자열, 시작위치, 길이)
-- SUBSTRING: 시작 위치부터 길이만큼의 문자를 반환(길이를 생략하면 시작 위치부터 끝까지 반환)
SELECT
    SUBSTRING('안녕하세요 반갑습니다.', 7, 6),
    RPAD(SUBSTRING('881122-1234567', 1, 8), 14, '*'),
    SUBSTRING('안녕하세요 반갑습니다.', 3);

-- =================================
-- 숫자처리함수
-- =================================
-- ABS(숫자)
-- ABS: 절대값 반환
SELECT ABS(-123), ABS(123);

-- CEILING(숫자), FLOOR(숫자), ROUND(숫자)
-- CEILING: 올림값 반환
-- FLOOR: 내림값(현재수보다 작은 최대정수) 반환
-- TRUNCATE(숫자, 소수점이하 자리수): 버림값 반환. 소수점이하 자리수는 필수이다.
-- ROUND: 반올림값 반환
SELECT CEILING(123.56), FLOOR(1234.56), FLOOR(-0.65);
SELECT ROUND(1234.56), ROUND(1234.567, 2), TRUNCATE(1234.56, 1), TRUNCATE(-0.65, 0);


-- MOD(숫자1, 숫자2) 또는 숫자1 % 숫자2 또는 숫자1 MOD 숫자2
-- MOD: 숫자1을 숫자 2로 나눈 나머지 추출
SELECT MOD(75, 10), 75 % 10, 75 MOD 10;

-- POW(숫자1, 숫자2), SQRT(숫자)
-- POW: 거듭제곱값 추출
-- SQRT: 제곱근을 추출
SELECT
    POW(2, 4), SQRT(16);

-- RAND()
-- RAND: 0이상 1미만의 실수를 구한다.
-- m <= 임의의정수 < n
-- FLOOR((RAND() * (n - m) + m)을 사용
-- 1부터 10까지 난수 발생 : FLOOR(RAND() * 10 + 1)
SELECT(FLOOR((RAND() * 10) + 1));
SELECT RAND(), FLOOR(RAND() * 10 + 1);

-- =======================================
-- 날짜시간처리함수
-- =======================================
-- ADDDATE(날짜, 일수), SUBDATE(날짜, 일수)
-- ADDDATE(날짜, INTERVAL N 단위), SUBDATE(날짜, INTERVAL N 단위일)
-- 위 두가지 문법을 지원한다.
-- ADDDATE: 날짜를 기준으로 차이를 더함
-- SUBDATE: 날짜를 기준으로 날짜를 뺌
-- https://www.w3schools.com/sql/func_mysql_adddate.asp
-- 지원하는 날짜/시간 단위

SELECT NOW(), ADDDATE(NOW(), 1), SUBDATE(NOW(), 1);
SELECT ADDDATE('2025-03-21', INTERVAL 30 DAY), ADDDATE('2025-03-21', INTERVAL 5 MONTH);
SELECT SUBDATE('2025-03-21', INTERVAL 30 DAY), SUBDATE('2025-03-21', INTERVAL 5 MONTH);
SELECT ADDDATE('2025-03-21', INTERVAL -1 MONTH);
SELECT SUBDATE('2025-03-21', INTERVAL -1 MONTH);

-- ADDTIME(날짜/시간, 시간), SUBTIME(날짜/시간, 시간)
-- ADDTIME: 날짜 또는 시간을 기준으로 시간을 더함
-- SUBTIME: 날짜 또는 시간을 기준으로 시간을 뺀다
-- 년월일은 더하거나 뺄 수 없다.
SELECT ADDTIME('2024-03-21 15:19:00', '1:0:1'), SUBTIME('2024-03-21 15:19:00', '4:0:1');

-- CURDATE(), CURTIME(), NOW(), SYSDATE()
-- CURDATE: 현재 연-월-일 추출
-- CURTIME: 현재 시:분:초 추출
-- NOW() 또는 SYSDATE() : 현재 연-월-일 시:분:초 추출
SELECT
    CURDATE(),
    CURTIME(),
    NOW(),
    SYSDATE();

-- CURDATE(), CURRENT_DATE(), CURRENT_DATE는 동일
SELECT CURDATE(), CURRENT_DATE(), CURRENT_DATE;

-- CURTIME(), CURRENT_TIME(), CURRENT_TIME은 동일
SELECT CURTIME(), CURRENT_TIME(), CURRENT_TIME;

-- NOW(), LOCALTIME(), LOCALTIME, LOCALTIMESTAMP(), LOCALTIMESTAMP는 동일
SELECT NOW(), LOCALTIME(), LOCALTIME, LOCALTIMESTAMP(), LOCALTIMESTAMP;

-- YEAR(날짜), MONTH(날짜), DAY(날짜),
-- HOUR(시간), MINUTE(시간), SECOND(시간), MICROSECOND(시간)
-- 날짜 또는 시간에서 연, 월, 일, 시, 분, 초, 밀리초를 추출
SELECT YEAR(CURDATE()), MONTH(CURDATE()), DAY(CURDATE());
SELECT HOUR(CURTIME()), MINUTE(CURTIME()), SECOND(CURTIME()), MICROSECOND(CURTIME());

-- DATE(), TIME()
-- DATE: 연-월-일만 추출
-- TIME: 시:분:초만 추출
SELECT DATE(NOW()), TIME(NOW());

-- DATEDIFF(날짜1, 날짜2), TIMEDIFF(날짜1 또는 시간1, 날짜1 또는 시간2)
-- DATEDIFF: 날짜1 - 날짜2의 일수를 반환
-- TIMEDIFF: 시간1 - 시간2의 결과를 구함
SELECT
    DATEDIFF('2025-02-21', NOW()), TIMEDIFF('18:00:00', '15:32:12');
SELECT
    DATEDIFF('2025-09-09', NOW());

-- EXTRACT(UNIT FROM 날짜시간
SELECT EXTRACT(YEAR_MONTH FROM NOW());
SELECT EXTRACT(YEAR FROM NOW());
SELECT EXTRACT(YEAR FROM NOW());
SELECT EXTRACT(DAY FROM NOW());
SELECT EXTRACT(DAY_HOUR FROM NOW()); -- HOUR, DAY_HOUR은 동일
SELECT EXTRACT(MINUTE FROM NOW());
SELECT EXTRACT(SECOND FROM NOW());
SELECT EXTRACT(MICROSECOND FROM '2025-03-21 15:00:00.1111122222');

-- DAYOFWEEK(날짜), MONTHNAME(), DAYOFYEAR(날짜)
-- DAYOFWEEK: 요일 반환(1이 일요일)
-- MONTHNAME: 해당 달의 이름 반환
-- DAYOFYEAR: 해당 년도에서 몇 일이 흘렀는지 반환
-- 일월화수목금토
SELECT DAYOFMONTH(CURDATE()), MONTHNAME(CURDATE()), DAYOFYEAR(CURDATE());

-- LAST_DAY(날짜)
-- LAST_DAY: 해당 날짜의 달에서 마지막 날의 날짜를 구한다.
SELECT LAST_DAY('20020601');

-- QUARTER(날짜)
-- QUARTER: 해당 날짜의 분기를 구함
SELECT QUARTER('2025-10-21');

-- DATE_FORMAT(날짜, 형식)
-- https://www.w3schools.com/mysql/func_mysql_date_format.asp
-- https://dev.mysql.com/doc/refman/8.0/en/locale-support.html Locale Support
SELECT
    NOW(),
    DATE_FORMAT(NOW(), '%y-%m-%d') 년월일,
    DATE_FORMAT(NOW(), '%H:%i:%s') 시분초,
    DATE_FORMAT(NOW(), '%Y/%m/%d(%W)')
;
-- %w 일요일(0) ~ 토요일(6) 숫자반환


-- =================================
-- 형변환함수
-- =================================
-- 숫자 -> 문자 FORMAT
-- 날짜/시간 -> 문자 DATE_FORMAT

# 명시적 형변환(Explicit Conversion)
-- CAST (expression AS 데이터형식 [(길이)])
-- CONVERT (expression, 데이터형식 [(길이)])
-- 데이터 형식으로 가능한 것은 BINARY, CHAR, DATE, DATETIME, DECIMAL, JSON, SIGNED INTEGER, TIME, UNSIGNED INTEGER 등이 있다.

SELECT AVG(menu_price) FROM tbl_menu;
SELECT CAST(AVG(menu_price) AS SIGNED INTEGER) '평균 메뉴 가격' FROM tbl_menu;
SELECT CONVERT(AVG(menu_price), SIGNED INTEGER) '평균 메뉴 가격' FROM tbl_menu;
SELECT CAST('2025$5$30' AS DATE);
SELECT CAST('2025/5/30' AS DATE);
SELECT CAST('2025%5%30' AS DATE);
SELECT CAST('2025@5@30' AS DATE);

-- 메뉴의 가격을 출력하는데 원을 붙여서 출력
SELECT CONCAT(CAST(menu_price AS CHAR(5)), '원') FROM tbl_menu;

# 암시적 형변환(Implicit Conversion)
SELECT
    '1' + '2';

SELECT
    CONCAT(menu_price, '원')
FROM
    tbl_menu; -- menu_price가 문자로 변환된다.

SELECT 3 > 'MAY'; -- 문자는 0으로 변환된다.
SELECT 5 > '6MAY', '6MAY' + 1;
SELECT ADDDATE('2025-03-11', 1); -- 날짜형으로 바뀔 수 있는 문자는 DATE형으로 변환된다.


-- ==========================
-- 기타함수
-- ==========================

# null 처리함수
-- IFNULL(EXPRESSION, NULL일때 대체값
SELECT IFNULL(null, 'Hello World'), IFNULL('ㅋㅋㅋㅋㅋㅋㅋ', 'Hello World');

-- IF + ISNULL
SELECT
    ISNULL(null),
    IF(ISNULL(null), '이름없음', '이름있음') as NAME;

-- IF
-- IF(조건, '조건이 일치할 경우의 값', '조건이 일치하지 않을 경우의 값')
SELECT
    menu_name,
    IF(orderable_status = 'Y', '주문가능', '주문불가')
FROM tbl_menu;


# 선택함수 case
# 여러 가지 경우에 선택을할 수 있는 기능을 제공함 (범위값도 가능)
# 작성법                               리턴값 타입
# ----------------------------------------------------------------------------------------------
# (타입1)
# CASE WHEN 조건1 THEN 결과1
# WHEN 조건2 THEN 결과2                    결과
# WHEN 조건3 THEN 결과3
# ELSE 결과
# END
# (타입2)
# CASE 표현식
# WHEN 값1 THEN 결과1
# WHEN 값2 THEN 결과2
# WHEN 값3 THEN 결과3
# ELSE 결과
# END

SELECT
    menu_name,
    menu_price,
    CASE
        WHEN menu_price < 5000 THEN '싼거'
        WHEN menu_price BETWEEN 5000 AND 10000 THEN '적당'
        WHEN menu_price BETWEEN 10000 AND 20000 THEN '좀비쌈'
        ELSE '많이 비싼거'
    END 가격레벨
FROM tbl_menu;

# -- ------------------------------------------
# -- 그룹함수
# -- ------------------------------------------
# -- 하나 이상의 행을 그룹으로 묶어 연산하여 총합, 평균 등을 하나의 컬럼으로 리턴하는 함수
#
# =========================================================================
# |    구분        |             설명                    |
# =========================================================================
# |    SUM            |    그룹의 누적 합계를 리턴 함        |
# |-----------------------------------------------------------------------|
# |    AVG            |    그룹의 평균을 리턴 함            |
# |-----------------------------------------------------------------------|
# |    COUNT        |    그룹의 총 개수를 리턴 함        |
# |-----------------------------------------------------------------------|
# |    MAX            |    그룹의 최대값을 리턴 함            |
# |-----------------------------------------------------------------------|
# |    MIN            |    그룹의 최소값을 리턴 함            |
# -------------------------------------------------------------------------

-- 1. SUM
-- 해당 컬럼 값들의 총 합을 구하는 함수
-- 해당 컬럼의 값이 null인 행은 제외하고, 합계를 구한다.
SELECT menu_price FROM tbl_menu;
SELECT SUM(menu_price) FROM tbl_menu;

SELECT ref_category_code FROM tbl_category;
SELECT SUM(ref_category_code) FROM tbl_category;

-- 2. AVG
-- 해당 컬럼 값들의 평균을 구하는 함수
-- 내부적으로 합계와 COUNT 정보를 가지고 연산을 한다.
SELECT AVG(menu_price) FROM tbl_menu;

-- 3. COUNT
-- 테이블에서 조건을 만족하는 행의 갯수를 반환하는 함수
-- *는 모든 컬럼(하나의행)을 의미한다. 행이 존재하면 1로 카운트
SELECT
    COUNT(*), -- NULL 포함 COUNT
    COUNT(ref_category_code) -- NULL 미포함 COUNT
FROM
    tbl_category;

-- 4. MAX/MIN
-- 그룹의 최대값과 최소값을 구하여 리턴하는 함수
-- 숫자, 문자열, 날짜/시간에 대해서도 최대/최소를 처리할 수 있다.
SELECT
    MAX(menu_price),
    MIN(menu_price),
    MAX(menu_name),
    MIN(menu_name)
FROM
    tbl_menu;

