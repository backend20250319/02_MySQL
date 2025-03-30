-- 1 0


-- 2. 0
select
    emp_name,
    phone
from
   employee
where
    phone
not like '010%' ;
-- 3
select *
  /*  employee_mailadd     -- select * from tbl_empdb
,   DEPT_CODE */
from
    employee
where
    (email
    like '____')   -- where (empdb_mail like '____\_%)
  and
    (DEPT_CODE = '9일차') or (DEPT_CODE= '5일차')
  between
    (hire_date between '90/01/01' and '01/12/31') -- and
  and
    salary >= 270; -- empdb_money >= 270000;
-- 4
select
   *   -- select * from tbl_empdb
from
    employee
where
    QUIT_Yn = 'N'  -- quit_yn ='N' 퇴사일이 N으로 표현된 것
order by  emp_name;
-- 5
select
    emp_name          -- hire_date 입사일,
    hire_date입사일,  -- quit_date 퇴사일
    quit_date 퇴사일,         -- dateddiff(ifnull(quit_data,now()),
    datediff(ifnull(quit_date,now()),employee.HIRE_DATE)       -- hire_date) '근무기간 (일)',
     '근무기간(일)'                      -- quit_yn
from                       -- where tbl_empdb;
    employee;

-- 6
select
    EMP_ID,
    EMP_NAME,
    PHONE,
    HIRE_DATE,
    QUIT_YN
from
    employee
where
    PHONE LIKE '%2'
and
    QUIT_YN <> 'y'
ORDER BY
    HIRE_DATE -- ??(설명)
LIMIT  3;
-- 7
select
count(*)   --  employee_name,  -- COUNT(*) from tbl_empdb
   -- employee_grde   -- where MANFER_ID IS NOT NULL
from                -- ORDER BY EMP_NAME;
   employee
where
    MANAGER_ID is not null
order by
    EMP_NAME;
-- 02.1
select
    emp_id 사원번호,
    emp_name 성명,
    concat(substr(emp_no,1,8),'******')주민번호,   -- concat(substr(emp_no,1,8),'****')주민번호
    rpad(substr(emp_no,1,8),14,) 주민번호'*',
    format(급여(급여 ifnull(보너스,+*0)))*12,0) 연봉
                    -- rpad(substr(emp_no,1,8),14,) 주민번호'*'
from                -- format(급여(급여 ifnull(보너스,+*0)))*12,0) 연봉
    employee
where                              -- where
    substr(emp_no,8,1)안으로 ('1','3'); -- substr(emp_no,8,1)안으로 ('1','3');
-- 2
select
    emp_name,
    substring_index(email,, '@'1) email_id
  /*  emp_name,
    emp_id  */-- substring_index(이메일,,'@'1) email_id
from
   employee;

-- 3
CREATE TABLE tbl_files (
                           file_no BIGINT,
                           file_path VARCHAR(500)
);
-- drop table tbl_files
INSERT INTO tbl_files VALUES(1, 'c:\\abc\\deft\\salesinfo.xls');
INSERT INTO tbl_files VALUES(2, 'c:\\music.mp3');
INSERT INTO tbl_files VALUES(3, 'c:\\documents\\resume.hwp');
COMMIT;
SELECT * FROM tbl_files;

-- 4
select
    file_no 파일번호,
    substring_index(file_path, , '\\'-1) as "파일명"
from tbl_files;


-- 03.1
select
    sum(salary)'급여 총 합'         -- sum(급여) '급여 총 합'
from
    employee
where
    substr(emp_no,8,1) in('2','4');  -- substr(emp_no,8,1) 아느로 ('2','4');
-- 2
select
  format(sum(salary),0) 급여총합,
  format(sum(salary*ifnull(bonus,0)),0)보너스총합
   -- empdb_money, -- sum(급여),0) 급여총합,
   -- empdb_specail -- sum(급여 ifnull(보너스,*0)),0)"보너스 총합"
