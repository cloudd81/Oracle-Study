
파일 > 새로 만들기 > 데이터베이스계층 > 데이터베이스 파일
C:\java202207\database\20220826_01테이블조인.sql
/////////////////////////////////////////////////////////////////////////////

● [테이블 조인]
 - 여러 테이블을 하나의 테이블처럼 사용하는 조인
 - 두 개 이상의 테이블을 결합하여 데이터를 추출하는 기법
 - 두 테이블의 공통값을 이용하여 컬럼을 조합하는 수단
 
 
    형식)
        select 칼럼명
        from 테이블1 join 테이블2
        on 조건절;                     -- ANSI(표준) SQL문
        
        select 칼럼명
        from 테이블1, 테이블2
        on 조건절;                     -- Oracle DB SQL문

        
    예시 1 - 테이블 조인하기)
        select T1.*, T2.*              -- T1.모든칼럼, T2.모든칼럼
        from T1 join T2
        on T1.x = T2.x;                -- 테이블명.칼럼명
        
        
    예시 2 - 3개 테이블 조인)
        select T1.*, T2.*, T3.*
        from T1 join T2
        on T1.x = T2.x join T3         -- 3개 테이블 조인
        on T1.y = T3.y;


    예시 3 - 4개 테이블 조인)
        select T1.*, T2.*, T3.*, T4.*
        from T1 join T2
        on T1.x = T2.x join T3
        on T1.y = T3.y join T4         -- 4개 테이블 조인
        on T1.z = T4.z;
        

● 조건걸 : where 조건절, having 조건절, on조건절


● 물리적 테이블과 논리적 테이블은 서로 동등한 관계이다
    - 물리적 테이블 : 실제 create table한 테이블
    - 논리적 테이블 : SQL문에 의해 가공된 테이블
    
    select * from tb_student;
    select count(*) from tb_student;
    

● inner join 연습   

    select * from tb_sugang;

-- 학번 기준으로 수강테이블과 학생 테이블 조인    
select tb_sugang.*, tb_student.*
from tb_sugang join tb_student
on tb_sugang.hakno = tb_student.hakno;


-- 두 테이블간의 교집합 조인. inner 생략가능. 가장 기본.
select tb_sugang.*, tb_student.*
from tb_sugang inner join tb_student
on tb_sugang.hakno = tb_student.hakno;


-- 수강신청한 학생들의 학번, 과목코드, 이름, 이메일 조회하시오
select tb_sugang.*, tb_student.uname, tb_student.email
from tb_sugang inner join tb_student
on tb_sugang.hakno = tb_student.hakno;


-- 과목코드를 기준으로 수강테이블과 과목테이블 조인
select tb_sugang.*, tb_gwamok.gname, tb_gwamok.ghakjum
from tb_sugang inner join tb_gwamok
on tb_sugang.gcode = tb_gwamok.gcode;


-- 3개 테이블 조인
select tb_sugang.*, tb_student.uname, tb_gwamok.gname
from tb_sugang inner join tb_student
on tb_sugang.hakno = tb_student.hakno join tb_gwamok
on tb_sugang.gcode = tb_gwamok.gcode
order by tb_sugang.hakno;


-- 테이블명의 alias(별칭)도 가능하다
select SU.*, ST.uname, ST.email
from tb_sugang SU join tb_student ST
on SU.hakno = ST.hakno;

select SU.*, GW.gname, GW.ghakjum
from tb_sugang SU join tb_gwamok GW
on SU.gcode = GW.gcode;

select SU.*, ST.uname, ST.email, GW.gname, GW.ghakjum
from tb_sugang SU join tb_student ST
on SU.hakno = ST.hakno join tb_gwamok GW
on SU.gcode = GW.gcode;


-- 조회시 테이블간에 중복되지 않은 칼럼명은 테이블명을 생략할 수 있다
select SU.*, uname, email, gname, ghakjum
from tb_sugang SU join tb_student ST
on SU.hakno = ST.hakno join tb_gwamok GW
on SU.gcode = GW.gcode;
//////////////////////////////////////////////////////////////////////////////



● [테이블 조인 연습]

-- tb_student 테이블 전체 레코드 갯수
select count(*) from tb_student;    -- 6

-- tb_gwamok 테이블 전체 레코드 갯수
select count(*) from tb_gwamok;    -- 9

-- tb_sugang 테이블 전체 레코드 갯수
select count(*) from tb_sugang;    -- 13


select * from tb_student;
select * from tb_gwamok;
select * from tb_sugang;
commit;

