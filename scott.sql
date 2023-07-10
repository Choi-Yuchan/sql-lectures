select * from emp where sal = 5000;
select * from emp where deptno = 20;
select * from emp where sal <= 3000;
select * from emp where sal ^= 3000;
select * from emp where sal != 3000;
select * from emp where sal <> 3000;

select empno,ename,sal from emp where ename = 'SMITH';
select * from emp where job = 'PRESIDENT';

select * from emp where hiredate >= '1982/01/01';

select * from emp where deptno = 10 and job = 'MANAGER';
select * from emp where deptno = 10 or job = 'MANAGER';
select * from emp where not deptno = 10;
select * from emp where sal >=2000 and sal <=3000;
select * from emp where sal between 2000 and 3000;

select * from emp where sal < 2000 or sal > 3000;
select * from emp where sal not between 2000 and 3000;
select * from emp where hiredate between '1982/01/01' and '1982/12/31';
select * from emp where comm in (300,500,1400);
select * from emp where comm not in (300,500,1400);


///// wild card '%' , like 연산자 

select * from emp where ename like 'F%'; 
select * from emp where ename like '%A%'; 
select * from emp where ename like '%N';

//_는 단 한문자에 대해서만 와일드 카드 역할을 한다.
select * from emp where ename like '_A%';
select * from emp where ename like '__A%';
select * from emp where ename not like '%A%';



///// Null을 위한 연산자 
// 연산, 할당, 비교가 불가능하다.

select * from emp where comm is null;
select * from emp where comm is not null;

///// order by
select * from emp order by sal asc;
select * from emp order by sal desc;

select * from emp order by hiredate desc;
select * from emp order by ename asc;
select * from emp where sal >= 3000 order by ename asc;

///// Distinct
select distinct deptno from emp;

///// as, ||
// column에 연산 하게 되면 해당 column에 대항되는 데이터를 같이 연산한다.
// as 생략 가능 
select ename, sal*12 as salary from emp;

select ename || ' is a ' || job as "연결정의 예" from emp;

///// table data type 확인
desc dept;

///// dual - 산술 연산의 결과를 한줄로 얻기 위해서 오라클에서 제공하는 테이블;
select 24*26 from dual;
select sysdate from dual;


///// oracle에서 제공하는 내장 함수들(숫자형, 문자형, 날짜형)
-- -10에 대한 절대값을 구하는 쿼리문
select abs (-10) from dual;
-- 소수점 아래를 버리는 함수 
select 34.5632, floor(34.5632) from dual;
-- 반올림 함수 
select 34.5678, round(34.5678,1) from dual;
-- 나누기 연산을 한 후 나머지를 결과 = java 연산자 %와 같음.
select mod(27,2), mod(27,5), mod(27,7) from dual;

// 문자형 처리
select 'oracle', upper('oracle') from dual;
select lower('ORACLE') from dual;
select lower(ename) from emp;
select initcap('oracle') from dual;
select initcap(ename) from emp;
select ename, length(ename) from emp;
-- substr() 시작 위치부터 선택 개수만큼의 문자를 추출한다.
select substr('oracle', 0,1) from dual;
select substr(ename, 0,1) from emp;
-- oracle에서 index는 1부터 시작한다.(0도 가능)
select substr('smith', 1,2) from dual;
select ename, 19||substr(hiredate, 1,2) as year, substr(hiredate, 4,2)as month from emp;
select ename, 19||substr(hiredate, 1,2) as year, substr(hiredate, 4,2)as month 
from emp 
where substr(hiredate,4,2) = '09';
-- trim()
select ltrim('        oracle') from emp;
select rtrim('        oracle       ') from emp;
select trim('        oracle       ') from emp;

// 날짜형 함수 
select sysdate -1 as yesterday, sysdate today, sysdate +1 as tomorrow from dual;
-- 두 날짜 사이의 개월 수
select ename, sysdate, hiredate, floor(months_between(sysdate,hiredate)) "근무 개월 수" from emp;
select ename, sysdate, hiredate, add_months(hiredate,4) from emp;
-- 오늘을 기준으로 가장 가까운 다음 금요일은 언제인지 구하는 쿼리문
select sysdate, next_day(sysdate, '금요일') from dual;
-- 입사한 달의 마지막 날을 구하는 쿼리문
select ename, sysdate, hiredate, last_day(hiredate) from emp;

//형 변환 함수
--to_char()
select sysdate, to_char(sysdate, 'YYYY-MM-DD') from dual;
select ename, to_char(hiredate,'YYYY/MM/DD day') as hiredate from emp;
select sysdate, to_char(sysdate, 'YY/MM/DD, HH:MI:SS') from dual;

--통화 기호를 앞에 붙이고 천 단위마다 콤마를 붙여서 출력하는 쿼리문
desc emp;
select ename, sal, to_char(sal, 'L999,999') as salary from emp;

--to_date()
select ename, hiredate from emp where hiredate = to_char('1981/02/20');
select ename, hiredate from emp where hiredate = to_date(19810220, 'YYYYMMDD');

select sysdate - to_date('2016/01/01','YYYY/MM/DD') from dual;

--to_number()
select to_number('20,000','99,999')-to_number('10,000','99,999') from dual; 

-- null을 다른 값으로 변환하는 NVL함수
select ename, sal*12+nvl(comm,0) as yearSalary, nvl(comm,0) as comm from emp;

// 선택을 위한 decode 함수
-- 여러가지 경우에 대해서 선택할 수 있도록 하는 기능을 제공한다.(switch case문과 같은 기능이다.)
select deptno from emp order by deptno;

select ename,deptno, decode(deptno,10,'accounting',20,'research',30,'sales') as dname
from emp 
order by deptno;

// case 함수
select ename,deptno, 
    case when deptno = 10 then upper('accounting')
         when deptno = 20 then upper('research')
         when deptno = 30 then upper('sales')
         when deptno = 40 then upper('operations')
    end as dname
from emp 
order by deptno;

select ename,sal, 
    case when sal >= 2500 then upper('a')
         when sal < 2500 then upper('f')
    end as grade
from emp 
order by sal;


/////group 함수
-- 함수 = 단일행 함수와 그룹함수
-- 단일행 함수는 각 행에 대해서 함수 적용
-- 그룹 함수는 복수의 행에 대해서 1개의 행으로 출력되는 것 
select deptno, sal, round(sal, -3) from emp;
-- sum()
select sum(sal) from emp;
-- avg()
select avg(sal) from emp;
-- max(), min()
select max(sal), min(sal) from emp;
-- count()
select count(*) from emp;
select count(distinct job) as jobcount from emp;

-- groub by
-- 특정 컬럼을 기준으로 그룹화 
-- 1. column은 group by한 column 명이 올 수 있다.
-- 2. 그룹 합수가 올 수 있다. 단일 함수는 올 수가 없다.
select deptno from emp group by deptno;
select deptno, sum(sal) from emp group by deptno;
select deptno, max(sal), min(sal) from emp group by deptno;
select deptno, count(deptno) from emp group by deptno;
select deptno, avg(sal) 
from emp 
group by deptno
having avg(sal) >= 2000;















