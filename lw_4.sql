/* Task 1 Step 1 */

CREATE TABLE t2 AS
SELECT TRUNC(rownum / 100) id, RPAD( rownum,100) t_pad
FROM dual
CONNECT BY rownum < 100000;

/* Step 2 */

CREATE INDEX t2_idx1 ON t2 (id);

/* Step 3 */

