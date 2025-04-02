    use empdb;

-- 1. EMPLOYEE 테이블에서 직급이 J1을 제외하고, 직급별 사원수 및 평균급여를 출력하세요.


    /*
        --------------- 출력 예시 -------------
        직급코드  `직급별 사원수`      평균급여
        ----------------------------------------
            J2           3              4726666
            J3           3              3600000
            J4           4              2330000
            J5           3              2820000
            J6           6              2624373
            J7           4              2017500

    */

    SELECT
        job_code 직급코드,
        COUNT(job_code) '직급별 사원수',
        TRUNCATE(AVG(salary), 0) 평균급여
    FROM
        employee
    WHERE
        job_code <> 'J1'
    GROUP BY
        job_code
    ORDER BY
        직급코드;


-- 2. EMPLOYEE테이블에서 직급이 J1을 제외하고, 입사년도별 인원수를 조회해서, 입사년 기준으로 오름차순 정렬하세요.
-- (select에는 groupby절에 명시한 컬럼만 작성가능)

    /*
        ---- 출력 예시 -------
        입사년          인원수
        ----------------------
        1994             3
        1996             1
        1997             1
        1999             3
        2000             1
        2001             3
        ...
        총 출력row는 17

    */
    SELECT
        EXTRACT(YEAR FROM hire_date) 입사년,
        COUNT(*) 인원수
    FROM
        employee
    WHERE
        job_code != 'J1'
    GROUP BY
        EXTRACT(YEAR from hire_date)
    ORDER BY
        입사년;

-- 3. 성별 급여의 평균(정수처리), 급여의 합계, 인원수를 조회한 뒤 인원수로 내림차순을 정렬 하시오.

    /*
        ------------------- 출력 예시 -------------------
        셩별          평균          합계          인원수
        -------------------------------------------------
        남       "3,317,333"     "49,760,000"       15
        여       "2,757,360"     "24,816,240"       9
    */


    SELECT
        CASE SUBSTR(emp_no, 8, 1)
            WHEN 1 THEN '남'
            WHEN 3 THEN '남'
            ELSE '여'
            END AS 성별,
        FORMAT(TRUNCATE(AVG(salary), 0), 0) AS 평균,
        FORMAT(SUM(salary), 0) AS 합계,
        COUNT(*) AS 인원수
    FROM
        EMPLOYEE
    GROUP BY
        CASE SUBSTR(emp_no, 8, 1)
            WHEN 1 THEN '남'
            WHEN 3 THEN '남'
            ELSE '여'
            END
    ORDER BY
        인원수 DESC;
-- 4. 직급별 인원수가 3명이상이 직급과 총원을 조회

    /*
        ------------ 출력 예시 ---------------
        직급          인원수
        -------------------------------------
        J2              3
        J3              3
        J4              4
        J5              3
        J6              6
        J7              4


    */
    SELECT
        IFNULL(job_code, '총원') 직급,
        COUNT(*) 인원수
    FROM
        EMPLOYEE
    GROUP BY
        job_code
    HAVING
        COUNT(*) >= 3
    ORDER BY
        직급;

SELECT
    JOB_CODE  직급
     , COUNT(JOB_CODE) 인원수
FROM
    employee
GROUP BY
    JOB_CODE
HAVING
    COUNT(JOB_CODE) >= 3;