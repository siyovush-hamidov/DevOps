#!/bin/bash

sqlplus -s / as sysdba <<EOF
SET LINESIZE 230
select name, created, open_mode, DATABASE_ROLE from v\$database;
select VERSION_FULL, status, DATABASE_STATUS, INSTANCE_ROLE from v\$instance;
COLUMN username FORMAT A20
COLUMN account_status FORMAT A15
SELECT username, account_status, created, lock_date, expiry_date FROM dba_users WHERE account_status != 'OPEN' and username='SYSTEM';
column grantee format A20
column granted_role format A15
select * from DBA_ROLE_PRIVS where GRANTED_ROLE='DBA';
select * from DBA_ROLE_PRIVS where GRANTEE='FINAL_USER';
select * from DBA_SYS_PRIVS where GRANTEE='FINAL_USER';
desc FINAL_USER.FINAL_TABLE;
select * from FINAL_USER.FINAL_TABLE;
exit
EOF
exit