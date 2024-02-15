#!/bin/bash

# change the ORALCE_SID
sed -i 's/export ORACLE_SID=.*/export ORACLE_SID=test101/' ~/.bash_profile

#commit the changes
source ~/.bash_profile

#need to startup
sqlplus / as sysdba <<EOF
startup
exit
EOF

#need to init the time to avoid duplication errors
current_time=$(date '+%Y-%m-%d_%H-%M-%S')

#backup
expdp final1/final1@test101 schemas=final1 directory=data_pump_1 dumpfile=final_1_$current_time.dmp logfile=final_1_$current_time.log
