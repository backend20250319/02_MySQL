-- 1. 가장 나이가 적은 직원의 사번, 사원명, 나이, 부서명, 직급명을 조회하시오.
SELECT
    *
FROM
    EMPLOYEE;

SELECT
    E.EMP_ID 사번,
    E.EMP_NAME 사원명,
    TRUNCATE( -- 소수점 이하 자리 버리는 함수.
            DATEDIFF( -- 두 날짜 간의 차이를 일수로 계산
                    NOW(), -- 현재 날짜와 시간
                    CONCAT( -- 문자열을 결합하는 함수
                            IF(SUBSTR(EMP_NO, 8, 1) in (1, 2), 19, 20),
                        -- 주민등록번호의 8번째 숫자에서 한 글자를 추출하고 그 숫자가 1 또는 2인 경우에는 1900년대, 아닌경우 2000년대
                            LEFT(EMP_NO, 6) -- 주민등록번호 앞에서 6자리
                    )
            ) / 365, 0) 나이, -- 생년월일을 기준으로 나이 계산 후 나누기 365, 여기서 0은 소수점 이하를 버린다는 뜻
    D.DEPT_TITLE 부서명,
    J.JOB_NAME 직급명
FROM
    EMPLOYEE E
        LEFT JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
        LEFT JOIN JOB J  USING(JOB_CODE)
ORDER BY
    나이
LIMIT 1;

/*
    --------------------- 출력예시 ---------------------------------------
    사번          사원명         나이      부서명         직급명
    ----------------------------------------------------------------------
    203           송은희         16        해외영업2부    차장

*/


-- 2. 해외영업부에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
SELECT
    *
FROM
    EMPLOYEE;

SELECT
    E.EMP_NAME 사원명,
    J.JOB_NAME 직급명,
    E.DEPT_CODE 부서코드,
    D.DEPT_TITLE 부서명
FROM
    EMPLOYEE E
        JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
        JOIN JOB J USING(JOB_CODE)
WHERE
    D.DEPT_TITLE LIKE '해외영업%';


/*
    --------------------- 출력예시 ---------------------------------------
    사원명         직급명         부서코드            부서명
    ----------------------------------------------------------------------
    박나라         사원              D5              해외영업1부
    하이유         과장              D5              해외영업1부
    김해술         과장              D5              해외영업1부
    심봉선         부장              D5              해외영업1부
    윤은해         사원              D5              해외영업1부
    대북혼         과장              D5              해외영업1부
    송은희         차장              D6              해외영업2부
    유재식         부장              D6              해외영업2부
    정중하         부장              D6              해외영업2부
*/

-- 3. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
SELECT
    *
FROM
    EMPLOYEE;

SELECT
    E.EMP_NAME 사원명,
    E.BONUS 보너스포인트,
    D.DEPT_TITLE 부서명,
    L.LOCAL_NAME 근무지역명
FROM
    EMPLOYEE E
        LEFT JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
        LEFT JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
WHERE
    E.BONUS IS NOT NULL; -- NULL 값을 포함하지 않기 때문에 BONUS의 NULL 값 제외하고 나옴

/*
    --------------------- 출력예시 ---------------------------------------
    사원명         보너스포인트          부서명         근무지역명
    ----------------------------------------------------------------------
    선동일         0.3                   총무부         ASIA1
    유재식         0.2                   해외영업2부    ASIA3
    하이유         0.1                   해외영업1부    ASIA2
    심봉선         0.15                  해외영업1부    ASIA2
    장쯔위         0.25                  기술지원부     EU
    하동운         0.1                     <null>       <null>
    차태연         0.2                   인사관리부     ASIA1
    전지연         0.3                   인사관리부     ASIA1
    이태림         0.35                  기술지원부     EU
*/

-- 4.  급여등급테이블 sal_grade의 등급별 최대급여(MAX_SAL)보다 많이 받는 직원들의 사원명, 직급명, 급여, 연봉을 조회하시오.
--  (사원테이블과 급여등급테이블을 SAL_LEVEL컬럼기준으로 동등 조인할 것)
SELECT
    *
FROM
    EMPLOYEE;

SELECT
    E.EMP_NAME 사원명,
    J.JOB_NAME 직급명,
    E.SALARY 급여,
    E.SALARY + (E.SALARY * IFNULL(E.BONUS, 0)) * 12 연봉,
    S.MAX_SAL 최대급여
FROM
    EMPLOYEE E
        JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
        JOIN SAL_GRADE S ON E.SAL_LEVEL = S.SAL_LEVEL -- USING(SAL_LEVEL)도 가능
WHERE
    E.SALARY > S.MAX_SAL;


