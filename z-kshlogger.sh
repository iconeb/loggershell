# Log root only
[ $UID -gt 0 ] && return

# Log bash only 
[ "${SHELL##*/}" != "ksh" ] && return

#patched
function dlog
{
        cmd=$(history -n -N 1 | tail -1)
        p_dir=$(pwd)
        logger -p authpriv.info -- "[audit $SUDO_USER as $LOGNAME on ] $p_dir: $cmd"
}
trap dlog DEBUG
