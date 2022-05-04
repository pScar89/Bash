#!/bin/bash

#This is a script which will take input from the user and sanitize it
#It will then output the difference between them

get_first_number() {

	echo "Please enter a number: "

	read NUMBER

	FIRSTNUM=$(echo "$NUMBER" | sed "s/[^0-9]//g")

	if [ -n "$FIRSTNUM" ]
	then

		echo "The number you entered is $FIRSTNUM"

	else

		echo "Your entry is invalid."
		get_first_number

	fi

}

get_second_number() {

	echo "Please enter a number: "

	read NUMBER

	SECONDNUM=$(echo "$NUMBER" | sed "s/[^0-9]//g")

	if [ -n "$SECONDNUM" ]
	then

		echo "The number you entered is $SECONDNUM"

	else

		echo "Your entry is invalid."
		get_second_number
		
	fi
}

subtract_numbers() {

	if [ $FIRSTNUM -gt $SECONDNUM ]
	then

		DIFF=$(($FIRSTNUM - $SECONDNUM))
		echo "The difference is: $DIFF"

	fi

	if [ $SECONDNUM -gt $FIRSTNUM ]
	then

		DIFF=$(($SECONDNUM - $FIRSTNUM))
		echo "The difference is: $DIFF"

	fi

	if [ $FIRSTNUM -eq $SECONDNUM ]
	then

		echo "The difference is: 0"

	fi
}

run() {

	get_first_number

	get_second_number

	subtract_numbers

}

CONTINUE="y"

while [ $CONTINUE = y ]
do
	run

	echo "Go again? (y/n)"
	read CONTINUE

	echo "testing y"

	if [ CONTINUE = y ]
	then

		run

	else

		echo "Have a nice day!"

	fi

done
exit 0