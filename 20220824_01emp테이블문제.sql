
파일 > 새로 만들기 > 데이터베이스계층 > 데이터베이스 파일
C:\java202207\database\20220824_01emp테이블문제.sql
/////////////////////////////////////////////////////////////////////////////


-- 문1) emp 사원테이블을 생성하시오
CREATE TABLE emp(
      empno number(4) PRIMARY KEY --사번(-9999~9999)
,     ename varchar2(50) --이름
,     job varchar2(10) --직급
,     mgr number(4) --매니저정보
,     hiredate date --입사일
,     sal number(7, 2) --급여(소수점 2자리)
,     comm number(7, 2) --커미션(보너스)
,     deptno number(2) --부서코드(-99~99)
);

delete from emp;

-- 문2) emp사원테이블에 행을 추가하시오
INSERT INTO 
      emp(empno, ename, job, mgr, hiredate, sal, deptno)
VALUES
      (7369, '개나리', '사원', 7902, '2000-12-17', 200, 20);

INSERT INTO
      emp(empno, ename, job, mgr, hiredate, sal, deptno)
VALUES
      (7499, '진달래', '주임', 7698, '2001-12-15', 360, 20);

INSERT INTO
      emp(empno, ename, job, mgr, hiredate, sal, deptno)
VALUES
      (7521, '라일락', '주임', 7698, '2001-02-17', 355, 30);

INSERT INTO
      emp(empno, ename, job, mgr, hiredate, sal, deptno)
VALUES
      (7654, '손흥민', '과장', 7839, '2002-01-11', 400, 30);

INSERT INTO
      emp(empno, ename, job, mgr, hiredate, sal, deptno)
VALUES
      (7698, '박지성', '주임', 7698, '2000-07-12', 325, 20);

INSERT INTO
      emp(empno, ename, job, mgr, hiredate, sal, deptno)
VALUES
      (7782, '김연아', '사원', 7698, '2001-12-17', 225, 10);

INSERT INTO
      emp(empno, ename, job, mgr, hiredate, sal, deptno)
VALUES
      (7778, '무궁화', '사원', 7839, '2005-11-14', 200, 10);

INSERT INTO
      emp(empno, ename, job, mgr, hiredate, sal, deptno)
VALUES
      (7839, '홍길동', '부장', 7566, '2006-06-17', 450, 20);

INSERT INTO
      emp(empno, ename, job, mgr, hiredate, sal, deptno)
VALUES
      (7844, '송강호', '과장', 7566, '2018-09-17', 400, 30);

INSERT INTO
      emp(empno, ename, job, mgr, hiredate, sal, deptno)
VALUES
      (7876, '정우성', '대표', 7839, '2004-09-09', 500, 30);

INSERT INTO
      emp(empno, ename, job, mgr, hiredate, sal, deptno)
VALUES
      (7900, '김혜수', '사원', 7902, '2001-12-03', 200, 20);

-- / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / -- 문3) 전체 행의 갯수를 조회하시오
-- 문3) 전체 행의 갯수를 조회하시오
select count(*)
from emp;

-- 문4) 테이블의 칼럼(필드) 목록을 확인하시오
select * from emp;

-- 문5) 사원이름순(오름차순) 정렬하시오
select * from emp order by ename;

-- 문6) 사원이름순(내림차순) 정렬하시오
select * from emp order by ename desc;

-- 문7) 급여 내림차순으로 사원이름(ename), 급여(sal), 부서코드(deptno)를 조회하시오
select ename, sal, deptno
from emp
order by sal desc;

-- 문8) 부서코드 오름차순, 급여 내림차순으로
--      사원이름(ename), 급여(sal), 부서코드(deptno)를 조회하시오
select ename, sal, deptno
from emp
order by deptno, sal desc;

-- 문9) 이름(ename)/입사일자(hiredate)/부서코드(deptno)를
--       부서코드 오름차순, 입사일자(hiredate) 오름차순으로 조회하시오
select ename, hiredate, deptno
from emp
order by deptno, hiredate;