from employee
where
    DEPT_CODE ='D5';
   /* empdb_money      -- dept_code ='5일차';
group by
    sum(empdb_code = 5); */
-- 3
select
    format(sum(salary + (salary * ifnull(bonus,0))*12),0)as 연봉
   -- empdb_code -- sum((급여(급여 ifnull(보너스,+*0)))*12),0) as 연봉
from
    employee
where
    DEPT_CODE ='D5';
 -- group by
    -- empdb_code = 5;  -- ='5일차';
-- 4
select
    format(sum(case when substr(emp_no,8,1)in (1,3)then employee.SALARY else 0 end),0)"남사원급여",
    format(sum(case when substr(emp_no,8,1)in (2,4)then employee.SALARY else 0 end),0)"여사원급여"
from employee;
   /* empdb_money,                  -- (sum(substr(emp_no,8,1)in(1,3) next money else 0 end),0) "남자급여",
    sum(man) as '남사원 급여 합계', -- (sum(substr(emp_no,8,1)in(2,4) next money else 0 end),0) "여자급여"
    sum(woman) as '여사원 급여 합계'
from
        tbl_empdb   -- ;
group by
    empdb_money = man; */

-- 5
select
    count(distinct  DEPT_CODE) "부서 수"
    -- empdb_part,      -- count(dept_code)"부서 수" //null은 자동 제외
    -- count(empdb_part)
from
   employee;
   -- group by
   --  empdb_part is not null;
-- 04.01
select
    JOB_CODE 직급코드,
    count(JOB_CODE)'직급별 사원수',
    truncate(avg(SALARY),0)평균급여
from
    employee
where
    JOB_CODE <> 'j1'
group by
    JOB_CODE
order by
    JOB_CODE;
/* select
    empdb_code,   -- job_code 직급코드,
    empdb_part,   -- count(job_code)'직급별 사원수',
    empdb_money = avg(*) as '평균급여' -- cut(avg(급여),0) 평균급여
from
        employee     -- where job_code is not 'j1'
group by              -- group by job_code
    empdb_code is not like '%j1'; -- order by job_code; */
-- 2
/* select
    empdb_year,  -- (year from hire_date) 입사년,
    empdb_people  -- count(*) 인원수 // null 포함
from
    employee  -- where job_code is not 'j1'
group by       -- group by 추출물(year from hire_date)
    empdb_year asc; -- order by hire_code; */
-- 3
/* select
    empdb_maile,        -- case_substr(emp_no,8,1)
    sum(empdb_money), -- when 1 and '남' when 3 and '남' another '여'
    sum(empdb_people) -- end as 성별, (truncate(avg(급여),0),0) as 평균,
                      -- (sum(급여),0) as 합계, count(*) as 인원수
from
    employee
group by      -- case substr(emp_no,8,1)
    empdb_,maile -- when 1 and '남' when 3 and '남' another '여'end
having avg(empdb_maile='man',empdb_maile ='woman'); -- order by emp_people ; */
-- 4
/*select
    empdb_part,        -- ifnull(job_code,'총원') 직급,
    count(*) as '인원수'
from
    tbl_empdb
group by
    empdb_part ;  -- jpb_code
                  -- where
                  -- count(*) >=3
                  -- order by job_code; */



-- 조인 문제 1
/* select
    EMP_ID,
    EMP_NAME,
    PHONE,
    HIRE_DATE,
    QUIT_DATE
    from
        employee
where
    PHONE like '%2' between HIRE_DATE= 'Y' and
    quit_date = 'Y' or hire_date ='N';

-- 2
select
    EMP_NAME,
    SAL_LEVEL,
    SALARY,
    EMP_ID,
    EMAIL,
    HIRE_DATE
from
    employee
where
    (HIRE_DATE = 'Y') and (SAL_LEVEL ='대리')
order by
    SAL_LEVEL desc; */


-- 조인
-- 1
select
    EMP_ID 사원번호,
    EMP_NAME 사원명,
    PHONE 전화번호,
    HIRE_DATE 입사일,
    QUIT_yn 퇴직여부