문1)수강신청을 한 학생들 중에서 '제주'에 사는 학생들만 학번, 이름, 주소를 조회하시오

select SU.hakno, uname, address
from tb_sugang SU join tb_student ST
on SU.hakno = ST.hakno and ST.address = '제주';


-- AA 별칭 만들기
select AA.hakno, AA.uname, AA.address
from (
        select SU.hakno, uname, address
        from tb_sugang SU join tb_student ST
        on SU.hakno = ST.hakno
    ) AA
where AA.address = '제주';


-- AA 별칭 생략하기
select hakno, uname, address
from (
        select SU.hakno, uname, address
        from tb_sugang SU join tb_student ST
        on SU.hakno = ST.hakno
    ) AA
where AA.address = '제주';


-- 칼럼명이 노출되었을 때는 *을 쓸 수 있다.
select *
from (
        select SU.hakno, uname, address
        from tb_sugang SU join tb_student ST
        on SU.hakno = ST.hakno
    ) AA
where AA.address = '제주';


문2) 지역별로 수강신청 인원수, 지역을 조회하시오
     서울 2명
     제주 2명  

select AA.address, count(*) || '명'
from(
    select SU.hakno, address
    from tb_sugang SU join tb_student ST
    on SU.hakno = ST.hakno
    group by SU.hakno, address
     ) AA
group by AA.address;    

select ST.address, count(distinct(ST.hakno))
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno
group by address;


-- 1) 수강테이블 조회
select * from tb_sugang;


-- 2) 수강 신청한 학생들의 명단(학번)
select hakno from tb_sugang order by hakno;
select distinct(hakno) from tb_sugang order by hakno;
select hakno from tb_sugang group by hakno order by hakno;


-- 3) 

select AA.hakno, ST.address
from (
        select hakno from tb_sugang group by hakno order by hakno
    ) AA join tb_student ST
on AA.hakno = ST.hakno;


-- 3)의 결과를 BB 테이블로 만든 후 주소별 그룹 후 행 갯수 구하기

select BB.address, count(*) || '명'
from (
        select AA.hakno, ST.address
        from (
                select hakno from tb_sugang group by hakno order by hakno
            ) AA join tb_student ST
        on AA.hakno = ST.hakno
    ) BB
group by BB.address;


문3) 과목별 수강 신청 인원수, 과목코드, 과목명를 조회하시오 
     d001	HTML	    2명
     d002	포토샵	    1명
     d003	일러스트    1명
     p001	JAVA	    4명
     p002	Oracle	    2명
     p003	JSP	        2명
     p004	Python	    1명
     
     
select SU.gcode, gname, concat(count(*), '명') as cnt
from tb_sugang SU join tb_gwamok GW
on SU.gcode = GW.gcode
group by SU.gcode, gname
--having SU.gcode like 'p%' (프로그램 과목만 조회하기)
order by SU.gcode;
     
     
-- 강사님 풀이
select AA.gcode, GW.gname, concat(AA.cnt, '명')
from (
    select gcode, count(*) as cnt
    from tb_sugang
    group by gcode
    ) AA join tb_gwamok GW
on AA.gcode = GW.gcode -- and AA.gcode like 'p%' (프로그램 과목만 조회하기)
order by AA.gcode;
     
문4) 학번별 수강신청과목의 총학점을 학번별순으로 조회하시오
    g1001	홍길동	12학점
    g1002	홍길동	8학점
    g1005	진달래	12학점
    g1006	개나리	3학점

select SU.hakno, uname, sum(ghakjum) || '학점'
from tb_sugang SU join tb_student ST
on SU.hakno = ST.hakno join tb_gwamok GW
on SU.gcode = GW.gcode
group by SU.hakno, uname
order by SU.hakno;


-- 강사님 풀이
-- 1) 수강테이블에서 학번별로 조회
select hakno, gcode from tb_sugang order by hakno;


-- 2) 수강 테이블에 과목코드가 일치하는 학점을 과목 테이블에서 가져와서 붙이기
select SU.hakno, SU.gcode, ghakjum
from tb_sugang SU join tb_gwamok GW
on SU.gcode = GW.gcode;


-- 3) 2)의 결과를 AA로 만들고 학번을 그룹으로 묶고 학점을 sum 한다
select AA.hakno, sum(ghakjum)
from (
    select SU.hakno, SU.gcode, ghakjum
    from tb_sugang SU join tb_gwamok GW
    on SU.gcode = GW.gcode
    ) AA
group by AA.hakno;


