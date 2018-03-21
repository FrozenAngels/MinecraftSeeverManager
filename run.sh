clear
java -Xincgc -Xmx4096M -Dfml.ignorePatchDiscrepancies=true -XX:+AggressiveOpts -XX:+UseCompressedOops  -jar KCauldron-1.7.10-1517.168-server.jar  -nogui
while :; do echo
  read -p "Server closed.Restart? [y/n]: " Ifrestart
  if [[ ${Ifrestart} == 'y' ]]; then
java -Xincgc -Xmx4096M -Dfml.ignorePatchDiscrepancies=true -XX:+AggressiveOpts -XX:+UseCompressedOops  -jar KCauldron-1.7.10-1517.168-server.jar  -nogui
elif [[ ${Ifrestart} == 'n' ]]; then
break
 else
    echo "${CWARNING}Input error! Please only input y or n!${CEND}"
  fi
done
