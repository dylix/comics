#!/bin/sh

/bin/sh /srv/http/comics/getcomics.sh > /srv/http/comics/tmp.json
/usr/bin/cat /srv/http/comics/tmp.json | /usr/bin/sed '$s/,$//' > /srv/http/comics/comics.json
/usr/bin/echo "]}" >> /srv/http/comics/comics.json
