
파일 > 새로 만들기 > 데이터베이스계층 > 데이터베이스 파일
C:\java202207\database\20220819_01SQL기초.sql
/////////////////////////////////////////////////////////////////////////////


● [수업내용]
 - 테이블 생성, 삭제
 - Create, Read, Update, Delete
 
● [NCS 학습 모듈] - 응용SW 기초 기술 활용
  3-3 관계형 데이터베이스 테이블 조작 (p95)
  
  
/////////////////////////////////////////////////////////////////////////////

[성적]
이름      국어      영어      수학      총점      평균
--------------------------------------------------------
홍길동     100       90        80
진달래     85        75        60


[테이블 생성]
--형식)
   create table 테이블(
       칼럼명1  자료형  제약조건
      ,칼럼명2  자료형  제약조건
      ,칼럼명3  자료형  제약조건
      , ~~~
   );
   
--   sungjuk 테이블 생성
create table sungjuk(
     uname  varchar(20) -- 영문자 20글자 이내까지
    ,kor    int         -- 정수형
    ,eng    int
    ,mat    int
    ,tot    int
    ,aver   int
);

-- 칼럼의 순서는 의미가 없다


[테이블 삭제]
-- 형식) drop table 테이블명;
-- 주의) 테이블을 삭제하면 모든 데이터도 같이 삭제된다

-- sungjuk 테이블 삭제
drop table sungjuk;


[테이블 수정]
-- 형식) alter table 테이블명 수정사항


[관계형 DB에서 테이블의 핵심기능]
- C Create  생성  ->  insert문
- R Read    조회  ->  seletct문
- U Update  수정  ->  update문
- D Delete  삭제  ->  delete문


[문자열 데이터]
- 데이터베이스에서 문자열 데이터는 '' 로 감싼다

/////////////////////////////////////////////////////////////////////


● [sungjuk 테이블 CRUD 작업]

1. 행추가
형식) insert into 테이블명(칼럼명1, 칼럼명2, 칼럼명3, ~~~) 
      values (값1, 값2, 값3, ~~~);
      
insert into sungjuk(uname, kor, eng, mat)
values ('홍길동', 100, 90, 80);

insert into sungjuk(uname, kor, eng, mat)
values ('진달래', 85, 75, 50);


2. 조회 및 검색
형식) select 칼럼명1, 칼럼명2, 칼럼명3, ~~
        from 테이블명;


select uname, kor, eng, mat, tot, aver from sungjuk;

3. 행수정
형식) update 테이블명 set 칼럼명1 = 값1, 칼럼명2 = 값2, 칼럼명3 = 값3

update sungjuk set tot=kor+eng+mat, aver=(kor+eng+mat)/3;

4. 행삭제
형식) delete from 테이블명;

delete from sungjuk;