-- 문10) 직급(job) 칼럼의 중복데이터를 하나씩만 조회하시오
select distinct(job) from emp;

-- 문11) emp테이블의 job 오름차순, sal 내림차순으로 정렬해서
--       ename 이름, job 직급, sal 급여 칼럼명으로 별칭을 바꿔서 조회하시오
select ename as 이름, job as 직급, sal as 급여
from emp
order by job, sal desc;

-- 문12) 급여가 100보다 많고 400보다 작은 직원 조회하기(급여 내림차순)
select ename, sal
from emp
where sal between 100 and 400
order by sal desc;

-- 문13) 급여가 100이하 또는 400 이상의 직원 검색하기(급여 내림차순)
select ename, sal
from emp
where sal <= 100 or sal >= 400
order by sal desc;

-- 문14) 직급(job)이 과장 또는 부장인 직원들을 이름순으로 조회하시오
select ename, job
from emp
where job='과장' or job='부장'
order by ename;

-- 문15) 부서코드(deptno)가 30인 직원을 조회하시오
select ename, deptno
from emp
where deptno=30;

-- 문16) 중복된 부서코드를 한개씩만 조회하시오
select distinct(deptno) from emp;

-- 문17) 부서코드가 10 또는 20 또는 30인 직원을 조회하시오
--       (or, in연산자 각각 활용해서 조회)

-- or 연산자
select ename, deptno
from emp
where deptno=10 or deptno=20 or deptno=30;

-- in 연산자
select ename, deptno
from emp
where deptno in (10, 20, 30);

-- 문18) 급여가 300~500인 직원을 급여순으로 조회하시오
--       (and, between연산자 각각 활용해서 조회)

-- and 연산자
select ename, sal
from emp
where sal >=300 and sal <= 500;

-- between 연산자
select ename, sal
from emp
WHERE sal BETWEEN 300 and 500;

-- 문19) 이름이 무궁화 조회하시오
select ename from emp where ename='무궁화';

-- 문20) 김씨성을 조회하시오
select ename from emp where ename like '김%';

-- 문21) 이름에 '화' 포함된 줄을 조회하시오
select * from emp where ename like '%화%';

-- 문22) 부서코드가 20인 레코드에 대해서
--       급여의 1%를 커미션으로 책정하시오
update emp set comm=sal*0.01 where deptno=20;

select * from emp;

-- 문23) 연봉을 아래와 같이 구한후 이름, 부서, 급여, 커미션, 연봉을 조회하시오
--       연봉구하는 식 : 급여(sal)*12개월+보너스(comm)

update emp set yearSal = sal*12+comm;

select ename, deptno, sal, comm, sal*12+comm from emp;

-- 문24) 커미션이 null이면 0으로 바꾼후 연봉을 다시 계산해서
--       이름, 급여, 커미션, 연봉을 조회하시오

select ename, deptno, sal, round(sal*12+nvl(comm, 0), 0) as 연봉
from emp;

-- 문25) 각 사람의 급여를 검색해서 '누구누구의 급여는 얼마입니다'로 조회하시오
--       (|| 결합연산자)
select ename || '의 급여는 ' || sal || '입니다.' as pay
from emp;


-- 연산자 우선순위
-- () 괄호 : 연산자 우선순위보다 우선함
-- 1순위 : 비교연산자, SQL연산자, 산술연산자
-- 2순위 : not
-- 3순위 : and
-- 4순위 : or
-- 5순위 : 결합연산자


-- 문26) emp테이블에서 입사일(hiredate)이 2005년 1월 1일 이전인 사원에 대해
--       사원의 이름(ename), 입사일, 부서번호(deptno)를 입사일순으로 조회하시오

select ename, hiredate, deptno
from emp
where hiredate < to_date('2005-01-01')
order by hiredate;


-- 문27) emp테이블에서 부서번호가 20번이나 30번인 부서에 속한
--      사원들에 대하여 이름, 직업코드(job), 부서번호를 이름순으로 조회하시오
--      (or, in연산자 각각 활용해서 모두 조회)