from
    employee
where
    QUIT_YN = 'N' and
    PHONE like '%2'
order by
    hire_date desc
limit 3;

-- 2.
select
    a.EMP_NAME 사원명,
    b.job_name 직급명,
    a.SALARY 급여,
    a.EMP_no 주민번호,
    a.EMAIL 이메일,
    a.PHONE 전화번호,
    a.HIRE_DATE 입사일
from
    employee a
join job b on a.job_code =b.JOB_CODE
where
    a.QUIT_YN = 'N'
and
    b.JOB_name = '대리'
order by
    a.SALARY desc;
-- 3 출력이 나오지 않았음
select
    d.DEPT_TITLE as 부서명,
    -- a.DEPT_CODE 부서명,직원테이블이 아닌 부서테이블을 사용
    -- a.EMP_ID as 인원, 아닌 카운트를 사용해 인원수 추가
    count(*) as 인원,
    sum(a.SALARY) as 급여합계, -- sum(급여)
    avg(a.SALARY) as 급여평균      -- avg(급여)
    from
        employee a
join department d on a.DEPT_CODE = d.DEPT_ID
    -- join empdb.department  x
where
  a.QUIT_YN <> 'Y'              -- SALARY = sum(*) '급여합계'
group by
  d.dept_title             -- with rollup을 사용을 사용하지 않았었음
with rollup ;              --  salary = avg(*) '급여평균';
-- 4
select
    a.EMP_NAME 사원명,
    a.EMP_NO 주민번호,
    a.PHONE 전화번호,
    d.dept_title 부서명,
    j.JOB_NAME 직급명
    from
        employee a
    join empdb.department d on a.DEPT_CODE = d.DEPT_ID
    join empdb.job j on a.JOB_CODE = j.JOB_CODE

order by
    HIRE_DATE;
-- 5
select
  /*  date_add()
    from
        employee */
 date_format(cast( '20201225' as date ),'%w') week;

-- 6
select
    a.EMP_NAME 사원명,
    a.EMP_NO 주민번호,
    d.dept_title 부서명,
    j.JOB_CODE 직급명
from
    employee a
   join empdb.department d on (a.DEPT_CODE = d.DEPT_ID)
    join empdb.job j on (a.JOB_CODE = j.JOB_CODE)
where
   -- a.EMP_NO like '70____%' and a.EMP_NAME like '%전';
substring(a.EMP_NO,1,2) >=70    --    substr(a.EMP_NO ,1,2) >= '70' /substring 사용
and substring(a.EMP_NO,1,2) < 80--   and case (a.EMP_NO ,1,2) < '80' /번호 1번과2번자리가 80보다 작음 것
and substring(a.EMP_NO,8,1) = 2 --   and case (a.EMP_NO ,8,1) = '2' /case 사용x,8번자리가 2인 값
and a.EMP_NAME like '전%';   --   and a.EMP_Name like '전%' ;
-- 7??
select
    EMP_ID 사번,
    EMP_NAME 사원명,
    j.job_name 직급명
    from employee
        join empdb.job j on (j.JOB_CODE = employee.JOB_CODE)
where
    EMP_NAME like '%형%';

-- 8 내가 한거 부서명이 널 값으로 출력
select
    a.EMP_NAME 사원명,
    j.JOB_name 직급명,
    a.DEPT_CODE 부서코드,
    d.dept_title 부서명        -- k.LOCAL_CODE 부서명 /잘못 넣었음
from employee a
         join empdb.department d on (a.DEPT_CODE = d.DEPT_ID)
         join empdb.job j on (a.JOB_CODE = j.JOB_CODE)
      -- left join empdb.location k on a.JOB_CODE = k.LOCAL_CODE /필요없는 코드
where
    a.DEPT_CODE = 'D5' or
    a.DEPT_CODE ='D6';
