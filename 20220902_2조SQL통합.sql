파일 > 새로 만들기 > 데이터베이스계층 > 데이터베이스 파일
C:\java202207\database\20220902_2조SQL통합.sql
/////////////////////////////////////////////////////////////////////////////


-- 1) sp_cate : 상품 대분류
--테이블생성
create table sp_cate(
     sp_num    varchar2(30)     PRIMARY KEY
    ,sp_name  varchar2(30)      not null
);
    
-- 행생성  
insert into sp_cate(sp_num,sp_name) values ('s1','국,반찬,메인요리');
insert into sp_cate(sp_num,sp_name) values ('s2','베이커리, 치즈, 델리');
insert into sp_cate(sp_num,sp_name) values ('s3','가전제품');

-- 확인
select * from sp_cate;

/////////////////////////////////////////////////////////////////////////////////////

-- 2) spsub_cate : 상품 중분류 
--테이블생성
create table spsub_cate(
     sp_subnum     varchar2(30)   PRIMARY KEY 
    ,sp_subname    varchar2(30)   not null
);
 
--행추가
insert into spsub_cate(sp_subnum,sp_subname) values ('s1_01','국·탕·찌개');
insert into spsub_cate(sp_subnum,sp_subname) values ('s1_02','밀키트·메인요리');
insert into spsub_cate(sp_subnum,sp_subname) values ('s1_03','밑반찬');
insert into spsub_cate(sp_subnum,sp_subname) values ('s2_01','식빵·빵류');
insert into spsub_cate(sp_subnum,sp_subname) values ('s2_02','잼·버터·스프레드');
insert into spsub_cate(sp_subnum,sp_subname) values ('s2_03','케이크·파이·디저트');
insert into spsub_cate(sp_subnum,sp_subname) values ('s3_01','주방가전');
insert into spsub_cate(sp_subnum,sp_subname) values ('s3_02','디지털·PC');
insert into spsub_cate(sp_subnum,sp_subname) values ('s3_03','대형·설치가전');

-- 확인
select * from spsub_cate;

/////////////////////////////////////////////////////////////////////////////////////

-- 3) sangpum : 상품
--테이블생성
create table sangpum(
     sp_code          varchar2(20)    PRIMARY KEY
    ,sp_main          varchar2(30)    NOT NULL
    ,constraint sangpum_sp_main_fk foreign key(sp_main)
     references sp_cate(sp_num)
     on delete set null     
    ,sp_sub           varchar2(100)   NOT NULL
    ,constraint sangpum_sp_sub_fk foreign key(sp_sub)
     references spsub_cate(sp_subnum)
     on delete set null 
    ,sp_brand         varchar2(100)   NOT NULL
    ,sp_pname         varchar2(100)   UNIQUE
    ,sp_info          varchar2(100)   NOT NULL
    ,sp_price         number(10)      NOT NULL
    ,sp_img           varchar2(20)    UNIQUE
    ,sp_shipping      varchar2(100)   NOT NULL
    ,sp_packaging     varchar2(100)   NOT NULL
    ,sp_seller        varchar2(20)    NOT NULL
);


--행추가
insert into sangpum(sp_code,sp_Main,sp_sub,sp_brand,sp_pname,sp_info,sp_price,sp_img,sp_shipping,sp_packaging,sp_seller)
    values ('M5','s1','s1_01','외할머니댁','차돌 된장찌개','담백한 차동양지가 돋보이는 된장찌개',7500,'M5.png','s_deli','ndong','컬리');
insert into sangpum(sp_code,sp_Main,sp_sub,sp_brand,sp_pname,sp_info,sp_price,sp_img,sp_shipping,sp_packaging,sp_seller)
    values ('M6','s1','s1_01','피코크','쟌슨빌 부대찌개','도톰하게 썰어놓은 갈비살',5382,'M6.png','s_deli','ndong','컬리');
