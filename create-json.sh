#!/bin/sh
WEBROOT="/srv/http/comics"
$WEBROOT/getcomics.sh > $WEBROOT/tmp.json
cat $WEBROOT/tmp.json | sed '$s/,$//' > $WEBROOT/comics.json
echo "]}" >> $WEBROOT/comics.json
