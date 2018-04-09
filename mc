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

#Check If minecraft server file exist
var=$(find . ! -name "." -type d -prune -o -type f -iname "*.jar" -print)
if [[ ! $var="" ]]; then
        echo "你连服务端都没下就来用脚本了??"
        exit 1;
else
echo "Your MineCraft Server File is" $var
        echo 'Minecraft ServerManager Author:Reimu'
echo '请选择你需要执行的步骤'
echo ''
echo "1.启动服务器"
echo "2.配置文件修改"
echo "3.全局内存检查"
echo "4.生成启动脚本"
echo "5.退出(Ctrl+c)"
fi
while :; do echo
	read -p "请选择： " choice
	if [[ ! $choice =~ ^[1-5]$ ]]; then
		echo "输入错误! 请输入正确的数字!"
	else
		break	
	fi
done

if [[ $choice == 1 ]];then
	bash ./run.sh
fi

if [[ $choice == 2 ]];then
	vi ./server.properties
fi

if [[ $choice == 3 ]];then
	htop
fi

if [[ $choice == 4 ]];then
	bash scriptgen.sh
fi

if [[ $choice == 5 ]];then
	exit
fi
        
