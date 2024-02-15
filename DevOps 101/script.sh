#!/bin/bash

# path to the alert log file
ALERT_LOG=$ORACLE_ALERT/alert_test101.log

# get the last -n lines of the alert log
echo "ALERT LOG:"
#awk -v d1="$(date --date='-1 month' +'%Y-%m-%dT%H:%M:%S')" -v d2="$(date +'%Y-%m-%dT%H:%M:%S')" 'BEGIN { gsub(/-/," ",d1); gsub(/:/," ",d1); gsub(/T/," ",d1); t1 = mktime(d1); gsub(/-/," ",d2); gsub(/:/," ",d2); gsub(/T/," ",d2); t2 = mktime(d2); } { gsub(/-/," ",$1); gsub(/:/," ",$2); gsub(/T/," ",$2); t = mktime($0); if (t>t1 && t<t2 && $0 ~ /ORA-/) print $0 }' $ALERT_LOG
grep 'ORA-' $ALERT_LOG | tail -n 15
# INFORMATION ON THE DATAFILES
echo "INFORMATION ON THE DATAFILES:"
sqlplus -S / as sysdba <<EOF
SET HEADING OFF
SET PAGESIZE 50000
COL name FORMAT A50
COL bytes FORMAT 999999999999999
SELECT name, bytes/1024/1024 AS MB FROM v\$datafile;
EXIT;
EOF

# INFORMATION ON ARCHIVE LOGS:
echo "INFORMATION ON ARCHIVE LOGS:"
sqlplus -S / as sysdba <<EOF
SET HEADING OFF
SET PAGESIZE 50000
COL name FORMAT A50
SELECT name, blocks*block_size/1024/1024 AS MB FROM v\$archived_log WHERE dest_id = 1;
EXIT;
EOF

# DB STATUS:
echo "DB STATUS:"
sqlplus -S / as sysdba <<EOF
SET HEADING OFF
SET PAGESIZE 50000
COL db_name FORMAT A20
COL status FORMAT A20
SELECT name AS db_name, open_mode FROM v\$database;
EXIT;
EOF

