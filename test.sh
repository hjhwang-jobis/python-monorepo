#!/bin/bash

workers_status=$1
worker_package_name=$2

#workers_status =  worker_data="sample_worker:false#kafka_sample_worker:false"


function update_workers_status {
  #$1 = "sample_worker:false#kafka_sample_worker:false"
  #$2 = worker_package_name
  updated_status=""
  status=($(echo $1 | tr ":#" "\n"))
  for (( i=0; i<${#status[@]}; i+=2 )); do
    if [[ ${status[i]} =~ /$2/ ]]; then
      updated_status=$updated_status"#"${status[i]}":true"
    else
      updated_status=$updated_status"#"${status[i]}":"${status[i+1]}
    fi
  done
  echo "false"
}

function check_updated_worker {
  status=($(echo $1 | tr ":#" "\n"))
  for ( i=0; i<${#status[@]}; i+=2 ); do
    if [[ ${status[i]} =~ $2 ]]; then
      echo ${status[i+1]} | tr -d " "
      exit
    fi
  done
  echo "false"
}

if [[ func_name = "check_updated_worker" ]]; then
  is_updated=$(check_updated_worker $workers_status $worker_package_name)
  echo "the value is " $is_updated
elif [[ func_name = "update_workers_status" ]]; then
  status=$(update_workers_status $workers_status $worker_package_name)

fi
