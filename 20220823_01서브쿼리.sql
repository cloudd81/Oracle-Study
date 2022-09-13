
파일 > 새로 만들기 > 데이터베이스계층 > 데이터베이스 파일
C:\java202207\database\20220823_01서브쿼리.sql
/////////////////////////////////////////////////////////////////////////////

● [서브쿼리]
 - sql문 속 또 다른 sql문
 - 테이블 내에서 다시 한번 쿼리문에 의해 레코드 조회 및 검색
 
-- 국어 점수의 평균을 조회하시오
select kor from sungjuk;
select avg(kor) from sungjuk;
select round(avg(kor),0) from sungjuk;              -- 66
select round(avg(kor),0) as avg_kor from sungjuk;

문1) 국어점수 평균(66)보다 잘한 국어점수를 조회하시오

select uname, kor from sungjuk where kor>=66;

select uname, kor from sungjuk where kor>=(select round(avg(kor),0) from sungjuk);


문2) 서울 지역의 국어 점수 평균보다 잘한 지역, 이름, 국어 점수를 조회하시오
select addr, uname, kor
from sungjuk
where kor>=(select round(avg(kor),0) from sungjuk where addr='Seoul');


문3) 서울지역의 국어점수 평균보다 잘한 국어점수가 다른 지역에 있는지 조회하시오
select uname, addr, kor, (select round(avg(kor),0) from sungjuk where addr='Seoul') avg_kor
from sungjuk
where kor>=(select round(avg(kor),0) from sungjuk where addr='Seoul')
and addr!='Seoul';


문4) 국어점수의 최소값보다 이하 점수가 수학 또는 영어점수에 있는지 조회하시오
select uname, mat, eng, (select min(kor) from sungjuk) as min_kor
from sungjuk
where mat<=(select min(kor) from sungjuk)
or eng<=(select min(kor) from sungjuk);