/* SELECT 답?
    emp_name 사원명,
    job_name 직급명,
    dept_code 부서코드,
    dept_title 부서명
FROM
    employee
        JOIN department ON dept_code = dept_id
        JOIN job USING(job_code)
WHERE
    dept_title LIKE '해외영업%';
*/
-- 조인 2
-- 1

select
    EMP_ID 사번,
    EMP_NAME 사원명,
truncate(
    datediff(now(),
    concat(
    if(substr(EMP_NO,8,1)in (1,2),19,20),
    left(EMP_NO,6)
    )) /365,0) 나이,
    dept_title 부서명,
    job_name 직급명
    from
        employee
left join department on DEPT_CODE = DEPT_ID
left join job using (job_code)
order by
    나이
limit 1;

-- 2 이전 8번과 동일


SELECT
    emp_name 사원명,
    job_name 직급명,
    dept_code 부서코드,
    dept_title 부서명
FROM
    employee
        JOIN department
            ON dept_code = dept_id
        JOIN job USING(job_code)
WHERE
    dept_title LIKE '해외영업%';
-- 3
select
    EMP_NAME 사원명,
    BONUS 보너스포인트,
    dept_title 부서명,
    a.local_name 근무지역명
from
    employee
    join department on DEPT_CODE =DEPT_ID
    join job using (job_code)
    left join empdb.location k on JOB_CODE = k.LOCAL_CODE
-- left join empdb.location k on JOB_CODE = k.LOCAL_CODE;를
-- left join location k on location_id = local_code 로 변경
-- where bonus is not null을 넣어야 null값이 나오지 않고 모두 출력
left join location a on location_id = a.LOCAL_CODE
  where
    bonus is not null;
-- 4 차트 값 빼고 인스턴스 값이 나오질 않았음
select
    EMP_NAME 사원명,
    job_name 직급명,
    SALARY 급여,
    DEPT_TITLE 연봉,
    local_name 근무지역명    --   MAX_SAL 최대급여/ 아닌 local_name 근무지역명로 사용
from
employee a
join job using (job_code)
join department d on a.DEPT_CODE = d.DEPT_ID
    -- 부서테이블의 부서아이디와 직원테이블의 부서코드를 조인
join location l on d.LOCATION_ID = l.LOCAL_CODE -- 등급조회가 아닌 지역명과 코드를 조인
where
    DEPT_CODE ='D2';
    /* 이전 사용 코드
    left join department on DEPT_CODE = DEPT_ID
    left join job using (job_code)
    left join  sal_grade on employee.SAL_LEVEL = MAX_SAL
where
    DEPT_CODE ='D2';*/
-- 5
select
    EMP_NAME 사원명,
    dept_title 부서명,
    a.local_name 지역명,
    c.NATIONAL_NAME 국가명
from
    employee
        join department on DEPT_CODE =DEPT_ID
        left join location a on location_id = a.LOCAL_CODE
        left join nation c on a.NATIONAL_CODE = c.NATIONAL_code
  where
    a.NATIONAL_CODE like 'KO%' or a.NATIONAL_CODE like '%JP';
-- 6

select
    a.EMP_NAME 사원명,
    DEPT_TITLE 부서명,
    a2.EMP_NAME 동료사원명
from
        employee a
   join employee a2 on (a.DEPT_CODE = a2.DEPT_code)
    left join department b on a.DEPT_CODE = dept_id
where
 a.emp_name != a2.EMP_NAME
order by
1;

-- 7   급여 값이 널로 나왔음
select
    a.EMP_NAME 사원명,
    job_name 직급명,
    BONUS 급여
    from
        employee a
            left join job using (job_code)
where
    BONUS is null and JOB_CODE like '%4' or job_code like '%7';
-- 7번 수정
select
    a.EMP_NAME 사원명,
    job_name 직급명,
    FORMAT(salary, 0) 급여 -- format을 사용해 급여값 초기화
from
    employee a
        left join job using (job_code)
where
    BONUS is null and JOB_CODE like '%4' or job_code like '%7';

-- 8 최선을 다 했는데
select
    count(QUIT_YN) as '재직여부',
    count(*) as '인원수'
