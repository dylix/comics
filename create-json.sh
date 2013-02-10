#!/bin/sh

/srv/http/comics/getcomics.sh > /srv/http/comics/tmp.json
cat /srv/http/comics/tmp.json | sed '$s/,$//' > /srv/http/comics/comics.json
echo "]}" >> /srv/http/comics/comics.json
