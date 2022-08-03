#!/bin/bash
# CREDIT: https://github.com/pjreddie/darknet/tree/master/scripts/get_coco_dataset.sh

function main() {
  local HERE=$(cd $(dirname $0) && pwd -P)
  local PROJECT_ROOT=$(cd $HERE/.. && pwd -P)

  # stop on error
  set -e

  # Clone COCO API
  if [ ! -d "$HERE/coco" ]; then
    cd "$HERE"
    echo "Cloning COCO API..."
    git clone https://github.com/pdollar/coco
  fi

  mkdir -p "$HERE/coco/images"

  # Download Images
  if [ ! -f "$HERE/coco/images/train2014.zip" ]; then
    cd "$HERE/coco/images"
    echo 'Downloading train2014.zip'
    wget -q -c "https://pjreddie.com/media/files/train2014.zip" --header "Referer: pjreddie.com"
  fi
  if [ ! -f "$HERE/coco/images/val2014.zip" ]; then
    cd "$HERE/coco/images"
    echo 'Downloading val2014.zip'
    wget -q -c "https://pjreddie.com/media/files/val2014.zip" --header "Referer: pjreddie.com"
  fi

  # Unzip
  if [ ! -d "$HERE/coco/images/train2014" ]; then
    cd "$HERE/coco/images"
    echo 'Unzipping train2014.zip'
    unzip train2014.zip
  fi
  if [ ! -d "$HERE/coco/images/val2014" ]; then
    cd "$HERE/coco/images"
    echo 'Unzipping val2014.zip'
    unzip val2014.zip
  fi
  
  cd "$HERE/coco"

  # Download COCO Metadata
  if [ ! -f "$HERE/coco/instances_train-val2014.zip" ]; then
    echo 'Downloading instances_train-val2014.zip'
    wget -q -c "https://pjreddie.com/media/files/instances_train-val2014.zip" --header "Referer: pjreddie.com"
  fi
  if [ ! -f "$HERE/coco/5k.part" ]; then
    echo 'Downloading 5k.part'
    wget -q -c "https://pjreddie.com/media/files/coco/5k.part" --header "Referer: pjreddie.com"
  fi
  if [ ! -f "$HERE/coco/trainvalno5k.part" ]; then
    echo 'Downloading trainvalno5k.part'
    wget -q -c "https://pjreddie.com/media/files/coco/trainvalno5k.part" --header "Referer: pjreddie.com"
  fi
  if [ ! -f "$HERE/coco/labels.tgz" ]; then
    echo 'Downloading labels.tgz'
    wget -q -c "https://pjreddie.com/media/files/coco/labels.tgz" --header "Referer: pjreddie.com"
  fi

  if [ ! -d "$HERE/coco/labels" ]; then
    echo 'Unzipping labels.tgz'
    tar xzf labels.tgz
  fi

  if [ ! -d "$HERE/coco/annotations" ]; then
    echo 'Unzipping instances_train-val2014.zip'
    unzip instances_train-val2014.zip
  fi

  # Set Up Image Lists
  paste <(awk "{print \"$PWD\"}" <5k.part) 5k.part | tr -d '\t' > 5k.txt
  paste <(awk "{print \"$PWD\"}" <trainvalno5k.part) trainvalno5k.part | tr -d '\t' > trainvalno5k.txt
}

main
