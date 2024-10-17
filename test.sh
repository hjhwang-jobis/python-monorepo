#!/bin/bash

# 맵 데이터를 문자열로 정의
map_data="EXECUTE_ALL_PIPELINE:false EXECUTE_SAMPLE_WORKER:false"

# 특정 함수 정의
process_value() {
    local key=$1
    local value=$2
    echo "Processing $key with value $value"
    # 여기에 원하는 처리를 추가할 수 있습니다.
}

# 맵 데이터를 순회하면서 함수 실행
process_map() {
    echo "$@" | awk '
    BEGIN {
        FS="[: ]"
    }
    {
        for (i=1; i<=NF; i+=2) {
            print $i $(i+1)
        }
    }'
}

# 실행
process_map "$map_data"