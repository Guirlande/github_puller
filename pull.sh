#!/bin/bash

FILENAME="pull.txt"
TARGET="$(cat $FILENAME)"
IDENTITY=$(cat token)

for NAME in $TARGET;
do
	echo "Checking if directory exists, creating if necessary ...";
	[ ! -d "$NAME" ] && mkdir $NAME;
	cd -- $NAME;
	echo "Fetching public repositories for user $NAME ...";
	page_count=$(($(($(curl -u "$IDENTITY" -s https://api.github.com/users/$NAME | jq '.public_repos') / 100))+1))
	for i in $(seq 1 $page_count)
	do
		tmp=$(curl -u "$IDENTITY" -s "https://api.github.com/users/$NAME/repos?per_page=100&page=$i" | jq '.[].ssh_url' | tr -d '"');
		echo "Repositories fetched !";
		echo "Now cloning to $(pwd)";
		for elem in $tmp; 
		do 
			repo_name=${elem##*/}
			repo_name=${repo_name%.git}
			if [ ! -d $repo_name ]; then
				echo "${elem} is getting cloned to $(pwd)/${repo_name}"
				git clone $elem $repo_name;
			else 
				cd -- $repo_name;
				echo "Pull in process for $(pwd)";
				git pull;
				cd ..;
			fi
			sleep 1
		done
	done
	cd ../;
done