insert into sangpum(sp_code,sp_Main,sp_sub,sp_brand,sp_pname,sp_info,sp_price,sp_img,sp_shipping,sp_packaging,sp_seller)
    values ('M8','s1','s1_01','삼원가든','등심 불고기','쟌슨빌 소시지의 진한 풍미',19000,'M8.png','s_deli','ndong','컬리');
insert into sangpum(sp_code,sp_Main,sp_sub,sp_brand,sp_pname,sp_info,sp_price,sp_img,sp_shipping,sp_packaging,sp_seller)
    values ('B5','s2','s2_01','픽어베이글','베이글 7종','신상품 옵션 추가 ! 뉴욕에서 맛본 바로 그 맛',0,'B5.png','s_deli','sangon','컬리');
insert into sangpum(sp_code,sp_Main,sp_sub,sp_brand,sp_pname,sp_info,sp_price,sp_img,sp_shipping,sp_packaging,sp_seller)
    values ('M1','s1','s1_03','마마리','추석 상차림 골라담기','풍요로운 상차림을 간편하게',0,'M1.png','s_deli','ndong','컬리');


-- 확인
select * from sangpum;

/////////////////////////////////////////////////////////////////////////////////////

-- 4) spinfo_op 상품옵션 테이블 생성
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


-- 확인하기
select * from spinfo_op;


/////////////////////////////////////////////////////////////////////////////////////


-- 5) member
-- 테이블 만들기
create table member(
   mt_id       varchar2(300) constraint member_mt_id_pk primary key not null    --아이디
  ,mt_pw       varchar2(300)    not null    --비밀번호
  ,mt_name     varchar2(100) CONSTRAINT member_mt_name UNIQUE not null   --이름
  ,mt_mail     varchar2(300)    not null    --메일
  ,mt_num      number(30)       not null    --폰번호
  ,mt_addr     varchar2(400)    not null    --주소
  ,mt_se       varchar2(20)      not null    --성별   
  ,mt_bht      varchar2(30)                 --생년월일
  ,mt_op       varchar2(100)                 --추가입력(추천자 or 가입이벤트)
  ,mt_info     varchar2(100)                 --해택/정보수신
);


select *  from member;
drop table member;

-- 행 추가
insert into member(mt_id, mt_pw, mt_name, mt_mail, mt_num, mt_addr, mt_se, mt_bht, mt_op, mt_info)
values ('asd454545', '1234567892', '김아무개', 'asd454545@naver.com', '01011118888', '서울 동작구 강남초등길 3', '선택안함', '1988-02-16', 'C001.prety',' ');
insert into member(mt_id, mt_pw, mt_name, mt_mail, mt_num, mt_addr, mt_se, mt_bht, mt_op, mt_info)
values('ddddfsg','q1w2e3r4t5','박개똥','ddddfsg@gmail.com','01088887777', '강원 삼척시 가곡면 가곡천로 149-6', '남', '1963-05-17',  ' ', ' '   );
insert into member(mt_id, mt_pw, mt_name, mt_mail, mt_num, mt_addr, mt_se, mt_bht, mt_op, mt_info)
values('sdfsde3333', 'vfbgnhmj777', '김꽃분','sdfsde3333@naver.com', '01026261313','경기 수원시 권선구 경수대로 93', '여', '2000-03-22', '', 'SNS' );
insert into member(mt_id, mt_pw, mt_name, mt_mail, mt_num, mt_addr, mt_se, mt_bht, mt_op, mt_info)
values('hfberfber11','jhgfdsfhklfdddss','최진사','hfberfber11@daum.net', '01044441111', '서울 관악구 과천대로 915', '여', '1983-07-15', 'E001.추석', ' '   );
insert into member(mt_id, mt_pw, mt_name, mt_mail, mt_num, mt_addr, mt_se, mt_bht, mt_op, mt_info)
values('njggfhfgh4567','1597532584','강고집', 'njggfhfgh4567@gmail.com', '01020003222', '부산 동구 고관로 55', '남', '1972-06-08', ' ', 'MAIL' );
insert into member(mt_id, mt_pw, mt_name, mt_mail, mt_num, mt_addr, mt_se, mt_bht, mt_op, mt_info)
values('master123','a123456789','관리자', 'marketkully@gmail.com', '01012341234', '마켓컬리담당자', '선택안함', '2000-12-12', ' ', 'MAIL' );
insert into member(mt_id, mt_pw, mt_name, mt_mail, mt_num, mt_addr, mt_se, mt_bht, mt_op, mt_info)
values('master1234','a123456789','marketkurly', 'marketkurly@gmail.com', '01012341234', '게시판담당자', '선택안함', '2000-12-12', ' ', 'MAIL' );