from
        employee
 group by
     if (QUIT_YN = 'N','재직','퇴사');
 -- 수정
select
    if (QUIT_YN = 'N','재직','퇴사') '재직여부',
    count(*) as '인원수'
from
    employee
group by
    QUIT_YN;

-- 6 서브쿼리
-- 1 값이 null로 나왔음
select
    max(SALARY) -- (급여의 총합을 구하는 문제라 SAL_sum를 사용) sum:합계
    from        -- 검색할거다 부서 코드와 합계(급여)를 변수 이름을 SAL_sum이라 지정
    employee
    where       -- 부서코드가 널이 아님, 묶어라 부서코드끼리) 각 부서의 급여로
     SALARY > (select max(SALARY) from employee);
-- 1
SELECT MAX(SAL_SUM) 총합
FROM (SELECT DEPT_CODE, SUM(SALARY) as SAL_SUM
      FROM EMPLOYEE
      WHERE DEPT_CODE IS NOT NULL
      GROUP BY DEPT_CODE) AS TBL_DEPT_SAL;


-- 2 차트 목록을 제외하고 인스턴스 데이터 값이 나오질 않음
select
    EMP_ID 사원번호,
    EMP_NAME 사원명,
    DEPT_CODE 부서코드,
    SALARY 급여
    from
    employee
    where          -- = 이 아닌 in을 사용했어야 했음, 어디 안에 있는 값을 가져오는 명령어
        dept_code in           --  dept_code = ,또한 부서코드값이 아닌 id를 찾아야 했음
        (select DEPT_ID from  department  -- 이전 (select DEPT_CODE from  department
            where DEPT_TITLE like '%영업%');

-- 3 차트 목록 값만 나오고 인스턴스 값이 나오질 않았음
select
    a.EMP_ID 사원번호,
    a.EMP_NAME 사원명,
    DEPT_TITLE 부서명,       -- DEPT_CODE 부서명,
    a.SALARY 급여
from
    employee a
        join department on DEPT_CODE =DEPT_ID
where
    DEPT_CODE in (select DEPT_ID
     from department
     where DEPT_TITLE like '%영업%');
    /*
    dept_code like '영업%' = // in을 사용했어야 했음
    (select DEPT_code from  department //코드가 아닌 ID로 검색
     where DEPT_TITLE); */   -- 여기서 like'%영업%'을 이용했어야 함
-- 4 값이 내림차순이 아닌 미국부터 나왔음
select
    a.EMP_ID 사원번호,
    a.EMP_NAME 사원명,
    a.SALARY 급여,
    DEPT_TITLE 부서명,      -- 여러 테이블 주소에 있는 값과 일치 여부를 확인을 위해 테이블 주소가 필요했음
    c.NATIONAL_NAME 국가명
from
    employee a
                                                          -- 부서의 ID와 부서명,국가명의 조인
        join department  on DEPT_CODE =DEPT_ID   -- 지역에 관한 조인이 빠짐
    left join nation c on NATIONAL_CODE = c.NATIONAL_code -- left조인을 사용x ,(NATIONAL_CODE = c.NATIONAL_code) ex/
                                                          -- 괄호로 묶어 통합값을 지정 주소 ex로 저장
order by                                                  -- 국가 코드가 아닌 이름으로 내림차순을 지정했어야함
    NATIONAL_CODE  desc ;

-- (select dept_id,dept_title ,national_name
--  from department
/*
SELECT E.EMP_ID 사원번호, E.EMP_NAME 사원명, E.SALARY 급여, DLN.DEPT_TITLE 부서명, DLN.NATIONAL_NAME "(부서의) 국가명"
FROM EMPLOYEE E
  JOIN (SELECT D.DEPT_ID, D.DEPT_TITLE, N.NATIONAL_NAME
FROM DEPARTMENT D
  JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
  JOIN NATION N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)) DLN
  ON E.DEPT_CODE = DLN.DEPT_ID
ORDER BY DLN.NATIONAL_NAME DESC; */