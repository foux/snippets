#!/bin/bash

convertsecs() {
	((d=${1}/86400))
	((h=(${1}%86400)/3600))
	((m=(${1}%3600)/60))
	((s=${1}%60))
	if (( $d > 0 )); then
		printf "%d jours, %d heures, %02d minutes et %02d secondes" $d $h $m $s
	elif (( $h > 0 )); then
		printf "%d heures, %02d minutes et %02d secondes" $h $m $s
	else
		printf "%d minutes et %02d secondes" $m $s
	fi
}

checkprogress() {
	FIRST_LINE=$1
	LAST_LINE=$2
	HEAD=$3

	SPEED=$(echo $LAST_LINE | cut -d"]" -f 2 | cut -d"=" -f4)
	REMAINING_MINS=$(echo $LAST_LINE | cut -d"]" -f 2 | cut -d"=" -f3 | cut -d "m" -f 1)
	REMAINING_SECS_DOUBLE=$(echo "$REMAINING_MINS*60" | bc)
	REMAINING_SECS_INT=$(echo $REMAINING_SECS_DOUBLE | cut -d"." -f 1)
	DEVICE=$(echo $FIRST_LINE | cut -d' ' -f 1)
	PROGRESS=$(echo $LAST_LINE | cut -d"]" -f 2 | cut -d"=" -f2 | cut -d ' ' -f 2)

	echo $HEAD $DEVICE " (" $SPEED "-" $PROGRESS "), Temps restant : " $(convertsecs $REMAINING_SECS_INT) " ETA : " `date -d "+ $REMAINING_SECS_INT seconds"`
}

RESHAPE=$(cat /proc/mdstat | grep reshape)
RECOVERY=$(cat /proc/mdstat | grep recovery)

if [[ $RESHAPE ]]; then
	FIRST_LINE=$(cat /proc/mdstat | grep -B 2 reshape | head -1)
	echo $(checkprogress "$FIRST_LINE" "$RESHAPE" "Reshape en cours de ")
elif [[ $RECOVERY ]]; then
	FIRST_LINE=$(cat /proc/mdstat | grep -B 2 recovery | head -1)
        echo $(checkprogress "$FIRST_LINE" "$RECOVERY" "Recovery en cours de ")
fi