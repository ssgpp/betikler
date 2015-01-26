#!/bin/bash

pro=`ps x -o  "%c" | grep ssgpp-mobi-debe`; 
#echo $pro; 
if [ -n "$pro" ]; then 
#echo 'kill process'; 
  killall -g ssgpp-mobi-debe
  rm -rf ~/mobi-suite/ssgpp/ssgpp_cli_workspace/debe-*.htm
  rm /tmp/ssgpp*.log
fi

