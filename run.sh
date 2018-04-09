clear
seconds_left=10  
    echo "服务器将于${seconds_left}秒后启动，按ctrl+c可以退出……"  
    while [ $seconds_left -gt 0 ];do  
      echo -n $seconds_left  
      sleep 1  
      seconds_left=$(($seconds_left - 1))  
      echo -ne "\r     \r" #清除本行文字  
    done  
java -Xincgc -Xmx4096M -Dfml.ignorePatchDiscrepancies=true -XX:+AggressiveOpts -XX:+UseCompressedOops  -jar $var  -nogui
while :; do echo
  read -p "Server closed.Restart? [y/n]: " Ifrestart
  if [[ ${Ifrestart} == 'y' ]]; then
  seconds_left=10  
    echo "服务器将于${seconds_left}秒后启动，按ctrl+c可以退出……"  
    while [ $seconds_left -gt 0 ];do  
      echo -n $seconds_left  
      sleep 1  
      seconds_left=$(($seconds_left - 1))  
      echo -ne "\r     \r" #清除本行文字  
    done  
java -Xincgc -Xmx4096M -Dfml.ignorePatchDiscrepancies=true -XX:+AggressiveOpts -XX:+UseCompressedOops  -jar KCauldron-1.7.10-1517.168-server.jar  -nogui
elif [[ ${Ifrestart} == 'n' ]]; then
break
 else
    echo "${CWARNING}Input error! Please only input y or n!${CEND}"
  fi
done
