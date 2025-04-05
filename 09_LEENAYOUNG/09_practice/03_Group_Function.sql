use empdb;

-- 1. EMPLOYEE 테이블에서 여자사원의 급여 총 합을 계산

    /*
        ---------- 출력 예시 ------------
        `급여 총 합`
        ---------------------------------
        24816240
    */

SELECT
        SUM(SALARY) AS '급여 총 합'
    FROM employee
    WHERE
        SUBSTRING(EMP_NO, 8, 1) IN (2, 4);


-- 2. 부서코드가 D5인 사원들의 급여총합, 보너스 총합 조회

    /*
        ------- 출력 예시 ------------
        급여총합        `보너스 총합`
        ------------------------------
        15,760,000      745,000
    */

SELECT
        FORMAT(SUM(SALARY), 0) 급여총합
      , SUM(SALARY * BONUS) AS '보너스 총합'
    FROM employee
    WHERE
        DEPT_CODE = 'D5';

-- 3. 부서코드가 D5인 직원의 보너스 포함 연봉의 총합 을 계산

    /*
        ------- 출력 예시 ----------
        연봉
        ----------------------------
        198,060,000
    */

SELECT
        FORMAT(SUM((SALARY + (SALARY * IFNULL(BONUS, 0))) * 12), 0) 연봉
    FROM employee
    WHERE
        DEPT_CODE = 'D5';


-- 4. 남/여 사원 급여합계를 동시에 표현(가공된 컬럼의 합계)

    /*
        ---------------- 출력 예시 -------------------
        `남사원 급여 합계`         `여사원 급여 합계`
        ----------------------------------------------
         49,760,000                24,816,240
    */

SELECT
        FORMAT(SUM(CASE WHEN SUBSTRING(EMP_NO, 8, 1) IN (1, 3) THEN SALARY ELSE 0 END), 0) AS '남사원 급여 합계'
      , FORMAT(SUM(CASE WHEN SUBSTRING(EMP_NO, 8, 1) IN (2, 4) THEN SALARY ELSE 0 END), 0) AS '여사원 급여 합계'
    FROM employee;

-- 5.  [EMPLOYEE] 테이블에서 사원들이 속해있는 부서의 수를 조회
-- (NULL은 제외하고, 중복된 부서는 하나로 카운팅)

    /*
        ------ 출력 예시 -------
        `부서 수`
        ------------------------
        6
    */

-- (NULL은 제외하고, 중복된 부서는 하나로 카운팅)

SELECT
        COUNT(DISTINCT DEPT_CODE) AS '부서 수'
    FROM employee;