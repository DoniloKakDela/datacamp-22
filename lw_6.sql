--alter session set current_schema=u_dw_ext_references;

--ALTER USER u_dw_ext_references quota unlimited on TS_REFERENCES_EXT_DATA_01;

SELECT * FROM U_DW_REFERENCES.cu_languages;