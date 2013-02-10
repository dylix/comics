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

echo "{
\"comics\": ["

let count=1

for URL in `cat urls.txt`; do
	lynx -source $URL > /tmp/url.html
	cat /tmp/url.html | grep "twitter:title" | awk '/content/{gsub(/.*content/,"");print $0}' | sed 's/ by.*//' | awk '{gsub("=\"",""); printf "{ \"title\":\""$0"\","}'
	echo -n "\"id\":\""$count"\","
	cat /tmp/url.html | grep "twitter:title" | awk '/content/{gsub(/.*content/,"");print $0}' | awk -F , '{print $1}' | awk '/by /{gsub(/.*by /,""); printf "\"author\":\""$0"\","}'
	cat /tmp/url.html | grep "twitter:url\"" | awk '/content/{gsub(/.*content/,"");print $0}' | awk '{gsub("=\"",""); gsub("\">",""); printf "\"url\":\""$0"\","}'
	cat /tmp/url.html | grep "twitter:image\"" | awk '/content/{gsub(/.*content/,"");print $0}' | awk '{gsub("=\"",""); gsub("\">",""); printf "\"image\":\""$0"\","}'
	cat /tmp/url.html | grep "twitter:image:width\"" | awk '/content/{gsub(/.*content/,"");print $0}' | awk '{gsub("=\"",""); gsub("\">",""); printf "\"width\":\""$0"\","}'
	cat /tmp/url.html | grep "twitter:image:height\"" | awk '/content/{gsub(/.*content/,"");print $0}' | awk '{gsub("=\"",""); gsub("\">",""); printf "\"height\":\""$0"\"},"}'
	let "count+=1"
done
