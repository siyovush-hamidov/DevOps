#!/bin/bash

# Получаем состояние базы данных Oracle и сохраняем его в переменной databaseState
databaseState=$(echo "select instance_name, status, database_status from v\$instance;" | sqlplus -s / as sysdba)

# Получаем состояние слушателя Oracle и сохраняем его в переменной listenerState
listenerState=$(lsnrctl status)

# Получаем информацию о базе данных, такую как имя, уникальное имя и путь к файлу паролей
# и сохраняем результат в переменной databaseInfo
databaseInfo=$(echo "select name, db_unique_name, (select file_name from v\$passwordfile_info) as way from v\$database;" | sqlplus -s / as sysdba)

# Выводим разделители и информацию о состоянии базы данных, состоянии слушателя и информацию о базе данных
echo "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
echo "Database state:"
echo "$databaseState"
echo "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
echo "Listener state:"
echo "$listenerState"
echo "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
echo "Database info:"
echo "$databaseInfo"
