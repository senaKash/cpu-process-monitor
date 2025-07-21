#!/bin/bash
while true
do
	clear
	echo -e "\033c"

	echo -e "\033[32m"
	figlet "cpu process monitor"
	echo -e "\033[97m"	

	sum=$(ps aux --sort=-%cpu | sed -n '2p')
	pid=$(echo "$sum" | awk '{print $2}')
	
	if [ -z "$pid" ];
	then
		echo -e "\n\n->PID not found, next attempt in 5 seconds"
		sleep 5
	else
		echo -e "\033[32m"
		echo " ->PID == $pid"
		echo -e "\033[97m"
		
		info=$(cat /proc/$pid/status)

		#alternative output
		#for param in $info;
		#do
		#	printf "%-30s" "$param"
		#	((c++))
		#	if ((c % 4 == 0)); 
		#	then
		#		echo
		#	fi
		#done
		
		echo -e "\033[32m"
		echo -e " ->STATUS"
		echo -e "\033[97m"
		

		echo "$info"

		echo -e "\033[32m"
		echo -e "\n\n ->CMD INFO"
		echo -e "\033[97m"

		cat /proc/$pid/cmdline


		echo -e "\033[32m"
		echo -e "\n\n ->STAT"
		echo -e "\033[97m"

		cat /proc/$pid/stat

		
		echo -e "\033[32m"
		echo -e "\n\n ->ENVIRON"
		echo -e "\033[97m"

		cat /proc/$pid/environ | tr '\0' '\n'

		
		echo -e "\033[32m"
		echo -e "\n\n ->FD"
		echo -e "\033[97m"
		
		ls -l /proc/$pid/fd
	

		echo -e "\033[32m"
		echo -e "\n\n ->LSOFT INFO"
		echo -e "\033[97m"
		
		lsof -p $pid

		echo -e "\033[32m"		
		echo -e "\n\n ->INFO FROM ANOTHER SOURSES<-"

		echo -e "\n\n ->CPU INFO"
		cat /proc/cpuinfo | head -n 5


		echo -e "\n\n ->MEM INFO"
		cat /proc/meminfo | head -n 5


		sleep 5
	fi
done
	
