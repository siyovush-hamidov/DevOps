# change the ORALCE_SID
sed -i 's/export ORACLE_SID=.*/export ORACLE_SID=test102/' ~/.bash_profile

#commit the changes
source ~/.bash_profile

#need to startup
sqlplus / as sysdba <<EOF
startup
exit
EOF

#need to init the time to avoid duplication errors
current_time=$(date '+%Y-%m-%d_%H-%M-%S')

expdp final2/final2@test102 schemas=final2 directory=data_pump_2 dumpfile=final2_$current_time.dmp logfile=final2_$current_time.log
