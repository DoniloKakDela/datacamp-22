/*Step 1 */
CREATE TABLE t ( a INT,
b VARCHAR2 (4000) DEFAULT RPAD('*',4000,'*'),
c VARCHAR2 (3000) DEFAULT RPAD('*',3000,'*'))
/

/*Step 2 */
INSERT INTO t (a) VALUES (1);
INSERT INTO t (a) VALUES (2);
INSERT INTO t (a) VALUES (3);
COMMIT;
DELETE FROM t
WHERE a = 2;
COMMIT;
INSERT INTO t (a) VALUES (4);
COMMIT;

/*Step 3 */

SELECT a
FROM t;

DROP TABLE t;

/*Task 2 Step 1 */

CREATE TABLE t (x INT PRIMARY KEY, e CLOB, z BLOB);

DROP TABLE t;
/*Step 2 */

SELECT segment_name, segment_type
FROM user_segments;

/*Step 3 */

CREATE TABLE t (x INT PRIMARY KEY,
y CLOB,
z BLOB)
SEGMENT CREATION IMMEDIATE
/

/*Step 4 */
SELECT segment_name, segment_type
FROM user_segments;

/*Step 5 */
SELECT DBMS_METADATA.GET_DDL('TABLE','T') FROM dual;

/*Task 3 Step 1 */

CREATE TABLE emp AS
SELECT object_id empno, object_name ename, created hiredate, owner job
FROM all_objects
/

ALTER TABLE emp
ADD CONSTRAINT emp_pk PRIMARY KEY(empno);

BEGIN
dbms_stats.gather_table_stats(user, 'EMP', CASCADE=>true);
END;

/*Step 2 */

CREATE TABLE heap_addresses
(
empno REFERENCES emp(empno) ON DELETE CASCADE,
addr_type VARCHAR2 (10),
street VARCHAR2 (20),
city VARCHAR2 (20),
state VARCHAR2 (2),
zip NUMBER,
PRIMARY KEY (empno,addr_type))
/

/*Step 3 */