-- or 연산자
select ename, job, deptno
from emp
where deptno = 20 or deptno = 30
order by ename;

-- in 연산자
select ename, job, deptno
from emp
where deptno in (20, 30)
order by ename;


-- 문28) 사번, 이름, 부서를 조회하시오
--       (단, 부서코드가 10이면 관리부
--                       20이면 영업부
--                       30이면 교육부로 바꿔서 출력)

select empno, ename, case when deptno=10 then '관리부'
                          when deptno=20 then '영업부'
                          when deptno=30 then '교육부'
                          end as dept
from emp;


-- 문29) 다음의 SQL문을 분석하시오
--       select empno, sal 
--       from emp
--       where not(sal>200 and sal<300)
--       order by sal;

급여가 200 이하, 300 이상인 사원들의 사번과 급여를 급여 오름차순으로 정리해 출력하시오


-- 문30) 다음의 SQL문을 분석하시오
--       select empno, sal 
--       from emp
--       where not sal>200 and sal<300
--       order by sal;

급여가 200 이하인 사원들의 사번과 급여를 급여 오름차순으로 정리해 출력하시오


-- //////////////////////////////////////////////////////////////////////////////////////////////////////
-- [emp테이블 관련 연습문제]
select * from emp;

-- 문31) 부서코드별 급여합계를 구하시오
select deptno, sum(sal)
from emp
group by deptno
order by deptno;


-- 문32) 부서코드별 급여합계를 구해서  그 합계값이 1500이상만 조회하시오
select sum(sal), deptno
from emp
group by deptno
having sum(sal)>1500;


-- 문33) 부서코드별 급여평균이 300이상 조회하시오
select deptno, avg(sal)
from emp
group by deptno
having avg(sal)>=300
order by deptno;


-- 문34) 급여가 300이상 데이터중에서 부서코드별 급여평균을 구해서 급여평균순으로 조회하시오
select round(avg(sal), 0), deptno
from emp
where sal >= 300
group by deptno
order by avg(sal);


-- 문35) 급여가 300이상 데이터중에서 부서코드별 급여평균이 400이상을 급여순으로 조회하시오
select deptno, round(avg(sal), 0)
from emp
where sal >= 300
group by deptno
having avg(sal)>=400
order by avg(sal);

select round(avg(sal), 0), (select deptno from emp group by deptno having avg(sal)>=400) as deptno_avg
from emp
where sal >= 300
group by deptno
order by avg(sal);

select * from emp;


-- 문36) hiredate칼럼을 사용하여 월별로 입사한 인원수를 구하시오
-- 변환함수 : to_char(원래날짜, '원하는 모양')

select extract(month from hiredate) hire_month, count(*)
from emp
group by extract(month from hiredate);

-- 강사님 풀이

-- 입사일 조회
select hiredate from emp;

-- 입사일에서 월 가져오기
select to_char(hiredate, 'mm') from emp;
select to_char(hiredate, 'mm') as 월 from emp;

select to_char(hiredate, 'yy') as 입사년도 from emp;
select to_char(hiredate, 'dd') as 일 from emp;

-- 월별 입사 인원수
select to_char(hiredate, 'mm') hire_month, count(*)
from emp
group by to_char(hiredate, 'mm');


-- 문37) 매니저별 담당인원수를 조회하시오
select mgr, count(*)
from emp
group by mgr;


-- 문38) 사원번호 7654와 급여보다 적은 행을 조회하시오
select
     empno
    ,ename
    ,sal
from
    emp
where
    sal<(select sal from emp where empno=7654);


-- 문39) 부서별로 급여+커미션를 구했을때  최대값, 최소값, 평균값(반올림 해서)을 부서순으로 조회하시오
select
     deptno
    ,max(sal+nvl(comm,0)) dept_max
    ,min(sal+nvl(comm,0)) dept_min
    ,round(avg(sal+nvl(comm,0)),1) dept_avg
