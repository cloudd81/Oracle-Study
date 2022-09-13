
파일 > 새로 만들기 > 데이터베이스계층 > 데이터베이스 파일
C:\java202207\database\20220829_03CSV변환.sql
/////////////////////////////////////////////////////////////////////////////

● [CSV 파일]
 - 모든 데이터가 , 로 구분되어 있는 파일

● [CSV 파일을 데이터베이스로 가져오기]
 - 공공데이터포털 https://data.go.kr/ 활용



 문) 도로명 우편번호 테이블 구축하기

-- 1) zipdoro.csv 준비 (258267행)

-- 2) zipdoro.csv 내용을 저장하는 zipdoro 테이블 생성

create table zipdoro (
     zipno      char(5)         -- 우편번호
    ,zipaddress varchar(1000)   -- 주소
);

commit;

-- 3) 가져오기와 내보내기
- zipdoro 테이블 우클릭 -> 데이터 임포트(가져오기)
- zipdoro 테이블 우클릭 -> export(내보내기)


문1) 서울특별시 강남구로 시작되는 우편번호가 몇개인지 확인하시오

select count(*)
from zipdoro
where zipaddress like '서울특별시 강남구%';


문2) 한국교원대학교_초중등학교위치.csv를 변환해서 테이블에 저장하시오
-- 비어있는 값을 찾으시오

create table school (
        schoolid            varchar(10)       -- 학교ID
    ,   schoolname       varchar(255)      -- 학교명
    ,   schoolgubun      varchar(20)        -- 학교급구분
    ,   schooladdr         varchar(255)      -- 소재지도로s명
    ,   cdate                date                  -- 생성일자 (형식 YYYY-MM-DD)
    ,   udate                date                  -- 변경일자 (형식 YYYY-MM-DD)
    ,   latitude              number(20,9)     -- 위도
    ,   longitude            number(20,9)     -- 경도
);

drop table eschool;

select * from school;
select count(*) from school;

select *
from whereschool
where address is null; -- 비어있는 값 : 다산한강중학교의 주소 ; 결측치



문) 각 시도별 초등학교, 중학교의 갯수
강원, 경기, 경상남도, 경상북도, 대구, 부산, 서울, 울산, 전라남도, 전라북도, 충청남도, 충청북도

select
     nvl(cho.addr1, '-') as 지역
    ,nvl(cho.ckinds, '초등학교') as 학교구분
    ,nvl(cho.c_cnt, 0) as 갯수
    ,nvl(jung.addr2, '-') as 지역
    ,nvl(jung.jkinds, '중학교') as 학교구분
    ,nvl(jung.j_cnt, 0) as 갯수
from(
    select addr1, ckinds, count(*) as c_cnt
    from (
        select substr(schooladdr, 0, instr(schooladdr, ' ')) as addr1, schoolgubun as ckinds
        from school
        )
    group by addr1, ckinds
    having ckinds like '초%'
    ) cho full join (
                select addr2, jkinds, count(*) as j_cnt
                from (
                    select substr(schooladdr, 0, instr(schooladdr, ' ')) as addr2, schoolgubun as jkinds
                    from school
                    )
                group by addr2, jkinds
                having jkinds like '중%'
                ) jung
on cho.addr1 = jung.addr2
order by cho.addr1;

-- 천우꺼
-- 초등학교, 중학교 선별
select *
from whereschool
where schoolgubun = '초등학교' or schoolgubun = '중학교';

-- 글자 자르기
select substr(schooladdr, 0, 2)
from whereschool;

-- 그룹화
select substr(schooladdr, 0, 2) as 지역, schoolgubun, count(substr(schooladdr, 0, 2)) cnt
from school
where schoolgubun = '초등학교' or schoolgubun = '중학교' and schooladdr is not null
group by substr(schooladdr, 0, 2), schoolgubun;