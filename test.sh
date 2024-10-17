#!/bin/bash

map_data=$1
var=$2

function process_map {
  targets=($(echo $1 | tr ":#" "\n"))
  for (( i=0; i<${#targets[@]}; i+=2 )); do
    if [[ ${targets[i]} =~ $2 ]]; then
      echo ${targets[i+1]} | tr -d " "
      exit
    fi
  done
}

data=$(process_map $map_data $var)
echo "the value is " $data