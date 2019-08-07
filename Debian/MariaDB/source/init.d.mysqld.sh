#!/bin/sh

. /lib/lsb/init-functions

MYADMIN="/usr/bin/mysqladmin --defaults-file=/etc/mysql/my.cnf"
MYSQLD_SAFE="/usr/bin/mysqld_safe --defaults-file=/etc/mysql/my.cnf"
PID_FILE="/var/run/mysqld/mysqld.pid"

start(){
    if [ -e ${PID_FILE} ]
    then
        log_action_msg "MariaDB is running"
        exit 1
    else
        log_daemon_msg "Starting MariaDB service" "mysqld"
        ${MYSQLD_SAFE} >/dev/null 2>&1 &
        log_end_msg 0
    fi
}

stop(){
    if [ -e ${PID_FILE} ]
    then
        log_daemon_msg "Stoping MariaDB service" "mysqld"
        ${MYADMIN} shutdown >/dev/null 2>&1
        log_end_msg 0
    else
        log_warning_msg "MariaDB must be started first!"
        log_action_msg "Usage: /etc/init.d/mysqld start"
        exit 1
    fi
}

reload(){
    if [ -e ${PID_FILE} ]
    then
        log_daemon_msg "Reloading MariaDB service" "mysqld"
        ${MYADMIN} reload >/dev/null 2>&1
        log_end_msg 0
    else
        log_warning_msg "MariaDB must be started first!"
        log_action_msg "Usage: /etc/init.d/mysqld start"
        exit 1
    fi
}

restart(){
    if [ -e ${PID_FILE} ]
    then
        ${MYADMIN} shutdown >/dev/null 2>&1
        log_action_msg "Stoping MariaDB service: mysqld"
        ${MYSQLD_SAFE} >/dev/null 2>&1 &
        log_action_msg "Starting MariaDB service: mysqld"
        log_success_msg "Restarting MariaDB successfully!"
    else
        log_warning_msg "MariaDB is not running. We run it immediately"
        log_daemon_msg "Starting MariaDB service" "mysqld"
        ${MYSQLD_SAFE} >/dev/null 2>&1 &
        log_end_msg 0
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
    'restart')
        restart
        ;;
    *)
        log_action_msg "Usage: /etc/init.d/mysqld {start|stop|reload|restart}"
        exit 1
esac
