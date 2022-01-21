#!/bin/bash

ping_loop() {

	for address in `seq 1 254` ; do
		ping -c 1 192.168.1."$counter" | awk '/64 bytes/ {print $4}' | tr -d ":" | tee -a "$HOME"/pingscan
		let "counter++"
	done
}

get_ports() {

	echo 'What range? (x-x)'

	read ports
	
}

scan_ports() {

	while read line
	do
		nc -zv "$line" "$ports" 2>&1 | awk '/succeeded!/ {print $3" "$4" "$6}'

	done < "$file"
}

main() {

	touch "$HOME"/pingscan

	counter=1
	file="$HOME/pingscan"

	echo 'Live addresses:'

	ping_loop
	
	get_ports

	echo 'Open ports in specified range:'

	scan_ports

	rm "$HOME"/pingscan

}

main