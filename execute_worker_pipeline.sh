#!/bin/bash

workers_status=$1

function execute_worker_pipeline {
  status=($(echo $1 | tr ":#" "\n"))
  execute_all_pipelines="true"
  for ( i=0; i<${#status[@]}; i+=2 ); do
    if [[ ${status[i+1]} = "true" ]]; then
      pipeline_name=data-ai-apne2-ultron-${status[i]//_/-}-pipeline-stg
      echo "not executing all pipelines: "${pipeline_name}
      execute_all_pipelines="false"
    fi
    aws --version
  done
  if [[ execute_all_pipelines = "true" ]]; then
    for ( i=0; i<${#status[@]}; i+=2 ); do
      pipeline_name=data-ai-apne2-ultron-${status[i]//_/-}-pipeline-stg
      echo "executing all pipelines: "${pipeline_name}
    done
  fi
}

get_worker_status $workers_status
