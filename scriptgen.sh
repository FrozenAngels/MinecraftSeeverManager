#!/bin/bash

#Check OS
if [ -n "$(grep 'Aliyun Linux release' /etc/issue)" -o -e /etc/redhat-release ];then
OS=CentOS
[ -n "$(grep ' 7\.' /etc/redhat-release)" ] && CentOS_RHEL_version=7
[ -n "$(grep ' 6\.' /etc/redhat-release)" -o -n "$(grep 'Aliyun Linux release6 15' /etc/issue)" ] && CentOS_RHEL_version=6
[ -n "$(grep ' 5\.' /etc/redhat-release)" -o -n "$(grep 'Aliyun Linux release5' /etc/issue)" ] && CentOS_RHEL_version=5
elif [ -n "$(grep 'Amazon Linux AMI release' /etc/issue)" -o -e /etc/system-release ];then
OS=CentOS
CentOS_RHEL_version=6
elif [ -n "$(grep bian /etc/issue)" -o "$(lsb_release -is 2>/dev/null)" == 'Debian' ];then
OS=Debian
[ ! -e "$(which lsb_release)" ] && { apt-get -y update; apt-get -y install lsb-release; clear; }
Debian_version=$(lsb_release -sr | awk -F. '{print $1}')
elif [ -n "$(grep Deepin /etc/issue)" -o "$(lsb_release -is 2>/dev/null)" == 'Deepin' ];then
OS=Debian
[ ! -e "$(which lsb_release)" ] && { apt-get -y update; apt-get -y install lsb-release; clear; }
Debian_version=$(lsb_release -sr | awk -F. '{print $1}')
elif [ -n "$(grep Ubuntu /etc/issue)" -o "$(lsb_release -is 2>/dev/null)" == 'Ubuntu' -o -n "$(grep 'Linux Mint' /etc/issue)" ];then
OS=Ubuntu
[ ! -e "$(which lsb_release)" ] && { apt-get -y update; apt-get -y install lsb-release; clear; }
Ubuntu_version=$(lsb_release -sr | awk -F. '{print $1}')
[ -n "$(grep 'Linux Mint 18' /etc/issue)" ] && Ubuntu_version=16
else
echo "Does not support this OS, Please contact the author! "
kill -9 $$
fi


#Check Root
[ $(id -u) != "0" ] && { echo "Error: You must be root to run this script"; exit 1; }
echo "######################启动脚本生成程序########################"
echo ''
echo ''
echo ''
TotalMem=$(cat /proc/meminfo |grep 'MemTotal' |awk -F : '{print $2}' |sed 's/^[ \t]*//g')

while :; do echo
	read -p "是否启用增量垃圾回收参数(-xincgc)[y/n]： " ifXincgc
	if [[ ! $ifXincgc =~ ^[y,n]$ ]]; then
		echo "输入错误! 请输入y或者n!"
	elif [[ $ifXincgc == y ]]; then
Xincgc=-xincgc
		break
	elif [[ $ifXincgc == n ]]; then
			Xincgc=
	fi
done

while :; do echo
echo "当前服务器总内存为" $TotalMem
	read -p "请输入你的服务端允许占用的最大内存（单位：M)" MaxPermSize
	if [[ ! $MaxPermSize =~ ^[0-9]$ ]]; then
		echo "输入错误! 请输入正确的数字!"
	else
			break
	fi
done 

while :; do echo
	read -p "是否启用激进的优化参数[y/n]： " ifAggressiveOpts
	if [[ ! $ifAggressiveOpts =~ ^[y,n]$ ]]; then
		echo "输入错误! 请输入y或者n!"
	elif [[ $ifAggressiveOpts == y ]]; then
AggressiveOpts=-XX:+AggressiveOpts
		break
	elif [[ $ifAgressiveOpts == n ]]; then
			AggressiveOpts=
	fi
done

while :; do echo
	read -p "是否启用激进的优化参数[y/n]： " ifUseCompressedOops
	if [[ ! $ifUseCompressedOops =~ ^[y,n]$ ]]; then
		echo "输入错误! 请输入y或者n!"
	elif [[ $ifUseCompressedOops == y ]]; then
UseCompressedOops=-XX:+UseCompressedOops
		break
	elif [[ $ifUseCompressedOops == n ]]; then
			UseCompressedOops=
	fi
done

echo "所有需要的启动参数收集完成，开始生成脚本"
echo "java $Xincgc -Xmx$MaxPermSize"M" $AggressiveOpts $UseCompressedOops -jar &jarfile -nogui" >> start.sh
echo "启动脚本生成完成！现在你可以bash start.sh启动你的服务器了！"
