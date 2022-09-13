파일 > 새로 만들기 > 데이터베이스계층 > 데이터베이스 파일
C:\java202207\database\20220819_03where조건절.sql
/////////////////////////////////////////////////////////////////////////////



● [where 조건절]
- sql문에서 가장 기초에 해당하는 문법이다.
- 조건을 만족하는 행들에 대해서 데이터값을 조작하고 싶을 때 사용하는 조건절이다.
- 조건에 만족하는 레코드만 대상으로 조회(select), 수정(update), 삭제(delete)를 할 수 있다.


select * from sungjuk;


--문1) 국어점수가 50점이상 행을 조회하시오
select uname, kor
from sungjuk
where kor>=50;


--문2) 영어 점수가 50점미만 행을 조회하시오
select uname, eng
from sungjuk
where eng<50;

--문3) 이름이 '대한민국' 행을 조회(출력)하시오
select uname
from sungjuk
where uname='대한민국';

--문4) 이름이 '대한민국' 아닌 행을 조회하시오
select uname
from sungjuk
where uname!='대한민국';

--문5) 국어, 영어, 수학 세과목의 점수가 모두 90이상 행을 조회하시오
select uname, kor, eng, mat
from sungjuk
where kor>=90 and eng>=90 and mat>=90;


--문6) 국어, 영어, 수학 중에서 한과목이라도 40미만 행을 조회하시오
select uname, kor, eng, mat
from sungjuk
where kor<40 or eng<40 or mat<40;


--문7) 국어점수가 80 ~ 89점 사이 행을 조회하시오
select uname, kor
from sungjuk
where kor>=80 and kor<=89;
--where kor between 80 and 89;

--문8) 이름이 '무궁화', '봉선화'를 조회하시오
select uname
from sungjuk
where uname='무궁화' or uname='봉선화';
--where uname in ('무궁화','봉선화');


/////////////////////////////////////////////////////////////////////////////


● [between A and B] 연산자 - A부터 B까지
select uname, kor
from sungjuk
where kor between 80 and 89;

● [in] 연산자 - 목록에서 찾기
select uname
from sungjuk
where uname in ('무궁화','봉선화');


-- 국어점수 10, 30, 50점을 조회하시오
select uname, kor
from sungjuk
where kor in (10, 30, 50);


//////////////////////////////////////////////////////////////////////////




-- 문9) 국, 영, 수 모두 100점이 아닌 행을 조회하시오
select uname, kor, eng, mat
from sungjuk
where not(kor=100 and eng=100 and mat=100);




/////////////////////////////////////////////////////////////////////////////


● [like 연산자]
- 연산자는 지금까지 특정한 값, 일치하는 값을 찾는 것에 집중했다면 like 연산자는 비슷한 유형을 찾아내는 연산자이다.
- % 와 _ 를 사용한다.
- % 는 글자 갯수와 상관이 없고, _는 글자갯수까지 일치해야한다.

select uname
from sungjuk
where uname='대한민국';




--문1) 이름에서 '홍'으로 시작하는 이름을 조회하시오
select uname
from sungjuk
where uname like '홍%';


--문2) 이름에서 '화'로 끝나는 이름을 조회하시오
select uname
from sungjuk
where uname like '%화';

--문3) 이름에 '나'글자 있는 이름을 조회하시오
select uname
from sungjuk
where uname like '%나%';

--문4) 두글자 이름에서 '화'로 끝나는 이름을 조회하시오
select uname
from sungjuk
where uname like '_화';

--문5) 이름 세글자 중에서 가운데 글자가 '나' 있는 행을 조회하시오
select uname
from sungjuk
where uname like '_나_';


--문6) 제목 + 내용을 선택하고 검색어가 '파스타' 일때
select title, tbody 
from searchN
where title like '%파스타%' or tbody like '%파스타%';


--문7) 국어 점수가 50점 이상인 행에 대해서 총점(tot)과 평균(aver)을 구하시오
select * from sungjuk where kor >= 50;

update sungjuk
set tot=kor+eng+mat, aver=(kor+eng+mat)/3
where kor>50;

select * from sungjuk;


////////////////////////////////////////////////////////////////////////////////


● [NULL] - 비어있는 값

-- 총점의 갯수를 구하시오
select count(tot)
from sungjuk; -- null 값은 카운트를 하지 않는다

-- 총점에 null이 있는 행의 갯수를 구하시오
select count(*) from sungjuk where tot=null; -- null값을 인식하지 못해서 0이 나옴

select count(*) from sungjuk where tot is null; -- null : 5

-- 평균에 비어있지 않는 행의 갯수를 구하시오(null이 아닌 값)
select count(*) from sungjuk where aver is not null;


--문8) 비어있는 총점과 평균을 모두 구하시오
update sungjuk
set tot=kor+eng+mat, aver=(kor+eng+mat)/3
where tot is null and aver is null;

select * from sungjuk;

commit;