-- 확인하기
select *  from member;

/////////////////////////////////////////////////////////////////////////////////////

-- 6) cart

-- 시퀀스 만들기
create sequence cart_seq;

-- 테이블 만들기
create table cart(
     ca_num     number(30) primary key   not null
    ,ca_code     varchar2(20)  
    ,constraint sangpum_sp_code_fk foreign key(ca_code)
     references sangpum(sp_code)
     on delete set null 
    ,ca_op      varchar2(30)
    ,constraint spinfo_op_code_fk foreign key(ca_op)
     references spinfo_op(si_opcode)
     on delete set null 
    ,ca_su      number(30)      not null
    ,ca_id      varchar2(100)
    ,constraint member_mt_id_fk foreign key(ca_id)
     references member(mt_id)
     on delete set null 
  );

-- 행추가
insert into cart(ca_num, ca_code, ca_op, ca_su, ca_id) 
    values (cart_seq.nextval, 'M5', null , 2, 'asd454545');
insert into cart(ca_num, ca_code, ca_op, ca_su, ca_id) 
    values (cart_seq.nextval, 'M6', null , 1, 'asd454545');    
insert into cart(ca_num, ca_code, ca_op, ca_su, ca_id) 
    values (cart_seq.nextval, 'M8', null , 1, 'asd454545');  
insert into cart(ca_num, ca_code, ca_op, ca_su, ca_id) 
    values (cart_seq.nextval, 'B5', 'B101' , 3, 'sdfsde3333');    
insert into cart(ca_num, ca_code, ca_op, ca_su, ca_id) 
    values (cart_seq.nextval, 'B5', 'B102' , 4, 'sdfsde3333');    
insert into cart(ca_num, ca_code, ca_op, ca_su, ca_id) 
    values (cart_seq.nextval, 'M1', 'M101' , 2, 'hfberfber11');    
insert into cart(ca_num, ca_code, ca_op, ca_su, ca_id) 
    values (cart_seq.nextval, 'M1', 'M102' , 2, 'hfberfber11');    
insert into cart(ca_num, ca_code, ca_op, ca_su, ca_id) 
    values (cart_seq.nextval, 'M1', 'M103' , 2, 'hfberfber11');

delete from cart;

-- 확인
select * from cart;


/////////////////////////////////////////////////////////////////////////////////////

-- 7) payment : 결제 테이블

-- 시퀀스 생성
create sequence payment_seq;
drop sequence payment_seq;

-- 테이블 생성
create table payment(
     pt_nb        int             PRIMARY KEY       -- 번호
    ,pt_id        varchar2(30)    not null          -- 아이디
    ,constraint payment_pt_id_fk foreign key(pt_id)
     references member(mt_id)
     on delete set null   
    ,pt_on        varchar2(40)    unique          -- 주문서번호
    ,pt_sm        number(30)      not null          -- 총결제금액
    ,pt_nm        varchar2(30)    not null          -- 받는사람
    ,pt_ad        varchar2(300)    not null          -- 받는주소
    ,pt_ms        varchar2(30)    not null          -- 배송메세지
    ,pt_st        char(1)     not null          -- 결과상태
);

 drop table payment;


