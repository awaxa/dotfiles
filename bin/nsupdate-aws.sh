#!/usr/bin/env bash

conf=$HOME/.nsupdate-aws.conf

if [ -f $conf ]
then
	. $conf
elif [ -a $conf ]
then
	echo "exception: $conf exists and is not a file"
	exit 1
else
	response=""
	cli53=/usr/local/bin/cli53
	ddwrt=""
	AWS_ACCESS_KEY_ID=""
	AWS_SECRET_ACCESS_KEY=""
	zone="awaxa.net"
	record="$(hostname)"
	ttl=300

	echo "Please configure nsupdate-aws.sh"
	read -p "cli53 path (default=$cli53): " response
	[ ! $response = "" ] && cli53=$response
	read -p "dd-wrt IP address (default=$cli53): " ddwrt
	read -p "AWS_ACCESS_KEY_ID (default=$AWS_ACCESS_KEY_ID): " AWS_ACCESS_KEY_ID
	read -p "AWS_SECRET_ACCESS_KEY (default=$AWS_SECRET_ACCESS_KEY): " AWS_SECRET_ACCESS_KEY
	read -p "zone (default=$zone): " response
	[ ! $response = "" ] && zone=$response
	read -p "record (default=$record): " response
	[ ! $response = "" ] && record=$response
	
	>$conf echo "#!/usr/bin/env bash
export cli53=$cli53
export AWS_ACCESS_KEY_ID=\"$AWS_ACCESS_KEY_ID\"
export AWS_SECRET_ACCESS_KEY=\"$AWS_SECRET_ACCESS_KEY\"
export zone=\"$zone\"
export record=\"$record\"
export ttl=$ttl"
	
	echo "nsupdate-aws is now configured"
	exit 0 
fi

IPREGEX='[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}'

ip=$(curl -s "http://$ddwrt/" | grep WAN | egrep -o $IPREGEX) #scrape IP from dd-wrt status page
#checks=( "http://checkip.dyndns.org/" "http://icanhazip.com" "http://ifconfig.me" )

dig=$(dig +short +trace $record.$zone. | grep ^A | cut -f2 -d' ')

update="$cli53 rrcreate $zone $record A $ip --ttl $ttl --replace"
if [ "$1" == "-f" ] || [ "$ip" != "$dig" ] ; then
	echo $update
	$update
fi

