#!/bin/bash
## this script written by zwerd
## this is used to find LFI by parm and  wordlist base on wfuzz 
[ $# -eq 0 ] && { echo "Usage: $0 <url_with_php> <php_parm_file> <wordlist_path_travesal> <cookie>"; exit 1; }

url=$1
parms=$2
wordlist=$3
cookie=$4


for parameter in $(cat $parms);
do 
	wfuzz -w $wordlist -u "$url?$parameter=FUZZ" -c -b $cookie -f wfuzz_$(echo $url|sed 's/.*:\://'|cut -d"/" -f3)_$(echo $url| sed 's/.*:\://'|awk -F"/" '{print $NF}'|sed 's/\.//g')_$(echo $parameter)_$(echo $wordlist| awk -F"/" '{print $NF}').txt;
done
