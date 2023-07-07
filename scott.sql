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