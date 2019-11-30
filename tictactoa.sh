#!/bin/bash
echo "WelCome In Tictactoa Simulator"

declare -a board
#constants
playerSymbol=0
computerSymbol=0


function resetBoard()
{
	for (( i=1; i<=9; i++ ))
	do
		board[$i]="$i"
	done
}

function assignLetterXOrO()
{
	assign=1
	random=$((RANDOM%2))
	if [ $assign -eq $random ]
        then
                playerSymbol=X
                computerSymbol=O
                echo "player:"
		echo  $playerSymbol 
                echo "computer:"
		echo  $computerSymbol
        else
                playerSymbol=O
                computerSymbol=X
                echo "player:" $playerSymbol
                echo "computer:" $computerSymbol
        fi
}

function tossToCheckWhoPlaySFirst()
{
        random=$((RANDOM%2+1))
        if [ $random -eq 1 ]
        then
		chanceOf="player"
        else
		chanceOf="computer"
        fi
}

function displayBoard()
{
        local i=1
        for (( j=0; j<3; j++ ))
        do
                echo "|---|---|---|"
                echo "| "${board[$i]}" | "${board[$i+1]}" | "${board[$i+2]}" |"
                i=$(($i+3))
        done
}

function checkForDiagonal()
{
	for (( i=1; i<2; i++ ))
	do
		if [[ ${board[$i]} == ${board[$i+4]} ]] && [[ ${board[$i+4]} == ${board[$i+8]} ]] && [[ ${board[$i+8]} == $playerSymbol ]]
		then
			displayBoard
			echo "Game Win"
			exit
		elif [[ ${board[$i+2]} == ${board[$i+4]} ]] && [[ ${board[$i+4]} == ${board[$i+6]} ]] && [[ ${board[$i+6]} == $playerSymbol ]]
		then
			displayBoard
			echo "Game Win"
			exit
		fi
	done
}

function checkForRow()
   {

	for (( i=1; i<=9; i=i+3 ))
	do
		if [[ ${board[$i]} == ${board[$i+1]} ]] && [[ ${board[$i+1]} == ${board[$i+2]} ]] && [[ ${board[$i+2]} == $playerSymbol ]]	
		then
			displayBoard
			echo "Game Win"
			exit
		fi
	done

}

function checkForCol()
{
	for (( i=1; i<=3; i++ ))
	do
		if [[ ${board[$i]} == ${board[$i+3]} ]] && [[ ${board[$i+3]} == ${board[$i+6]} ]] && [[ ${board[$i+6]} == $playerSymbol ]]
		then
			displayBoard
			echo "Game win"
			exit
		fi

		i=$((i+3))
	done
}

function checkForWin()
{
checkForDiagonal
checkForRow
checkForCol
}


function startPlaying()
{
	local i=1
	local min=0
	local max=9
	while [[ $i -ge $min && $i -le $max ]]
	do
		if [ $chanceOf == "player" ]
		then
			displayBoard
			echo "Enter the cell number to put your symbol"
			read i
				if [ ${board[$i]} == "$i" ]
				then
					board[$i]=$playerSymbol
					checkForWin
				else
					echo "check for empty cell"
				fi
		else
			echo "computers turn"
			break
		fi
	done
}


function main()
{
	resetBoard
	assignLetterXOrO
	tossToCheckWhoPlaySFirst
#	displayBoard
	startPlaying
#	checkForWin
}

main
