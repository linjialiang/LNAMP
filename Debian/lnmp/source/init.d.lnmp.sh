#!/bin/sh

. /lib/lsb/init-functions

start(){
    service ssh start
    service nginx start
    service mysqld start
    service php-fpm start
    exit 0
}

stop(){
    service nginx stop
    service mysqld stop
    service php-fpm stop
    exit 0
}

case $1 in
    'start')
        start
        ;;
    'stop')
        stop
        ;;
    *)
        log_action_msg "Usage: /etc/init.d/lnmp {start|stop}"
        ;;
esac
