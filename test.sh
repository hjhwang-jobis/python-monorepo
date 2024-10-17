#!/bin/bash

map_data=$1
var=$2

function process_map {
  target=($(echo $1 | tr ":#" "\n"))
  for (( i=0; i<${#targets[@]}; i+=2 )); do
    echo "mapdata " ${targets[i]}" var " $2
    if [[ ${targets[i]} =~ $2 ]]; then
      echo ${targets[i+1]} | tr -d " "
      exit
    fi
  done
}

data=$(process_map $map_data $var)
echo "the value is " $data