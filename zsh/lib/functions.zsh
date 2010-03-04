function lmv { 
  [ -e $1 -a -e $2 ] && mv $1 $2 && ln -s $2/$(basename $1) $(dirname $1);
}

function ips {
  ifconfig | grep "inet " | awk '{ print $2 }'
}
