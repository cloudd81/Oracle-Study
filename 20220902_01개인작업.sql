파일 > 새로 만들기 > 데이터베이스계층 > 데이터베이스 파일
C:\java202207\database\20220902_01개인작업.sql
/////////////////////////////////////////////////////////////////////////////

-- 4) 상품옵션 테이블 생성
create table spinfo_op(
     si_num     number(10)      primary key     -- 일련번호
    ,si_code    varchar2(20)    not null        -- 상품코드
    ,constraint spinfo_op_si_code_fk foreign key(si_code)
     references sangpum(sp_code)
     on delete set null                         -- 상품코드 FK 코드
    ,si_opcode  varchar2(30)    unique          -- 옵션코드
    ,si_opname  varchar2(30)    not null        -- 옵션이름
    ,si_price   number(10)      not null        -- 상품가격
);

drop table spinfo_op;

-- 일련번호를 위한 시퀀스 생성
create sequence spinfo_op_seq;
drop sequence spinfo_op_seq;


-- 상품옵션 테이블 행추가
insert into spinfo_op(si_num, si_code, si_opcode, si_opname, si_price)
            values(spinfo_op_seq.nextval, 'B5', 'B101', '다크통밀 베이글', 2800);
insert into spinfo_op(si_num, si_code, si_opcode, si_opname, si_price)
            values(spinfo_op_seq.nextval, 'B5', 'B102', '세서미 베이글', 2800);
insert into spinfo_op(si_num, si_code, si_opcode, si_opname, si_price)
            values(spinfo_op_seq.nextval, 'M1', 'M101', '순살 소갈비찜', 59000);
insert into spinfo_op(si_num, si_code, si_opcode, si_opname, si_price)
            values(spinfo_op_seq.nextval, 'M1', 'M102', '소고기 잡채', 10000);
insert into spinfo_op(si_num, si_code, si_opcode, si_opname, si_price)
            values(spinfo_op_seq.nextval, 'M1', 'M103', '모듬전 세트', 45000);


select * from spinfo_op;



-- 8) 구매후기 테이블
create table review(
     rno        number(5)       primary key         -- 일련번호
    ,r_num      varchar2(10)    check('N' or 'C')   -- 번호(N : 공지사항, C : 일반게시글)
    ,r_photo    varchar2(20)                        -- 상품사진
    ,constraint review_photo_fk foreign key(r_photo)
     references sangpum(sp_img)
     on delete set null                             -- 상품사진 FK 코드
    ,r_name     varchar2(255)                       -- 상품명
    ,constraint review_name_fk foreign key(r_name)
     references sangpum(sp_pname)
     on delete cascade                              -- 상품명 FK 코드
    ,r_title    varchar2(255)   not null            -- 제목
    ,r_mem      varchar2(100)   not null            -- 작성자
    ,constraint review_mem_fk foreign key(r_mem)
     references member(mt_name)
     on delete cascade                              -- 작성자 FK 코드
    ,r_date     date            default sysdate     -- 작성일
    ,r_like     number(10)      default 0           -- 도움
    ,r_view     number(10)      default 0           -- 조회
)

-- 일련번호를 위한 시퀀스 생성
create sequence review_seq;
drop sequence review_seq;

-- 상품옵션 테이블 행추가
insert into review(rno, r_num, r_photo, r_name, r_title, r_mem, r_date, r_like, r_view)
            values(review_seq.nextval, 'N', null, null, '금주의 Best 후기 안내', '관리자', 2019-11-01, 1, 611701);
insert into review(rno, r_num, r_photo, r_name, r_title, r_mem, r_date, r_like, r_view)
            values(review_seq.nextval, 'C', 'M5.png', '차돌 된장찌개', '자취생들에게 강력 추천', '김아무개', 2022-08-28, 0, 0);
insert into review(rno, r_num, r_photo, r_name, r_title, r_mem, r_date, r_like, r_view)
            values(review_seq.nextval, 'C', 'M1.png', '추석 상차림 골라담기', '백슉이 읍자너', '강고집', 2022-08-28, 0, 0);





-- 11) 문의 테이블
create table ques(
     q_num      number(5)       primary key             -- 접수번호
    ,q_id       varchar2(20)    not null                -- 아이디
    ,constraint ques_id_fk foreign key(q_id)
     references member(mt_id)
     on delete cascade                                  -- 아이디 FK 코드
    ,q_type     varchar2(5)     not null                -- 유형
    ,constraint ques_type_fk foreign key(q_type)
     references q_category(qc_type)
     on delete cascade                                  -- 유형 FK 코드
    ,q_subcg    varchar2(20)    not null                -- 상세 유형
    ,constraint ques_subcg_fk foreign key(q_subcg)
     references q_subct(qc_s)
     on delete cascade                                  -- 상세 유형 FK 코드
    ,q_ordernum varchar2(20)    not null                -- 결제 번호
    ,constraint ques_ordernum_fk foreign key(q_ordernum)
     references payment(pt_on)
     on delete cascade                                  -- 결제 번호 FK 코드
    ,q_title    varchar2(255)   not null                -- 제목
    ,q_cont     varchar2(2000)  not null                -- 내용
    ,q_photo    varchar2(255)
    ,q_agree    char(1)         check(between 0 and 1)  -- 0 : true / 1 : false
    ,q_answer   char(1)         check(between 0 and 1)  -- 0 : true / 1 : false
);



-- 일련번호를 위한 시퀀스 생성
create sequence ques_seq;
drop sequence ques_seq;

-- 상품옵션 테이블 행추가
insert into ques(q_num, q_name, q_type, q_subcg, q_ordernum, q_title, q_cont, q_photo, q_agree, q_answer)
            values(ques_seq.nextval, 'asd454545', 'qc_1', 'qcs1_2', '202209011011-001', '반품하고싶어요', '물건이 맘에 안들어서 반품하고싶습니다', 'a.jpg', 0, 0);
insert into ques(q_num, q_name, q_type, q_subcg, q_ordernum, q_title, q_cont, q_photo, q_agree, q_answer)
            values(ques_seq.nextval, 'ddddfsg8877', 'qc_3', 'qcs3_1', '202209011412-001', '상품이 상한 것 같아요', '음식이 상한 냄새가 납니다', 'b.jpg', 0, 0);
insert into ques(q_num, q_name, q_type, q_subcg, q_ordernum, q_title, q_cont, q_photo, q_agree, q_answer)
            values(ques_seq.nextval, 'hfberfber11', 'qc_5', 'qcs5_1', '202209010652-001', '상품이 누락된 것 같아요', '상품이 하나 빠져서 배송이 되었어욧', null, 0, 0);            