#!/bin/bash

workers_status=$1

function execute_worker_pipeline {
  status=($(echo $1 | tr ":#" "\n"))
  execute_all_pipelines="true"
  for (( i=0; i<${#status[@]}; i+=2 )); do
    if [[ ${status[i+1]} = "true" ]]; then
      execute_all_pipelines="false"
    fi
    pipeline_name=data-ai-apne2-ultron-${status[i]//_/-}-pipeline-stg
    echo "not executing all pipelines: "${pipeline_name}", status: "${status[i+1]}", package_name: "${status[i]}
  done
  echo "execute_all_pipeline value is: "$execute_all_pipelines
  if [[ execute_all_pipelines = "true" ]]; then
    for (( i=0; i<${#status[@]}; i+=2 )); do
      pipeline_name=data-ai-apne2-ultron-${status[i]//_/-}-pipeline-stg
      echo "executing all pipelines: "${pipeline_name}", status: "${status[i+1]}", package_name: "${status[i]}
    done
  fi
}

execute_worker_pipeline $workers_status
