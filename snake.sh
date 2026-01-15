#!/bin/bash

resolution=15
alive=true
pixels=(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
snake=(4 3 2 1)
direction="right"

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
    elif [ "$direction" = "left" ]; then
		head=$(( ${snake[0]} - 1 ))
	elif [ "$direction" = "down" ]; then
		head=$(( ${snake[0]} + $resolution ))
	elif [ "$direction" = "up" ]; then
		head=$(( ${snake[0]} - $resolution ))
	fi

	snake=("$head" "${snake[@]:0:${#snake[@]}-1}")
	    for n in "${snake[@]}"; do
        pixels[n]=2 # green for snake color
    done

}

while $alive; do
	if read -t 0.2 -n 1 key; then
		if [[ "$key" == "w" ]]; then
			direction=up
			
		elif [[ "$key" == "s" ]]; then
			direction=down
		
		elif [[ "$key" == "a" ]]; then
			direction=left

		elif [[ "$key" == "d" ]]; then
			direction=right		
			
		#else #other key
			
		fi
	#else #no key
	fi
	
	drawsnake
	printScreen
	
	sleep 0.2
done