--행추가
insert into payment( pt_nb, pt_id, pt_on,pt_sm ,pt_nm , pt_ad, pt_ms, pt_st) values (payment_seq.nextval, 'asd454545','202209011011-001',39382, '김아무개', '서울 동작구 강남초등길 3', '전화주세요', 'Y');
insert into payment( pt_nb, pt_id, pt_on,pt_sm ,pt_nm , pt_ad, pt_ms, pt_st) values (payment_seq.nextval, 'ddddfsg','202209011412-001',239000, '박개똥', '강원 삼척시 가곡면 가곡천로 149-6', '문앞에', 'C');
insert into payment( pt_nb, pt_id, pt_on,pt_sm ,pt_nm , pt_ad, pt_ms, pt_st) values (payment_seq.nextval, 'sdfsde3333','202209010900-001',19600, '김꽃분', '경기 수원시 권선구 경수대로 93', '조심히 오세요', 'C');


-- 확인하기
select * from payment;
commit;


/////////////////////////////////////////////////////////////////////////////////////

-- 8) d_payment : 상세 결제

-- 시퀀스 생성
create sequence d_payment_seq;
drop sequence d_payment_seq;

-- 테이블 생성
create table d_payment(
     dt_nb        int             PRIMARY KEY
    ,dt_on        varchar2(40)                    -- 주문서번호
    ,constraint d_payment_dt_on_fk foreign key(dt_on)
     references payment(pt_on)
     on delete set null   
    ,dt_sc        varchar2(20)                    -- 상품코드
    ,constraint d_payment_dt_sc_fk foreign key(dt_sc)
     references sangpum(sp_code)
     on delete set null        
    ,dt_pc        varchar2(30)                    -- 상품옵션코드
    ,constraint d_payment_dt_pc_fk foreign key(dt_pc)
     references spinfo_op(si_opcode)
     on delete set null   
    ,dt_am        number(10)      not null        -- 수량
    ,dt_mu        number(30)      not null        -- 금액
);

drop table d_payment;

--행추가
insert into d_payment(dt_nb,dt_on,dt_sc,dt_pc,dt_am ,dt_mu ) values (d_payment_seq.nextval, '202209011011-001','M6', null, 1, 15000);
insert into d_payment(dt_nb,dt_on,dt_sc,dt_pc,dt_am ,dt_mu ) values (d_payment_seq.nextval, '202209011011-001','M8', null, 1, 19000);
insert into d_payment(dt_nb,dt_on,dt_sc,dt_pc,dt_am ,dt_mu ) values (d_payment_seq.nextval, '202209010900-001','B5', 'B101', 3, 8400);
insert into d_payment(dt_nb,dt_on,dt_sc,dt_pc,dt_am ,dt_mu ) values (d_payment_seq.nextval, '202209010900-001','B5', 'B102', 4, 11200);


-- 확인하기
select * from d_payment;


/////////////////////////////////////////////////////////////////////////////////////

-- 9) review : 구매후기 테이블

-- 구매후기 테이블 생성

create table review(
     rno        number(5)       primary key         -- 일련번호
    ,r_num      varchar2(10)    check(r_num in ('N', 'C'))   -- 번호(N : 공지사항, C : 일반게시글)
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
);

drop table review;

-- 일련번호를 위한 시퀀스 생성
create sequence review_seq;
drop sequence review_seq;

-- 상품옵션 테이블 행추가
insert into review(rno, r_num, r_photo, r_name, r_title, r_mem, r_date, r_like, r_view)
            values(review_seq.nextval, 'N', null, null, '금주의 Best 후기 안내', '관리자', '2019-11-01', 1, 611701);
insert into review(rno, r_num, r_photo, r_name, r_title, r_mem, r_date, r_like, r_view)
            values(review_seq.nextval, 'C', 'M5.png', '차돌 된장찌개', '자취생들에게 강력 추천', '김아무개', '2022-08-28', 0, 0);
insert into review(rno, r_num, r_photo, r_name, r_title, r_mem, r_date, r_like, r_view)
            values(review_seq.nextval, 'C', 'M1.png', '추석 상차림 골라담기', '백슉이 읍자너', '강고집', '2022-08-28', 0, 0);


/////////////////////////////////////////////////////////////////////////////////////

