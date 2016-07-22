# Log root only
[ $UID -gt 0 ] && return

# Log bash only 
[ "${SHELL##*/}" != "ksh" ] && return

#patched
function dlog
{
        log_cmd=$(history -n -N 1 | tail -1 | sed 's/^\s*//')
        log_dir=$(pwd)
        log_tty=$(who -mu | awk '{print $2}')
        log_loginpid="$(who -mu | awk '{print $6}')"
        log_pid="$$"
        logger -p authpriv.info -- "[audit $SUDO_USER/$log_loginpid as $LOGNAME/$log_pid on $log_tty] $log_dir: $log_cmd"
}
trap dlog DEBUG
