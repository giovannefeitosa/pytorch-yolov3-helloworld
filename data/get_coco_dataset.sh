#!/bin/bash
# CREDIT: https://github.com/pjreddie/darknet/tree/master/scripts/get_coco_dataset.sh

function main() {
  local HERE=$(cd $(dirname $0) && pwd -P)
  local PROJECT_ROOT=$(cd $HERE/.. && pwd -P)
  cd "$HERE"

  # Clone COCO API
  if [ ! -d "coco" ]; then
    git clone https://github.com/pdollar/coco
  fi

  mkdir -p coco/images
  cd "$HERE/coco/images"

  # Download Images
  if [ ! -f "train2014.zip" ]; then
    wget -q -c "https://pjreddie.com/media/files/train2014.zip" --header "Referer: pjreddie.com"
  fi
  if [ ! -f "val2014.zip" ]; then
    wget -q -c "https://pjreddie.com/media/files/val2014.zip" --header "Referer: pjreddie.com"
  fi

  # Unzip
  if [ ! -d "train2014" ]; then
    unzip train2014.zip
  fi
  if [ ! -d "val2014" ]; then
    unzip val2014.zip
  fi
  
  cd "$HERE/coco"

  # Download COCO Metadata
  if [ ! -f "instances_train-val2014.zip" ]; then
    wget -q -c "https://pjreddie.com/media/files/instances_train-val2014.zip" --header "Referer: pjreddie.com"
  fi
  if [ ! -f "5k.part" ]; then
    wget -q -c "https://pjreddie.com/media/files/coco/5k.part" --header "Referer: pjreddie.com"
  fi
  if [ ! -f "trainvalno5k.part" ]; then
    wget -q -c "https://pjreddie.com/media/files/coco/trainvalno5k.part" --header "Referer: pjreddie.com"
  fi
  if [ ! -f "labels.tgz" ]; then
    wget -q -c "https://pjreddie.com/media/files/coco/labels.tgz" --header "Referer: pjreddie.com"
  fi

  if [ ! -d "labels" ]; then
    tar xzf labels.tgz
  fi

  if [ ! -d "annotations" ]; then
    unzip -q instances_train-val2014.zip
  fi

  # Set Up Image Lists
  paste <(awk "{print \"$PWD\"}" <5k.part) 5k.part | tr -d '\t' > 5k.txt
  paste <(awk "{print \"$PWD\"}" <trainvalno5k.part) trainvalno5k.part | tr -d '\t' > trainvalno5k.txt
}

main
