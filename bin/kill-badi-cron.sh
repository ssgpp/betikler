#!/bin/bash

pro=`ps x -o  "%c" | grep ssgpp-mobi-badi`; 
#echo $pro; 
if [ -n "$pro" ]; then 
#echo 'kill process'; 
  killall -g ssgpp-mobi-badi 
  rm -rf ~/mobi-suite/ssgpp/ssgpp_cli_workspace/farkbadi-*.htm
  rm /tmp/ssgpp*.log
fi