/*
   --------------------- 출력예시 ---------------------------------------
   사원명     직급명     급여        연봉            최대급여
   ----------------------------------------------------------------------
   고두밋      부사장     4480000    53760000        2999999
*/


-- 5. 한국(KO)과 일본(JP)에 근무하는 직원들의 사원명, 부서명, 지역명, 국가명을 조회하시오.
SELECT
    *
FROM
    EMPLOYEE;

SELECT
    E.EMP_NAME      사원명,
    D.DEPT_TITLE    부서명,
    L.LOCAL_NAME    지역명,
    N.NATIONAL_NAME 국가명
FROM
    employee E
        JOIN department D ON E.DEPT_CODE = D.DEPT_ID
        JOIN location L ON L.LOCAL_CODE = D.LOCATION_ID
        JOIN nation N USING(NATIONAL_CODE) -- ON N.NATIONAL_CODE = L.NATIONAL_CODE도 가능
WHERE
    N.NATIONAL_NAME IN ('한국', '일본');
/*
    --------------------- 출력예시 ---------------------------------------
    사원명         부서명         지역명         국가명
    ----------------------------------------------------------------------
    방명수         인사관리부     ASIA1          한국
    차태연         인사관리부     ASIA1          한국
    전지연         인사관리부     ASIA1          한국
    임시환         회계관리부     ASIA1          한국
    이중석         회계관리부     ASIA1          한국
    유하진         회계관리부     ASIA1          한국
    고두밋         회계관리부     ASIA1          한국
    박나라         해외영업1부    ASIA2          일본
    하이유         해외영업1부    ASIA2          일본
    김해술         해외영업1부    ASIA2          일본
    심봉선         해외영업1부    ASIA2          일본
    윤은해         해외영업1부    ASIA2          일본
    대북혼         해외영업1부    ASIA2          일본
    선동일         총무부,ASIA1                  한국
    송종기         총무부,ASIA1                  한국
    노옹철         총무부,ASIA1                  한국

*/

-- 6. 같은 부서에 근무하는 직원들의 사원명, 부서명, 동료이름을 조회하시오. (self join 사용)
SELECT
    *
FROM
    EMPLOYEE;


SELECT
    E.EMP_NAME      사원명,
    D.DEPT_TITLE    부서명,
    E2.EMP_NAME     동료사원명
FROM
    EMPLOYEE E
        JOIN employee E2 ON E.DEPT_CODE = E2.DEPT_CODE
        LEFT JOIN department D ON E.DEPT_CODE = D.DEPT_ID

WHERE
    E.EMP_NAME <> E2.EMP_NAME -- !=도 가능
ORDER BY
    E.EMP_NAME ASC;

--     사원명으로 오름차순정렬
/*
    --------------------- 출력예시 ---------------------------------------
    사원명         부서명         동료사원명
    ----------------------------------------------------------------------
    고두밋         회계관리부     임시환
    고두밋         회계관리부     이중석
    고두밋         회계관리부     유하진
    김해술         해외영업1부    박나라
    김해술         해외영업1부    하이유
    김해술         해외영업1부    심봉선
    김해술         해외영업1부    윤은해
    김해술         해외영업1부    대북혼
    ...
    총 row 66
*/


-- 7. 보너스포인트가 없는 직원들 중에서 직급이 차장과 사원인 직원들의 사원명, 직급명, 급여를 조회하시오.
--     단, join과 in 연산자 사용할 것
SELECT
    *
FROM
    EMPLOYEE;

SELECT
    E.EMP_NAME          사원명,
    J.JOB_NAME          직급명,
    FORMAT(E.SALARY , 0) 급여 -- 천 단위마다 콤마
FROM
    EMPLOYEE E
        JOIN JOB J USING(JOB_CODE) -- ON E.JOB_CODE = J.JOB_CODE 가능
WHERE
    E.BONUS IS NULL
  AND
    J.JOB_NAME IN ('차장', '사원');

/*
    --------------------- 출력예시 -------------
    사원명         직급명         급여
    ---------------------------------------------
    송은희         차장           2,800,000
    임시환         차장           1,550,000
    이중석         차장           2,490,000
    유하진         차장           2,480,000
    박나라         사원           1,800,000
    윤은해         사원           2,000,000
    ...
    총 row수는 8
*/

-- 8. 재직중인 직원과 퇴사한 직원의 수를 조회하시오.
SELECT
    *
FROM
    EMPLOYEE;

SELECT
    IF((e.QUIT_YN = 'Y'), '퇴사', '재직') 재직여부,
    COUNT(*) 인원수
FROM
    EMPLOYEE E
GROUP BY
    E.QUIT_YN;

/*
  --------------------- 출력예시 -------------
  재직여부          인원수
  --------------------------------------------
  재직              23
  퇴사              1
*/
