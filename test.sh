#!/bin/bash

map_status=$1
worker_name=$2

function check_updated_worker {
  status=($(echo $1 | tr ":#" "\n"))
  for (( i=0; i<${#status[@]}; i+=2 )); do
    if [[ ${status[i]} =~ $2 ]]; then
      echo ${status[i+1]} | tr -d " "
      exit
    fi
  done
  echo "false"
}

is_updated=$(check_updated_worker $map_status $worker_name)
echo "the value is " $is_updated
