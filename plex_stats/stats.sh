#!/bin/bash

# Set basic variables for Plex
PLEX_BINARIES=/usr/lib/plexmediaserver
PLEX_DATADIR=/var/lib/plexmediaserver

#Get script path
SCRIPTPATH="`dirname \"$0\"`"

current_hash=`ps -eo args | grep $PLEX_BINARIES'/Plex Transcoder' | grep -v 'grep' | grep 'bif' | sed -e 's/.*localhost\///g' -e 's/\.bundle.*//g' -e 's/\///g'`
if [[ ! -z $current_hash ]]
then
	file_name=`echo 'select file from media_parts where hash="'$current_hash'";' | sqlite3 $PLEX_DATADIR/Library/Application\ Support/Plex\ Media\ Server/Plug-in\ Support/Databases/com.plexapp.plugins.library.db | tail -n 1 | sed -e 's/.*\///g'`
	title=`echo 'select title from metadata_items inner join media_items on metadata_items.id = media_items.metadata_item_id inner join media_parts on media_items.id = media_parts.media_item_id where media_parts.hash="'$current_hash'";' | sqlite3 $PLEX_DATADIR/Library/Application\ Support/Plex\ Media\ Server/Plug-in\ Support/Databases/com.plexapp.plugins.library.db | tail -n 1`
	echo -e '\n''Currently creating index for: '$title' - '$file_name
	BIF_LINE=`journalctl -u plexmediaserver.service --since "20 seconds ago" | grep bif | tail -n1`
	if [[ !  -z  $BIF_LINE  ]]
	then
        	current_percent=`echo $BIF_LINE | sed -e 's/.*progress=//g' -e 's/.size=.*//g'`
        	current_speed=`echo $BIF_LINE | sed -e 's/.*speed=//g' -e 's/.vdec_hw_status.*//g'`
        	echo -e 'Current index completion: '$current_percent'%\n''Current index speed: '$current_speed'x'
	fi
else
	echo -e "Aucun index en cours"
fi
cat $SCRIPTPATH/stats.sql | sqlite3 $PLEX_DATADIR/Library/Application\ Support/Plex\ Media\ Server/Plug-in\ Support/Databases/com.plexapp.plugins.library.db
