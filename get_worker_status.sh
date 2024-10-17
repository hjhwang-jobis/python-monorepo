#!/bin/bash

workers_status=$1
worker_package_name=$2

function get_worker_status {
  status=($(echo $1 | tr ":#" "\n"))
  for ( i=0; i<${#status[@]}; i+=2 ); do
    if [[ ${status[i]} = $2 ]]; then
      echo ${status[i+1]} | tr -d " "
      exit
    fi
  done
  echo "false"
}

worker_status=$(get_worker_status $workers_status $worker_package_name)
echo $worker_status
