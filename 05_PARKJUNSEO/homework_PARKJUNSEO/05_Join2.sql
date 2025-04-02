-- 1. 가장 나이가 적은 직원의 사번, 사원명, 나이, 부서명, 직급명을 조회하시오. -- 답지 참고

/*
    --------------------- 출력예시 ---------------------------------------
    사번          사원명         나이      부서명         직급명
    ----------------------------------------------------------------------
    203           송은희         16        해외영업2부    차장

*/

SELECT  a.EMP_ID 사번,
        a.EMP_NAME 사원명,
        TRUNCATE(DATEDIFF(NOW(), CONCAT(IF(SUBSTRING(EMP_NO, 8, 1) IN (1, 2), 19, 20), LEFT(EMP_NO, 6)))/365, 0) 나이,
        d.DEPT_TITLE 부서명,
        j.JOB_NAME 직급명
  FROM    employee a
  JOIN    empdb.department d on a.DEPT_CODE = d.DEPT_ID
  JOIN    empdb.job j on a.JOB_CODE = j.JOB_CODE
ORDER BY  나이
 limit  1;

-- 2. 해외영업부에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.

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

SELECT
       EMP_NAME 사원명
     , JOB_NAME 직급명
     , DEPT_ID 부서코드
     , DEPT_TITLE 부서명
FROM
    employee a
        JOIN
    empdb.department d on a.DEPT_CODE = d.DEPT_ID
        JOIN
    empdb.job j on a.JOB_CODE = j.JOB_CODE
WHERE
    DEPT_TITLE IN ('해외영업1부', '해외영업2부', '해외영업3부');



-- 3. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.

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

SELECT  a.EMP_NAME 사원명, a.BONUS 보너스포인트, d.DEPT_TITLE, l.LOCAL_NAME 근무지역명
  FROM  employee a
  LEFT JOIN  empdb.department d on a.DEPT_CODE = d.DEPT_ID
  LEFT JOIN  empdb.location l on l.LOCAL_CODE = d.LOCATION_ID
 WHERE  a.BONUS IS NOT NULL;


-- 4.  급여등급테이블 sal_grade의 등급별 최대급여(MAX_SAL)보다 많이 받는 직원들의 사원명, 직급명, 급여, 연봉을 조회하시오.
--  (사원테이블과 급여등급테이블을 SAL_LEVEL컬럼기준으로 동등 조인할 것)

/*
    --------------------- 출력예시 ---------------------------------------
    사원명     직급명     급여        연봉            최대급여
    ----------------------------------------------------------------------
    고두밋      부사장     4480000    53760000        2999999
*/

SELECT EMP_NAME 사원명, JOB_NAME 직급명, SALARY 급여,
       SALARY*12 연봉, sg.MAX_SAL-1 최대급여
  FROM employee a
  JOIN empdb.job j on a.JOB_CODE = j.JOB_CODE
  JOIN empdb.sal_grade sg on a.SAL_LEVEL = sg.SAL_LEVEL
 WHERE a.SALARY > sg.MAX_SAL;




-- 5. 한국(KO)과 일본(JP)에 근무하는 직원들의 사원명, 부서명, 지역명, 국가명을 조회하시오.

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
    선동일         총무부        ASIA1          한국
    송종기         총무부        ASIA1          한국
    노옹철         총무부        ASIA1          한국

*/

SELECT a.EMP_NAME 사원명, d.DEPT_TITLE 부서명, l.LOCAL_NAME 지역명, n.NATIONAL_NAME 국가명
  FROM employee a
  JOIN empdb.department d ON a.DEPT_CODE = d.DEPT_ID
  JOIN empdb.location l ON d.LOCATION_ID = l.LOCAL_CODE
  JOIN empdb.nation n ON l.NATIONAL_CODE = n.NATIONAL_CODE
 WHERE n.NATIONAL_CODE IN ('KO', 'JP');



-- 6. 같은 부서에 근무하는 직원들의 사원명, 부서명, 동료이름을 조회하시오. (self join 사용)
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

SELECT a.EMP_NAME 사원명, d.DEPT_TITLE 부서명, b.EMP_NAME 동료사원명
  FROM employee a
  JOIN empdb.employee b ON a.DEPT_CODE = b.DEPT_CODE
  JOIN empdb.department d on a.DEPT_CODE = d.DEPT_ID
 WHERE a.EMP_ID != b.EMP_ID
ORDER BY a.EMP_NAME;



-- 7. 보너스포인트가 없는 직원들 중에서 직급이 차장과 사원인 직원들의 사원명, 직급명, 급여를 조회하시오.
--     단, join과 in 연산자 사용할 것

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

SELECT a.EMP_NAME 사원명, j.JOB_NAME 직급명, a.SALARY 급여
  FROM employee a
  JOIN empdb.job j on a.JOB_CODE = j.JOB_CODE
 WHERE a.BONUS IS NULL
   AND j.JOB_NAME IN ('차장', '사원');

-- 8. 재직중인 직원과 퇴사한 직원의 수를 조회하시오. -- 답지 참고

/*
  --------------------- 출력예시 -------------
  재직여부          인원수
  --------------------------------------------
  재직              23
  퇴사              1
*/

SELECT
       if(QUIT_YN = 'N', '재직', '퇴사') 재직여부
     , COUNT(*) 인원수
  FROM employee
GROUP BY 재직여부;