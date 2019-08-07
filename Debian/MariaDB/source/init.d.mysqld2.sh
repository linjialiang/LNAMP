#!/bin/sh

. /lib/lsb/init-functions

MYADMIN="/usr/bin/mysqladmin --defaults-file=/etc/mysql/my.cnf"
MYSQLD_SAFE="/usr/bin/mysqld_safe --defaults-file=/etc/mysql/my.cnf"
PID_FILE="/var/run/mysqld/mysqld.pid"

start(){
    log_daemon_msg "Starting MariaDB service" "mysqld"
    ${MYSQLD_SAFE} >/dev/null 2>&1 &
    log_end_msg 0
}

stop(){
    log_daemon_msg "Stoping MariaDB service" "mysqld"
    ${MYADMIN} shutdown >/dev/null 2>&1
    log_end_msg 0
}

reload(){
    log_daemon_msg "Reloading MariaDB service" "mysqld"
    ${MYADMIN} reload >/dev/null 2>&1
    log_end_msg 0
}

case $1 in
    'start')
        if [ -e ${PID_FILE} ]
        then
            log_action_msg "MariaDB is running"
            exit 1
        else
            start
        fi
        ;;
    'stop')
        if [ -e ${PID_FILE} ]
        then
            stop
        else
            log_warning_msg "MariaDB must be started first!"
            log_action_msg "Usage: /etc/init.d/mysqld start"
            exit 1
        fi
        ;;
    'reload')
        if [ -e ${PID_FILE} ]
        then
            reload
        else
            log_warning_msg "MariaDB must be started first!"
            log_action_msg "Usage: /etc/init.d/mysqld start"
            exit 1
        fi
        ;;
    'restart')
        if [ -e ${PID_FILE} ]
        then
            stop
            start
        else
            log_warning_msg "MariaDB is not running. We run it immediately"
            start
        fi
        ;;
    *)
        log_action_msg "Usage: /etc/init.d/mysqld {start|stop|reload|restart}"
        exit 1
esac