-- 10) notice : 공지사항 테이블

-- 시퀀스 생성
create sequence notice_seq;
drop sequence notice_seq;

-- 테이블 생성
create table notice(
   nt_nb        int      PRIMARY KEY -- 번호
  ,nt_nt        varchar2(30)    not null    -- 공지
  ,nt_title     varchar2(60)    not null    -- 제목 
  ,nt_cont      varchar2(30)    not null    -- 내용
  ,nt_am        number(10)      not null    -- 조회
  ,nt_day       date            not null    -- 작성일
  ,nt_name      varchar2(100)               -- 작성자
  ,constraint notice_nt_name_fk foreign key(nt_name)
    references member(mt_name)
    on delete set null   
);

 drop table notice;
 

--행추가

insert into notice(nt_nb,nt_nt,nt_title,nt_cont ,nt_am,nt_day,nt_name ) values (notice_seq.nextval, 'M', '[마켓컬리]선물하기 서비스 재오픈 공지', 'txt,pdf', 135, sysdate, 'marketkurly');
insert into notice(nt_nb,nt_nt,nt_title,nt_cont ,nt_am,nt_day,nt_name) values (notice_seq.nextval, 'C', '[마켓컬리]컬리 소비자 분쟁해결 기준안내', 'txt,pdf', 112, '2022/07/24', 'marketkurly');
insert into notice(nt_nb,nt_nt,nt_title,nt_cont ,nt_am,nt_day,nt_name) values (notice_seq.nextval, 'C', '[가격인상공지][올가비오]사양벌꿀 1kg', 'txt,pdf', 162, '2022/06/24', 'marketkurly');
insert into notice(nt_nb,nt_nt,nt_title,nt_cont ,nt_am,nt_day,nt_name) values (notice_seq.nextval, 'C', '[가격인상공지][면사랑]프리미엄 메밀국수', 'txt,pdf', 162, '2022/06/20', 'marketkurly');

-- 확인하기
select * from notice;




/////////////////////////////////////////////////////////////////////////////////////

-- 11) q_category : 문의카테고리 테이블
-- 테이블 생성
create table q_category (
     qc_no      number(1)      not null  primary key		--번호
    ,qc_ctid    varchar2(5)    unique				--카테고리id
    ,qc_type    varchar2(50)   not null				--유형
);

drop table q_category;

-- 행 추가
insert into q_category(qc_no, qc_ctid,qc_type ) values (1,'qc_1', '주문/결제/반품/교환문의');
insert into q_category(qc_no, qc_ctid,qc_type ) values (2,'qc_2', '이벤트/쿠폰/적립금문의');
insert into q_category(qc_no, qc_ctid,qc_type ) values (3,'qc_3', '상품문의');
insert into q_category(qc_no, qc_ctid,qc_type ) values (4,'qc_4', '배송문의');
insert into q_category(qc_no, qc_ctid,qc_type ) values (5,'qc_5', '상품 누락 문의');
insert into q_category(qc_no, qc_ctid,qc_type ) values (6,'qc_6', '기타 문의');

-- 확인하기
select * from q_category;



/////////////////////////////////////////////////////////////////////////////////////

-- 12) q_subct : 문의카테고리 하위 테이블
--일련번호를 위한 시퀀스 생성
create sequence q_subct_seq;

--시퀀스 삭제
drop sequence q_subct_seq;

-- 테이블 생성
create table q_subct (	
     qs_no      number(2)      primary key		        --번호
    ,qs_s       varchar2(50)   unique    				--상세유형
    ,qs_cont    varchar2(50)   not null 				--내용
);

drop table q_subct;

-- 행 삽입
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs1_1' ,'주문취소 해주세요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs1_2' ,'상품 반품을 원해요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs1_3' ,'상품 교환을 원해요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs1_4' ,'주문 / 결제는 어떻게 하나요?' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs1_5' ,'오류로 주문/결제가 안돼요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs1_6' ,'기타(직접 입력)' );

insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs2_1' ,'쿠폰 관련 문의드려요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs2_2' ,'적립금 관련 문의 드려요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs2_3' ,'이벤트 관련 문의 드려요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs2_4' ,'증정품 관련 문의 드려요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs2_5' ,'할인 관련 문의 드려요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs2_6' ,'기타(직접 입력)' );

insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs3_1' ,'불량상품 환불 해주세요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs3_2' ,'파손상품' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs3_3' ,'상품에 대해 알려주세요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs3_4' ,'기타(직접 입력)' );


insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs4_1' ,'상품이 다른곳으로 갔어요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs4_2' ,'배송 상품이 안 왔어요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs4_3' ,'배송정보 변경해주세요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs4_4' ,'포장 상태가 좋지 않아요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs4_5' ,'상품이 회수되지 않았어요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs4_6' ,'배송비에 대해 궁금합니다' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs4_6' ,'기타(직접 입력)');

insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs5_1' ,'누락된 상품 환불 해주세요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs5_2' ,'다른 상품 와서 환불 원해요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs5_3' ,'기타(직접 입력)' );

insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs6_1' ,'로그인/회원 문의하고싶어요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs6_2' ,'이용 중 오류가 발생했어요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs6_3' ,'컬러패스에 대해 알고싶어요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs6_4' ,'퍼플박스에 대해 알고 싶어요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs6_5' ,'컬러에게 제안하고 싶어요' );
insert into q_subct(qs_no, qs_s, qs_cont) values (q_subct_seq.nextval,'qcs6_6' ,'기타(직접 입력)' );

-- 확인하기
select * from q_subct;

/////////////////////////////////////////////////////////////////////////////////////

-- 13) ques : 문의 테이블
-- 테이블 생성
create table ques(
     q_num      number(5)       primary key             -- 접수번호
    ,q_id       varchar2(20)    not null                -- 아이디
    ,constraint ques_id_fk foreign key(q_id)
     references member(mt_id)
     on delete cascade                                  -- 아이디 FK 코드
    ,q_type     varchar2(5)     not null                -- 유형
    ,constraint ques_type_fk foreign key(q_type)
     references q_category(qc_ctid)
     on delete cascade                                  -- 유형 FK 코드
    ,q_subc    varchar2(20)     not null                -- 상세 유형
    ,constraint ques_subcg_fk foreign key(q_subc)
     references q_subct(qs_s)
     on delete cascade                                  -- 상세 유형 FK 코드
    ,q_ordernum varchar2(20)    not null                -- 결제 번호
    ,constraint ques_ordernum_fk foreign key(q_ordernum)
     references payment(pt_on)
     on delete cascade                                  -- 결제 번호 FK 코드
    ,q_title    varchar2(255)   not null                -- 제목
    ,q_cont     varchar2(2000)  not null                -- 내용
    ,q_photo    varchar2(255)
    ,q_agree    char(1)         check(q_agree in (0, 1))  -- 0 : true / 1 : false
    ,q_answer   char(1)         check(q_answer in (0, 1))  -- 0 : true / 1 : false
);

drop table ques;


-- 일련번호를 위한 시퀀스 생성
create sequence ques_seq;
drop sequence ques_seq;


-- 상품옵션 테이블 행추가
insert into ques(q_num, q_id, q_type, q_subc, q_ordernum, q_title, q_cont, q_photo, q_agree, q_answer)
            values(ques_seq.nextval, 'asd454545', 'qc_1', 'qcs1_2', '202209011011-001', '반품하고싶어요', '물건이 맘에 안들어서 반품하고싶습니다', 'a.jpg', 0, 0);
insert into ques(q_num, q_id, q_type, q_subc, q_ordernum, q_title, q_cont, q_photo, q_agree, q_answer)
            values(ques_seq.nextval, 'ddddfsg', 'qc_3', 'qcs3_1', '202209010900-001', '상품이 상한 것 같아요', '음식이 상한 냄새가 납니다', 'b.jpg', 0, 0);


-- 확인하기
select * from ques;


-- 커밋
commit;