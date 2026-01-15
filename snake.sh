#!/bin/bash

resolution=15
alive=true
pixels=(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
snake=(4 3 2 1)
direction="right"
x=4
y=0

printrow(){
	result="\033[37;47m▄\033[0m"
	start=$(( $1 * $resolution ))
	end=$(( ($1 + 1) * $resolution ))
	for (( k=start; k<end; k++ )); do
		result+="\033[3${pixels[k+$resolution]};4${pixels[$k]}m▄\033[0m"
	done
	result+="\033[37;47m▄\033[0m"
	echo -e "$result"
}

printScreen(){
	printf "\033[H\033[J"
	
	for (( j=0; j<$resolution; j+=2 )); do
		printrow $j #rownum
	done
}

drawsnake(){
	pixels[${snake[-1]}]=0 #blacks over place where tail was 
	
    if [ "$direction" = "right" ]; then	#reassigns head
        head=$(( ${snake[0]} + 1 ))
		((x++))
		if (( x > 14 )); then
			alive=false
		fi
    elif [ "$direction" = "left" ]; then
		head=$(( ${snake[0]} - 1 ))
		((x--))
		if (( x < 0 )); then
			alive=false
		fi
	elif [ "$direction" = "down" ]; then
		head=$(( ${snake[0]} + $resolution ))
		((y++))
		if (( y > 15 )); then
			alive=false
			echo $y
		fi
	elif [ "$direction" = "up" ]; then
		head=$(( ${snake[0]} - $resolution ))
		((y--))
		if (( y < 0 )); then
			alive=false
		fi
	fi
	
	#list[$var]=2

	snake=("$head" "${snake[@]:0:${#snake[@]}-1}") #init snake
	for n in "${snake[@]}"; do
    	pixels[n]=2 # green for snake color
	done
}




while $alive; do
	printScreen
	sleep 0.2

	if read -t 0.2 -n 1 key; then
		if [[ "$key" == "w" ]]; then
			if [ "$direction" = "down" ]; then	#reassigns head
				alive=false
			else
				direction=up
			fi
			
		elif [[ "$key" == "s" ]]; then
			if [ "$direction" = "up" ]; then	#reassigns head
				alive=false
			else
				direction=down
			fi
		
		elif [[ "$key" == "a" ]]; then
			if [ "$direction" = "right" ]; then	#reassigns head
				alive=false
			else
				direction=left
			fi

		elif [[ "$key" == "d" ]]; then
			if [ "$direction" = "left" ]; then	#reassigns head
				alive=false
			else
				direction=right
			fi	
			
		#else #other key
			
		fi
	#else #no key
	fi
	
	drawsnake
	
	
done

echo "you died"