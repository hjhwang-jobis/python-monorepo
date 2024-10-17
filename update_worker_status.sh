#!/bin/bash

workers_status=$1
file_path=$2

function update_workers_status {
  updated_status=""
  status=($(echo $1 | tr ":#" "\n"))
  for (( i=0; i<${#status[@]}; i+=2 )); do
    if [[ $2 =~ "/"${status[i]}"/"  ]]; then
      updated_status=$updated_status"#"${status[i]}":true"
    else
      updated_status=$updated_status"#"${status[i]}":"${status[i+1]}
    fi
  done
  echo ${updated_status:1}
}

updated_status=$(update_workers_status $workers_status $file_path)
echo $updated_status
