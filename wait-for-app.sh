#!/bin/bash
# https://docs.docker.com/compose/startup-order/
# https://serverfault.com/questions/562524/bash-script-to-check-if-a-public-https-site-is-up
# when not running 'https://alpha-sso.dina-web.net/auth/realms/' gives the response 502
TIMEOUT=300
cmd="$@"


echo "start"
XSTATUS=502
while [ $XSTATUS -eq 502 ] || [ $XSTATUS -eq 404 ] ; do
    sleep 1
    XSTATUS=`curl -s   --connect-timeout $TIMEOUT -o /dev/null -w "%{http_code}" https://alpha-sso.dina-web.net/auth/realms/master/`
    echo "current HTTP STATUS is $XSTATUS"
done

echo "service is up and running "
echo "now executing $cmd "

#exec  $cmd
