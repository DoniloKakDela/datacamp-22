SELECT * FROM src_calendar;

DESCRIBE src_calendar;

DESCRIBE t_days;

DESCRIBE t_weeks;

DESCRIBE t_months;

DESCRIBE t_quorters;

DESCRIBE t_years;

/*ALTER TABLE src_calendar
ADD*/

CREATE TABLE t_days
(day_id INT PRIMARY KEY,
full_date DATE,
day_name VARCHAR2(36),
day_number_in_week VARCHAR2(1),
day_number_in_month VARCHAR2(2),
day_number_in_year VARCHAR2(3));

CREATE OR REPLACE TRIGGER t_days_trg
BEFORE INSERT ON t_days FOR EACH ROW
WHEN (NEW.day_id IS NULL)
BEGIN SELECT seq.NEXTVAL
INTO :NEW.day_id
FROM dual;
END;
/

INSERT INTO t_days (full_date, day_name, day_number_in_week, day_number_in_month, day_number_in_year)
SELECT time_id, day_name, day_number_in_week, day_number_in_month, day_number_in_year
FROM src_calendar;

SELECT * FROM t_days;

DROP TABLE t_months;

DROP SEQUENCE seq_months;

CREATE TABLE t_weeks
(week_id INT PRIMARY KEY,
week_ending_date DATE,
calendar_week_number VARCHAR2(2));

CREATE SEQUENCE seq_weeks
START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER t_weeks_trg
BEFORE INSERT ON t_weeks FOR EACH ROW
WHEN (NEW.week_id IS NULL)
BEGIN SELECT seq_weeks.NEXTVAL
INTO :NEW.week_id
FROM dual;
END;
/

INSERT INTO t_weeks (week_ending_date)
SELECT DISTINCT(week_ending_date) FROM src_calendar;

UPDATE t_weeks
SET calendar_week_number = calendar_week_number - 1
WHERE calendar_week_number <> 1;

SELECT * FROM t_weeks;

CREATE TABLE t_months
( month_id INT PRIMARY KEY
, CALENDAR_MONTH_NUMBER          VARCHAR2(2)  
, DAYS_IN_CAL_MONTH              VARCHAR2(2)  
, START_OF_CAL_MONTH             DATE         
, END_OF_CAL_MONTH               DATE         
, CALENDAR_MONTH_NAME            VARCHAR2(36));

CREATE SEQUENCE seq_months
START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER t_months_trg
BEFORE INSERT ON t_months FOR EACH ROW
WHEN (NEW.month_id IS NULL)
BEGIN SELECT seq_months.NEXTVAL
INTO :NEW.month_id
FROM dual;
END;
/

INSERT INTO t_months (CALENDAR_MONTH_NUMBER, DAYS_IN_CAL_MONTH, START_OF_CAL_MONTH, END_OF_CAL_MONTH, CALENDAR_MONTH_NAME)
SELECT DISTINCT(CALENDAR_MONTH_NUMBER), DAYS_IN_CAL_MONTH, START_OF_CAL_MONTH, END_OF_CAL_MONTH, CALENDAR_MONTH_NAME
FROM src_calendar;

SELECT * FROM t_months;

CREATE TABLE t_quorters
( quorter_id INT PRIMARY KEY
, DAYS_IN_CALENDAR_QUARTER       NUMBER       
, BEG_OF_CAL_QUARTER             DATE         
, END_OF_CAL_QUARTER             DATE         
, CALENDAR_QUARTER_NUMBER        VARCHAR2(1));

CREATE SEQUENCE seq_quorters
START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER t_quorters_trg
BEFORE INSERT ON t_quorters FOR EACH ROW
WHEN (NEW.quorter_id IS NULL)
BEGIN SELECT seq_quorters.NEXTVAL
INTO :NEW.quorter_id
FROM dual;
END;
/

INSERT INTO t_quorters (DAYS_IN_CALENDAR_QUARTER, BEG_OF_CAL_QUARTER, END_OF_CAL_QUARTER, CALENDAR_QUARTER_NUMBER)
SELECT DISTINCT(DAYS_IN_CALENDAR_QUARTER), BEG_OF_CAL_QUARTER, END_OF_CAL_QUARTER, CALENDAR_QUARTER_NUMBER
FROM src_calendar;

SELECT * FROM t_quorters;

CREATE TABLE t_years
( year_id INT PRIMARY KEY
, CALENDAR_YEAR                  VARCHAR2(4)  
, DAYS_IN_CAL_YEAR               NUMBER       
, BEG_OF_CAL_YEAR                DATE         
, END_OF_CAL_YEAR                DATE);

CREATE SEQUENCE seq_years
START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER t_years_trg
BEFORE INSERT ON t_years FOR EACH ROW
WHEN (NEW.year_id IS NULL)
BEGIN SELECT seq_years.NEXTVAL
INTO :NEW.year_id
FROM dual;
END;
/

INSERT INTO t_years (CALENDAR_YEAR, DAYS_IN_CAL_YEAR, BEG_OF_CAL_YEAR, END_OF_CAL_YEAR)
SELECT DISTINCT(CALENDAR_YEAR), DAYS_IN_CAL_YEAR, BEG_OF_CAL_YEAR, END_OF_CAL_YEAR
FROM src_calendar;

SELECT * FROM t_years;