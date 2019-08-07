#!/bin/sh

. /lib/lsb/init-functions

MYADMIN="/usr/bin/mysqladmin --defaults-file=/etc/mysql/my.cnf"
MYSQLD_SAFE="/usr/bin/mysqld_safe --defaults-file=/etc/mysql/my.cnf"
PID_FILE="/var/run/mysqld/mysqld.pid"

start(){
    log_daemon_msg "Starting MariaDB service" "mysqld_safe"
    if [ -e ${PID_FILE} ]
    then
        log_end_msg 1
        log_action_msg "MariaDB need to close first! Usage: /etc/init.d/mysqld stop"
    else
        ${MYSQLD_SAFE} >/dev/null 2>&1 &
        log_end_msg 0
    fi
}

stop(){
    log_daemon_msg "Stoping MariaDB service" "mysqld_safe"
    if [ -e ${PID_FILE} ]
    then
        ${MYADMIN} shutdown >/dev/null 2>&1
        log_end_msg 0
    else
        log_end_msg 1
        log_action_msg "MariaDB need to running first! Usage: /etc/init.d/mysqld start"
    fi
}

reload(){
    log_daemon_msg "Reloading MariaDB service" "mysqld_safe"
    if [ -e ${PID_FILE} ]
    then
        ${MYADMIN} reload >/dev/null 2>&1
        log_end_msg 0
    else
        log_end_msg 1
        log_action_msg "MariaDB need to running first! Usage: /etc/init.d/mysqld start"
    fi
}

case $1 in 
    'start')
        start
        ;;
    'stop')
        stop
        ;;
    'reload')
        reload
        ;;
    *)
        log_action_msg "Usage: /etc/init.d/mysqld {start|stop|reload}"
        exit 1
esac