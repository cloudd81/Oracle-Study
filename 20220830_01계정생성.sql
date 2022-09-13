
파일 > 새로 만들기 > 데이터베이스계층 > 데이터베이스 파일
C:\java202207\database\20220830_01계정생성.sql
/////////////////////////////////////////////////////////////////////////////


● [최고관리자 계정]
  - Oracle   : system 또는 sys
  - Maria DB : root
  - MS-SQL   : sa
  
  
● [DCL명령어] Data Control Language 제어어
  - 사용자가 별로 쓸일 없음. 호스팅 업체가 주로 사용
  - grant    사용자 접근 권한 부여
  - revoke   사용자 접근 권한 취소
  - deny     특정 사용자만 접근 차단
  

-- 계정 생성시 세션 변경해야 함
alter session set "_ORACLE_SCRIPT"=true;

-- 사용자 계정 목록
select username from all_users;

-- 테이블 스페이스(테이블의 저장 공간) 생성
형식) create tablespace 테이블스페이스이름
      datafile '데이터파일경로' size 초기사이즈
      autoextend on
      next 자동증가사이즈
      maxsize 최대사이즈;

      create tablespace java202207
      datafile 'c:\java202207\database\java202207.dbf' size 50m
      autoextend on
      next 10m
      maxsize unlimited;


-- 사용자 계정 생성
형식) create user 아이디 identified by 비번
      default tablespace 테이블스페이스이름;

예) create user java202207 identified by 1234
    default tablespace java202207;


-- 모든 권한 부여
grant connect, resource, dba to java202207;
commit;

-- 명령프롬프트에서 권한 부여된 java202207 로그인하기
>sqlplus java202207/1234


-- 사용자 계정 삭제
drop user java202207 cascade;
commit;

-- 테이블 스페이스 종류 확인
형식) select tablespace_name, contents  from dba_tablespaces;

-- 테이블 스페이스 삭제
형식) drop tablespace 테이블스페이스명
      including contents and datafiles
      cascade constraints;


drop tablespace java202207
including contents and datafiles
cascade constraints;


commit;