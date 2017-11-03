#!/bin/bash
# https://docs.docker.com/compose/startup-order/
# https://serverfault.com/questions/562524/bash-script-to-check-if-a-public-https-site-is-up
# when not running 'https://alpha-sso.dina-web.net/auth/realms/' gives the response 502
TIMEOUT=300
cmd="$@"

cmdname=$(basename $0)
echo $cmdname

echoerr() { if [[ $QUIET -ne 1 ]]; then echo "$@" 1>&2; fi }

usage()
{
    cat << USAGE >&2
Usage:
    $cmdname host:port [-s] [-t timeout] [-- command args]
    -h HOST | --host=HOST       Host or IP under test
    -p PORT | --port=PORT       TCP port under test
                                Alternatively, you specify the host and port as host:port
    -q | --quiet                Don't output any status messages
    -t TIMEOUT | --timeout=TIMEOUT
                                Timeout in seconds, zero for no timeout
    -- COMMAND ARGS             Execute command with args after the test finishes
USAGE
    exit 1
}

echo $2

# process arguments
while [[ $# -gt 0 ]]
do
    case "$1" in
        *:* )
        hostport=(${1//:/ })
        HOST=${hostport[0]}
        PORT=${hostport[1]}
        shift 1
        ;;
        --child)
        CHILD=1
        shift 1
        ;;
        -q | --quiet)
        QUIET=1
        shift 1
        ;;
        -h)
        HOST="$2"
        if [[ $HOST == "" ]]; then break; fi
        shift 2
        ;;
        --host=*)
        HOST="${1#*=}"
        shift 1
        ;;
        -p)
        PORT="$2"
        if [[ $PORT == "" ]]; then break; fi
        shift 2
        ;;
        --port=*)
        PORT="${1#*=}"
        shift 1
        ;;
        -t)
        TIMEOUT="$2"
        if [[ $TIMEOUT == "" ]]; then break; fi
        shift 2
        ;;
        --timeout=*)
        TIMEOUT="${1#*=}"
        shift 1
        ;;
        --)
        shift
        CLI=("$@")
        break
        ;;
        --help)
        usage
        ;;
        *)
        echoerr "Unknown argument: $1"
        usage
        ;;
    esac
done

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
