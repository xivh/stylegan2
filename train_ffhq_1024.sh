#!/bin/bash
set -e

export NOISY=1
export DEBUG=1

config="config-f" # StyleGAN 2
#config="config-a" # StyleGAN 1

data_dir=gs://dota-euw4a/datasets
dataset=ffhq1024
mirror=true
metrics=none

export TPU_HOST=10.255.128.2
export TPU_NAME=tpu-v3-128-euw4a-50
cores=128
export MODEL_DIR=gs://dota-euw4a/runs/run76-ffhq-1024-mirror/
export BATCH_PER=4
export BATCH_SIZE=$(($BATCH_PER * $cores))
export SPATIAL_PARTITION_FACTOR=2
export RESOLUTION=1024
export LABEL_SIZE=0
#export LABEL_FILE=gs://arfa-euw4a/datasets/e621-cond/e621-cond-rxx.labels

set -x
exec python3 run_training.py --num-gpus="${cores}" --data-dir="${data_dir}" --config="${config}" --dataset="${dataset}" --mirror-augment="${mirror}" --metrics="${metrics}" "$@"