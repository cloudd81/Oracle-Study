
파일 > 새로 만들기 > 데이터베이스계층 > 데이터베이스 파일
C:\java202207\database\20220823_02오라클함수.sql
/////////////////////////////////////////////////////////////////////////////

● [오라클 함수]

-- 가상 테이블 : dual

1. 문자열 함수

select lower('Hello World') from dual;          -- hello world, 해당 컬럼의 값을 소문자로 변환하는 함수
select upper('Hello World') from dual;          -- HELLO WORLD, 해당 컬럼의 값을 대문자로 변환하는 함수
select length('Hello World') from dual;         -- 11, 문자열의 총 길이를 세는 함수
select substr('Hello World', 1, 5) from dual;   -- Hello, 문자열의 1번째자리부터 5자까지 추출하는 함수

select instr('HelloWorld', 'W') from dual;      -- 6, 문자열에서 특정문자의 위치를 세는 함수,만약 특정문자가 문자열에 없다면 0 반환
select lpad('SKY', 5, '*') from dual;           -- **SKY, 해당길이에 부족한 부분은 왼쪽부터 특정문자로 채우는 함수
select rpad('SKY', 5, '*') from dual;           -- SKY**, 해당길이에 부족한 부분은 오른쪽부터 특정문자로 채우는 함수
select replace('happy', 'p', 'k') from dual;    -- hakky, 문자열에서 해당 문자를 다른 문자로 바꾸어주는 함수

select chr(65) from dual;                       -- ACKII 문자변환
select chr(66) from dual;
select chr(97) from dual;
select chr(98) from dual;

-- 문자열 연결하기
select concat('로미오', '줄리엣') from dual;    -- 로미오줄리엣
-- concat(칼럼명, '문자열')
select concat(uname, '의 평균은 '), concat(aver, '입니다.') from sungjuk;


-- || 결합연산자
select uname || '의 평균은 ' || aver || '입니다' from sungjuk;
select uname || '의 평균은 ' || aver || '입니다' as str from sungjuk;
//////////////////////////////////////////////////////////////////////////////////



2. 숫자 관련 함수
select abs(-7) from dual;           -- 절대값
select mod(5,3) from dual;          -- 나머지 연산자
select ceil(12.4) from dual;        -- 13, 올림함수
select floor(12.4) from dual;       -- 12, 내림함수
select trunc(13.56, 1) from dual;   -- 13.5, 버림함수(소수점 첫째짜리만 남기고 버림)
select round(13.56, 1) from dual;   -- 13.6, 반올림함수(소수점 둘째짜리에서 반올림)

select avg(kor) from sungjuk;           -- 66.36363636363636363636363636363636363636
select ceil(avg(kor)) from sungjuk;     -- 67
select trunc(avg(kor), 1) from sungjuk; -- 66.3
select round(avg(kor), 1) from sungjuk; -- 66.4


-- to_number('3') 문자열을 숫자형으로 바꿔주는 함수
select to_number('123')+1 from dual;    -- 124
select '100'+1 from dual;               -- 101, 내부적으로 to_number()가 호출됨
////////////////////////////////////////////////////////////////////////////////


3. 날짜 관련 함수

select sysdate from dual;                       -- 시스템에서 현재 날짜와 시간 정보를 리턴하는 함수

-- sysdate에서 년월일 추출하기
select extract(year from sysdate) from dual;    -- 2022    
select extract(month from sysdate) from dual;   -- 8
select extract(day from sysdate) from dual;     -- 23

-- sysdate 연산하기
select sysdate+100 from dual;                   -- 오늘 날짜 +100일
select sysdate-100 from dual;                   -- 오늘 날짜 +100일


-- 두 개의 날짜데이터에서 개월 수 계산
select months_between('2022-08-23', '2022-05-25') from dual;    -- 2.93
select months_between('2022-08-23', '2022-12-25') from dual;    -- -4.06

-- 문자열을 날짜형으로 변환
select to_date('2022-10-25') from dual;
select to_date('2022-10-25') - to_date('2022-10-30') from dual; -- -5

///////////////////////////////////////////////////////////////////////////////


● nvl() 함수
 maria DB == ifnull()

select * from sungjuk;

문제) 주소가 'Incheon'인 행의 국어점수 최대값, 인원수를 조회하시오
select max(kor), count(*)
from sungjuk
where addr='Seoul';
-- 하지만 이건 틀렸지

select max(kor), count(*)
from sungjuk
where addr='Incheon' and kor=(select max(kor) from sungjuk where addr='Incheon');

select count(*)+1       -- 0+1
from sungjuk
where addr='Incheon';

select max(kor)+1       -- null, null은 연산이 되지 않음
from sungjuk
where addr='Incheon';

select nvl(max(kor), 0) -- null값이면 0으로 대체함
from sungjuk
where addr='Incheon';

select nvl(max(kor), 0)+1 as max_kor -- 1
from sungjuk
where addr='Incheon';

////////////////////////////////////////////////////////////////////////////////


● 모조칼럼
 - rownum   : 행번호
 - rowid    : 행의 주소값
 
select sno, uname, addr, rownum, rowid
from sungjuk
where rownum>=1 and rownum<=5;

select sno, uname, addr, rownum, rowid
from sungjuk
where addr='Seoul';

-- 자신의 행번호를 포함해서 정렬됨, rownum을 추가하는 시점도 고려해야함.
select sno, uname, addr, rownum, rowid
from sungjuk
order by uname;