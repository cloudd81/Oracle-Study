
파일 > 새로 만들기 > 데이터베이스계층 > 데이터베이스 파일
C:\java202207\database\20220822_04제약조건.sql
/////////////////////////////////////////////////////////////////////////////

● [자료형]

 1) 문자형
    - 가변형 varchar(5)    'SKY'   예) 아이디, 비밀번호, 이름, 주소 ~~
    - 고정형 char(5)       'SKY'   예) 주민번호, 우편번호, 계좌번호 ~~
    
 2) 숫자형
    - int (정수형)

 3) 날짜형
    - 년월일시분초
    - 구분기호 - 와 / 기호를 사용한다
    - 문자열 타입으로 입력한다
    - date
    
//////////////////////////////////////////////////////////////////////////////

● [테이블 제약조건]

1) primary key
    : 기본키, 유일성
    : 모든 테이블에는 이 primary key가 꼭 하나 이상은 배정되어있어야 한다.
    : where 조건절에 걸릴 수 있는 대표적인 칼럼을 강제할 수 있다.
    : 중복을 허용하지 않음.
    : null값을 허용하지 않음(빈값을 허용하지 않음, 반드시 입력해야 함).
    예) 주민번호, 핸드폰 번호, 계좌번호, 아이디, 이메일 ~~


2) not null
    : 빈 값을 허용하지 않음.

3) check
    : 입력할 값을 특정 범위로 제하는 조건.

4) default
    : 사용자가 값을 입력하지 않으면 해당 칼럼이 정의한 기본값을 자동으로 입력해준다.
    
5) unique
    : primary key는 아니지만 중복되어진 데이터를 받지 않게 하는 조건이다.
    : primary key와 unique의 차이점은 unique는 null 값을 한번 허용한다는 것이다

6) foreign key
    : 일명 외래키라고 불린다.
    : 테이블을 서로 조인하는 경우 부모와 자식 관계를 설정할 때 사용한다.

//////////////////////////////////////////////////////////////////////////////

-- sungjuk 테이블 삭제

drop table sungjuk;

-- sungjuk 테이블 생성

create table sungjuk(
     sno    int          primary key                    -- 기본키(유일성)
    ,uname  varchar(50)  not null
    ,kor    int          check(kor between 0 and 100)   -- 국어점수 0 ~ 100 사이만 입력 가능
    ,eng    int          check(eng between 0 and 100)   -- 영어점수 0 ~ 100 사이만 입력 가능
    ,mat    int          check(mat between 0 and 100)   -- 수학점수 0 ~ 100 사이만 입력 가능
    ,addr   varchar(20)  check(addr in('Seoul', 'Jeju', 'Busan', 'Suwon'))
    ,tot    int          default 0
    ,aver   int          default 0
    ,wdate  date         default sysdate                -- 현재 날짜 함수
);

///////////////////////////////////////////////////////////////////////////////////

● [테이블 제약조건 에러메세지]

--primary key 제약조건
--ORA-00001: unique constraint (SYSTEM.SYS_C007030) violated
--sno 칼럼은 기본키(PK)이므로 중복된 값을 허용하지 않음
insert into sungjuk(sno, uname) values(1, '홍길동');   -- 2번 실행시 에러 발생

--not null 제약조건
--ORA-01400: cannot insert NULL into ("SYSTEM"."SUNGJUK"."UNAME")
--uname 칼럼에 반드시 값을 입력해야 함
insert into sungjuk(sno) values(1);


--check 제약조건
--ORA-02290: check constraint (SYSTEM.SYS_C007028) violated
--국영수 점수는 0-100사이만 가능
insert into sungjuk(sno, uname, kor, eng, mat)
values(1, '홍길동', -10, 20, 300);

--ORA-02290: check constraint (SYSTEM.SYS_C007029) violated
--addr값은 'Seoul', 'Jeju', 'Busan', 'Suwon' 값만 가능
insert into sungjuk(sno, uname, kor, eng, mat, addr)
values(1, '홍길동', 10, 20, 30, 'Incheon');



--default 제약조건
--tot과 aver는 0 입력, wdate는 현재 날짜가 입력됨
insert into sungjuk(sno, uname, kor, eng, mat, addr)
values (2, '무궁화', 10, 20, 30, 'Seoul');

select * from sungjuk;



-- 
insert into sungjuk(sno, uname, kor, eng, mat)
values (2, '무궁화', 10, 20, 30, 'Seoul');