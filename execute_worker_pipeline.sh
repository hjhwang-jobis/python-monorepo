#!/bin/bash

workers_status=$1
CODEBUILD_RESOLVED_SOURCE_VERSION=$2
ENV=$3

function execute_worker_pipeline {
  status=($(echo ${workers_status} | tr ":#" "\n"))
  execute_all_pipelines="true"
  for (( i=0; i<${#status[@]}; i+=2 )); do
    if [[ ${status[i+1]} == "true" ]]; then
      execute_all_pipelines="false"
      pipeline_name=data-ai-apne2-ultron-${status[i]//_/-}-pipeline-${ENV}
      echo ${pipeline_name}
      aws codepipeline start-pipeline-execution --name test_project_a --source-revisions actionName=Source,revisionType=COMMIT_ID,revisionValue=${CODEBUILD_RESOLVED_SOURCE_VERSION}
      #aws codepipeline start-pipeline-execution --name ${pipeline_name} --source-revisions actionName=Source,revisionType=COMMIT_ID,revisionValue=${CODEBUILD_RESOLVED_SOURCE_VERSION}
    fi
  done
  if [[ $execute_all_pipelines == "true" ]]; then
    for (( i=0; i<${#status[@]}; i+=2 )); do
      pipeline_name=data-ai-apne2-ultron-${status[i]//_/-}-pipeline-${ENV}
      echo "!@#$ "${pipeline_name}
      #aws codepipeline start-pipeline-execution --name ${pipeline_name} --source-revisions actionName=Source,revisionType=COMMIT_ID,revisionValue=${CODEBUILD_RESOLVED_SOURCE_VERSION}
    done
  fi
  aws codepipeline start-pipeline-execution --name test_project_a --source-revisions actionName=Source,revisionType=COMMIT_ID,revisionValue=${CODEBUILD_RESOLVED_SOURCE_VERSION}

}

execute_worker_pipeline