from
    emp
group by
    deptno
order by
    deptno asc;

select max(sal) from emp;


-- 문40) 각 직원들에 대해서 직원의 이름과 근속년수를 구하시오
--       단, 근속년수는 연단위를 버림하여 나타내시오
select
     ename
    ,hiredate
    ,(extract(year from sysdate) - extract(year from hiredate)) as 근속년수
from
     emp     
order by
     근속년수 desc;

-- 강사님 풀이
-- 이름, 입사일을 입사일순으로 조회하기
select ename, hiredate from emp order by hiredate;

-- 근속일 : 현재날짜 - 입사일
select ename, hiredate, sysdate-hiredate from emp;

-- (현재 날짜 - 입사일) / 365
select ename, hiredate, (sysdate-hiredate)/365 from emp;

-- (현재 날짜 - 입사일) / 365 -> 소수점 버림
select ename, hiredate, trunc((sysdate-hiredate)/365) from emp;

-- (현재 날짜 - 입사일) / 365 -> 소수점 버림 -> 칼럼명 변경
select ename, hiredate, trunc((sysdate-hiredate)/365) as 근속년수 from emp;

-- 근속년수 순으로 내림차순 정렬
select ename, hiredate, trunc((sysdate-hiredate)/365) as 근속년수
from emp
order by 근속년수 desc;


-- 문41) 아래와 같이 출력 하시오
--       예) 박지성의 근속년수 : 20년
select ename || '의 근속년수 : ' || trunc((sysdate-hiredate)/365) || '년' as result
from emp
order by hiredate;


-- 문42) 손흥민의 근속년수와 동일한 행을 조회(이름, 근속년수)하시오
select ename, trunc((sysdate-hiredate)/365) as 근속년수
from emp
where trunc((sysdate-hiredate)/365) = (select trunc((sysdate-hiredate)/365) from emp where ename = '손흥민');

-- 강사님풀이
-- 손흥민 조회하기
select * from emp where ename='손흥민';

-- 손흥민의 근속년수 구하기
select hiredate from emp where ename='손흥민';
select sysdate-hiredate from emp where ename='손흥민';
select (sysdate-hiredate)/365 from emp where ename='손흥민';
select trunc((sysdate-hiredate)/365) from emp where ename='손흥민';

-- 결과
select ename, hiredate, sysdate, trunc((sysdate-hiredate)/365) as 근속년수
from emp
where trunc((sysdate-hiredate)/365) = (
                                        select trunc((sysdate-hiredate)/365)
                                        from emp
                                        where ename = '손흥민'
                                       ); -- 손흥민의 근속년수를 서브쿼리로 넣기

-- 근속 달수 구하기
select ename, trunc((sysdate-hiredate)/365*12) as 근속달수
from emp;

select ename, trunc(months_between(sysdate, hiredate)) as 근속달수
from emp;



-- 문43) 입사한지 만15년 이상된 사람에 한해 현재연봉에서 10% 인상시켰을 때 
--       사번, 이름, 입사일, 현재연봉, 인상후연봉, 인상된금액으로 고액연봉순으로 조회하시오
--       연봉구하는 식 : 급여(sal)*12개월+보너스(comm)

select
     empno
    ,ename
    ,hiredate
    ,trunc((sysdate-hiredate)/365) 근속년수
    ,sal*12+(nvl(comm,0)) 현재연봉
    ,(sal*12+(nvl(comm,0)))*0.1 인상액
    ,round((sal*12+(nvl(comm,0)))*1.1, 0) 인상후연봉    
from
     emp
where
     trunc((sysdate-hiredate)/365) >= 15
order by
     sal desc;


-- 문44) 입사년도가 짝수인 직원들의 급여의 평균을 job별로 출력하시오
select job, avg(sal)
from emp
where mod(extract(year from hiredate), 2) = 0
group by job;

select job, avg(sal)
from emp
where mod(to_char(hiredate, 'yy'), 2) = 0
group by job;

commit;