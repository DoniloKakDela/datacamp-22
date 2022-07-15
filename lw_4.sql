CREATE TABLE emp
( empno NUMBER PRIMARY KEY,
ename VARCHAR2(10),
job VARCHAR2(9),
mgr NUMBER,
hiredate DATE,
sal NUMBER,
comm NUMBER,
deptno NUMBER(2) REFERENCES dept(deptno))
CLUSTER emp_dept_cluster (deptno);