-- 4) 3)의 결과를 BB테이블로 만들고, 학번을 기준으로 학생테이블에서 이름 가져와서 붙이기
select BB.hakno, ST.uname, concat(sum_hakjum, '학점')
from (
    select AA.hakno, sum(ghakjum) as sum_hakjum
    from (
        select SU.hakno, SU.gcode, ghakjum
        from tb_sugang SU join tb_gwamok GW
        on SU.gcode = GW.gcode
        ) AA
        group by AA.hakno
    )BB join tb_student ST
on BB.hakno = ST.hakno
order by BB.hakno;



문5) 학번 g1001이 수강신청한 과목을 과목코드별로 조회하시오
     g1001  p001  OOP
     g1001  p003  JSP  
     g1001  d001  HTML

-- 논리적 테이블 AA 만들어서 SQL문 사용하기
select AA.*
from(     
    select SU.hakno, SU.gcode, gname
    from tb_sugang SU join tb_student ST
    on SU.hakno = ST.hakno join tb_gwamok GW
    on SU.gcode = GW.gcode
    ) AA
where hakno = 'g1001'
order by gcode; 
        
-- where 조건절 사용하기
select SU.hakno, SU.gcode, gname
from tb_sugang SU join tb_student ST
on SU.hakno = ST.hakno join tb_gwamok GW
on SU.gcode = GW.gcode
where SU.hakno = 'g1001'            -- 실제 자바코드에서 학번을 변수처리한다
order by SU.gcode; 

-- and로 on 조건절에 추가하기
select SU.hakno, SU.gcode, gname
from tb_sugang SU join tb_student ST
on SU.hakno = ST.hakno join tb_gwamok GW
on SU.gcode = GW.gcode and SU.hakno = 'g1001'
order by SU.gcode;


문6)수강신청을 한 학생들의 학번, 이름 조회
    g1001	홍길동
    g1002	홍길동
    g1005	진달래
    g1006	개나리
    
-- 논리적 테이블 AA 만들어서 SQL문 사용하기
select *
from (
    select SU.hakno, uname
    from tb_sugang SU join tb_student ST
    on SU.hakno = ST.hakno join tb_gwamok GW
    on SU.gcode = GW.gcode
    ) AA
group by hakno, uname
order by hakno;

-- group by 직접 사용하기
select SU.hakno, uname -- count(uname) 됌
from tb_sugang SU join tb_student ST
on SU.hakno = ST.hakno join tb_gwamok GW
on SU.gcode = GW.gcode
group by SU.hakno, uname
order by SU.hakno;

-- distinct
select distinct(SU.hakno), uname -- count(uname) 안됌
from tb_sugang SU join tb_student ST
on SU.hakno = ST.hakno join tb_gwamok GW
on SU.gcode = GW.gcode
order by SU.hakno;


-- 강사님 풀이
select hakno, uname
from tb_student
where hakno in (select hakno from tb_sugang group by hakno);


문7)수강신청을 하지 않은 학생들의 학번, 이름 조회

select ST.hakno, ST.uname
from (
    select SU.hakno, uname
    from tb_sugang SU join tb_student ST
    on SU.hakno = ST.hakno join tb_gwamok GW
    on SU.gcode = GW.gcode
    ) AA -- 수강신청한 학생
    right join tb_student ST -- 전체 학생
on AA.hakno = ST.hakno
where AA.hakno is null -- 수강신청한 학생의 코드와 전체 학생 코드 중 겹치는 게 있으면
                       -- 수강신청한 학생의 코드를 null로 만들어라
                       -- 그러면 전체 학생 중 수강신청 안한 학생만 남는다
order by ST.hakno;



-- 강사님 풀이
select hakno, uname
from tb_student
where hakno not in (select hakno from tb_sugang group by hakno);




문8) daum이메일을 쓰는 학생은 누구고 학점은 몇점인가요? -- good

select * from tb_student;

select ST.hakno, ST.uname, email
from tb_student ST left outer join tb_sugang SU
on ST.hakno = SU.hakno
where email like '%daum%';


문9) 복수전공을 하고있는 학생들은 누구인가요? -- 디자인과와 프로그램과를 동시에 듣는 사람

select uname, AA.cnt as 복수전공
from (
    select SU.hakno, uname, count(*) as cnt
    from tb_sugang SU join tb_student ST
    on SU.hakno = ST.hakno join tb_gwamok GW
    on SU.gcode = GW.gcode
    group by SU.hakno, uname
    order by SU.hakno
    ) AA
where cnt <> 1;
    
