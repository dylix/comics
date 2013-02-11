#!/bin/bash
#URL="http://www.gocomics.com/2cowsandachicken"
#lynx -source $URL | grep "too_big"
#lynx -source $URL | grep "feature_item" | awk '/img/{gsub(/.*img/,"");print $3}' | awk '{gsub("?width=900.0\"",""); gsub("src=\"",""); print}'
#lynx -source $URL | grep "og:title" | awk '/content/{gsub(/.*content/,"");print $0}' | awk '{gsub("=\"",""); gsub("Via @GoComics\" />",""); print}'
#lynx -source $URL | grep "twitter:title" | awk '/content/{gsub(/.*content/,"");print $0}' | awk '{gsub("=\"",""); gsub("Via @GoComics\">",""); print}'
#lynx -source $URL | grep "twitter:image\"" | awk '/content/{gsub(/.*content/,"");print $0}' | awk '{gsub("=\"",""); gsub("\">",""); print}'

# http://www.gocomics.com/features .. manually cut out non comic ahrefs
# cat source.html | awk '/href/{gsub(/.*href/,"");print $1}' | awk '{gsub("=\"","http://www.gocomics.com"); gsub("\"",""); print}' > urls.txt
# cat comics.json | sed '$s/,$//' // REMOVE LAST COMMA

/usr/bin/echo "{
\"comics\": ["

let count=1

for URL in `/usr/bin/cat urls.txt`; do
	/usr/bin/lynx -source $URL > /tmp/url.html
	/usr/bin/cat /tmp/url.html | /usr/bin/grep "twitter:title" | /usr/bin/awk '/content/{gsub(/.*content/,"");print $0}' | /usr/bin/sed 's/ by.*//' | /usr/bin/awk '{gsub("=\"",""); printf "{ \"title\":\""$0"\","}'
	/usr/bin/echo -n "\"id\":\""$count"\","
	/usr/bin/cat /tmp/url.html | /usr/bin/grep "twitter:title" | /usr/bin/awk '/content/{gsub(/.*content/,"");print $0}' | /usr/bin/awk -F , '{print $1}' | /usr/bin/awk '/by /{gsub(/.*by /,""); printf "\"author\":\""$0"\","}'
	/usr/bin/cat /tmp/url.html | /usr/bin/grep "twitter:url\"" | /usr/bin/awk '/content/{gsub(/.*content/,"");print $0}' | /usr/bin/awk '{gsub("=\"",""); gsub("\">",""); printf "\"url\":\""$0"\","}'
	/usr/bin/cat /tmp/url.html | /usr/bin/grep "twitter:image\"" | /usr/bin/awk '/content/{gsub(/.*content/,"");print $0}' | /usr/bin/awk '{gsub("=\"",""); gsub("\">",""); printf "\"image\":\""$0"\","}'
	/usr/bin/cat /tmp/url.html | /usr/bin/grep "twitter:image:width\"" | /usr/bin/awk '/content/{gsub(/.*content/,"");print $0}' | /usr/bin/awk '{gsub("=\"",""); gsub("\">",""); printf "\"width\":\""$0"\","}'
	/usr/bin/cat /tmp/url.html | /usr/bin/grep "twitter:image:height\"" | /usr/bin/awk '/content/{gsub(/.*content/,"");print $0}' | /usr/bin/awk '{gsub("=\"",""); gsub("\">",""); printf "\"height\":\""$0"\"},"}'
	let "count+=1"
done
