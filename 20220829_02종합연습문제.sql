
파일 > 새로 만들기 > 데이터베이스계층 > 데이터베이스 파일
C:\java202207\database\20220829_02종합연습문제.sql
/////////////////////////////////////////////////////////////////////////////


● [종합 연습문제]

select * from tb_student;
select * from tb_gwamok;
select * from tb_sugang;

select count(*) from tb_student; -- 6
select count(*) from tb_gwamok; -- 9
select count(*) from tb_sugang; -- 14


문1) 디자인 교과목중에서 학점이 제일 많은 교과목을 수강신청한 명단을 조회하시오
    (학번, 이름, 과목코드)
    
    g1005	진달래	d002
    ;

-- 1) 디자인 교과목 신청명단
select SU.hakno, uname, SU.gcode, gname, ghakjum
from tb_sugang SU join tb_student ST
on SU.hakno = ST.hakno join tb_gwamok GW
on SU.gcode = GW.gcode
where SU.gcode like 'd%';

-- 1)에 조건주기
select *
from(
    select SU.hakno, uname, SU.gcode, ghakjum
    from tb_sugang SU join tb_student ST
    on SU.hakno = ST.hakno join tb_gwamok GW
    on SU.gcode = GW.gcode
    where SU.gcode like 'd%'
    ) AA
where ghakjum = (
                select max(ghakjum)
                from tb_gwamok
                where gcode like 'd%'
                );

-- 1)하고 2)를 합칠 수도 있구나~
select SU.hakno, uname, SU.gcode
from tb_sugang SU join tb_student ST
on SU.hakno = ST.hakno join tb_gwamok GW
on SU.gcode = GW.gcode
where SU.gcode like 'd%' and ghakjum = (
                                        select max(ghakjum)
                                        from tb_gwamok
                                        where gcode like 'd%'
                                        );


문2) 학번별 수강신청한 총학점을 구하고 학번별 정렬해서 줄번호 4~6행 조회하시오
    - 단, 수강신청하지 않은 학생의 총학점도 0으로 표시

        g1004	0	4
        g1005	12	5
        g1006	3	6

-- 1) 전체 학생들의 총학점 구하기
select ST.hakno, sum(nvl(GW.ghakjum, 0))
from tb_student ST left join tb_sugang SU
on ST.hakno = SU.hakno left join tb_gwamok GW
on SU.gcode = GW.gcode
group by ST.hakno
order by ST.hakno;


-- 2) AA 테이블로 만들어서 rownum로 줄번호 붙이기
select hakno, sumhak, rownum
from (
    select ST.hakno as hakno, sum(nvl(GW.ghakjum, 0)) as sumhak
    from tb_student ST left join tb_sugang SU
    on ST.hakno = SU.hakno left join tb_gwamok GW
    on SU.gcode = GW.gcode
    group by ST.hakno
    order by ST.hakno
    ) AA;
    
select *
from tb_student ST left join tb_sugang SU
on ST.hakno = SU.hakno;

-- 3) 2)의 결과에 붙여진 줄번호에 조건절로 4~6행만 조회하기
select *
from (
    select hakno, sumhak, rownum as rnum
    from (
        select ST.hakno as hakno, sum(nvl(GW.ghakjum, 0)) as sumhak
        from tb_student ST left join tb_sugang SU
        on ST.hakno = SU.hakno left join tb_gwamok GW
        on SU.gcode = GW.gcode
        group by ST.hakno
        order by ST.hakno
        ) AA
    ) BB
where rnum between 4 and 6;


-- 강사님 풀이
select *
from (
    select BB.hakno, BB.uname, BB.총학점2, rownum as rnum
    from (
        select ST.hakno, uname, nvl(총학점,0) as 총학점2
        from tb_student ST left join (
                                        select SU.hakno, sum(GW.ghakjum) as 총학점
                                        from tb_sugang SU join tb_gwamok GW
                                        on SU.gcode = GW.gcode
                                        group by SU.hakno
                                     ) AA
        on ST.hakno = AA.hakno
        order by hakno
        ) BB
    ) CC
where rnum between 4 and 6;


문3) 학번별로 수강신청 총학점을 구하고, 총학점순으로 내림차순 정렬후
     위에서 부터 1건만 조회하시오 (학번, 이름, 총학점) 
-- 수강테이블에 행추가 해주세요
-- (총학점이 다 같은 값이여서 결과확인하기가 조금 애매 합니다)
insert into tb_sugang(sno,hakno,gcode) values(sugang_seq.nextval,'g1001','p005');
commit;


-- 1) 학번별 수강신청 총학점 구한 뒤 총학점 순으로 내림차순 정렬
select SU.hakno, uname, sum(ghakjum)
from tb_sugang SU join tb_student ST
on SU.hakno = ST.hakno join tb_gwamok GW
on SU.gcode = GW.gcode
group by SU.hakno, uname
order by sum(ghakjum) desc;

-- 2) 1)의 결과를 AA 테이블로 만든 뒤 rownum을 붙이고 1건만 조회
select hakno, uname, sum_hak, rownum
from (
    select SU.hakno, uname, sum(ghakjum) as sum_hak
    from tb_sugang SU join tb_student ST
    on SU.hakno = ST.hakno join tb_gwamok GW
    on SU.gcode = GW.gcode
    group by SU.hakno, uname
    order by sum(ghakjum) desc
    ) AA
where rownum = 1;

----------------------------------------