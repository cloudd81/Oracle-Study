파일 > 새로 만들기 > 데이터베이스계층 > 데이터베이스 파일
C:\java202207\database\20220830_04index.sql
/////////////////////////////////////////////////////////////////////////////

● [index 색인]
  - 더 빠른 검색을 위한 인덱스
  - 데이터를 빠르게 찾을 수 있는 수단
  - 테이블에 대한 조회 속도를 높여 주는 자료구조
  - PK칼럼은 자동으로 인덱스 생성된다

● [인덱스 방식]  
- full scan
처음부터 끝까지 일일이 검사하는 방법. 전수조사        

- index range scan
이름이 여러개인 경우 목차를 찾아서 페이지를 찾아감
훨씬 빠름. 별도의 메모리가 있어야 함.

- index unique scan
학번은 1개만 존재함. 유일한 값

● [인덱스 생성]   
- 형식) create index 인덱스명 on 테이블명(칼럼명)
  
  
● [인덱스 삭제]  
- 형식) drop index 인덱스명


--테이블생성
create table emp2(
   id       number(5)    
  ,name     varchar2(25)
  ,salary   number(7, 2)
  ,phone    varchar2(15)
  ,dept_id  number(7)
);
--행추가 
insert into emp2(id,name) values (10,'kim');
insert into emp2(id,name) values (20,'park');
insert into emp2(id,name) values (30,'hong');
commit;


-- 인덱스 생성 전
select * from emp2 where name='hong';  -- 커서 여기에 놓고 F10

-- 인덱스 생성 후
create  index emp2_name_idx on emp2(name);
drop    index emp2_name_idx on emp2(name); -- 인덱스 삭제


select * from emp2 where name='kim';    -- 커서 여기에 놓고 F10
-- F10 계획설명 보기 -> unique scan, cost 1


● [연습 2] - PK가 있는 테이블

-- PX는 인덱스가 자동으로 생성되면서 정렬된다

create table emp3 (
   no    number       primary key
  ,name varchar2(10)
  ,sal  number
);

select * from emp3 where no=3;
-- F10 계획설명 보기 -> unique scan, cost 1


-- 연습3)
-- 100만건의 레코드 대상으로 cost 비교
create table emp4(
   no     number
  ,name   varchar2(10)
  ,sal    number
);



프로시저를 이용해서 100만행 추가하기 ############################################
declare -- 선언문
    -- 변수 선언
    i       number          := 1;       -- i변수에 1 대입, := 연산자
    name    varchar2(20)    := 'kim';
    sal     number          := 0;
    
begin
    -- T-SQL문
    while i<=1000000 loop
        if i mod 2 = 0 then
            name := 'kim' || to_char(i);
            sal  := 300;
        elsif i mod 3 = 0 then
            name := 'park' || to_char(i);
            sal  := 400;
        elsif i mod 4 = 0 then
            name := 'hong' || to_char(i);
            sal  := 500;
        else
            name := 'shin' || to_char(i);
            sal  := 250;
        end if;
        
        insert into emp4(no, name, sal) values (i, name, sal); -- 행추가
        i := i+1;        
    end loop;
    
end;
################################################################################;

commit;
select * from emp4;
select count(*) from emp4;


-- 1) 인덱스를 사용하지 않은 경우
select * from emp4 where name='kim466'; -- 실행하고 난 후, 여기에 커서 놓고 F10 계획 설명
                                        -- FULL scan, COST 893

select * from emp4 where no=466;        -- FULL scan, COST 892

select * from emp4 where sal>300;       -- FULL scan, COST 893


-- 2) 인덱스를 사용한 경우
create  index emp4_name_idx on emp4(name);
drop    index emp4_name_idx; 


select * from emp4 where name='kim466';

-- name 칼럼과 sal 칼럼을 기준으로 인덱스 생성
create index emp4_name_sal_idx on emp4(name, sal);

select * from emp4 where name='kim466' and sal>200; -- RANGE scan, COST 3


-- 인덱스 데이터 사전으로 인덱스 확인하기
select * from user_indexes;
select * from user_indexes where index_name like 'EMP4%';