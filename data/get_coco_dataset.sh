#!/bin/bash
# CREDIT: https://github.com/pjreddie/darknet/tree/master/scripts/get_coco_dataset.sh

function main() {
  local HERE=$(cd $(dirname $0) && pwd -P)
  local PROJECT_ROOT=$(cd $HERE/.. && pwd -P)

  local BASE_COCO_DIR    = "$HERE/coco"
  # images
  local BASE_IMAGES_DIR  = "$BASE_COCO_DIR/images"
  local TRAIN_IMAGES_DIR = "$BASE_IMAGES_DIR/train2014"
  local VAL_IMAGES_DIR   = "$BASE_COCO_DIR/images/val2014"
  # labels
  local TRAIN_LABELS_DIR = "$BASE_COCO_DIR/labels/train2014"
  local VAL_LABELS_DIR   = "$BASE_COCO_DIR/labels/val2014"

  echo "HERE=$HERE"
  echo "PROJECT_ROOT=$PROJECT_ROOT"

  # stop on error
  set -e

  # Clone COCO API
  if [ ! -d "$BASE_COCO_DIR" ]; then
    cd "$HERE"
    echo "Cloning COCO API..."
    git clone https://github.com/pdollar/coco
  fi

  mkdir -p "$BASE_IMAGES_DIR"

  # Download Images
  if [ ! -f "$TRAIN_IMAGES_DIR.zip" ]; then
    cd "$BASE_IMAGES_DIR"
    echo 'Downloading train2014.zip'
    wget -q -c "https://pjreddie.com/media/files/train2014.zip" --header "Referer: pjreddie.com"
  fi
  if [ ! -f "$VAL_IMAGES_DIR.zip" ]; then
    cd "$BASE_IMAGES_DIR"
    echo 'Downloading val2014.zip'
    wget -q -c "https://pjreddie.com/media/files/val2014.zip" --header "Referer: pjreddie.com"
  fi

  # Unzip
  if [ ! -d "$TRAIN_IMAGES_DIR" ]; then
    cd "$BASE_IMAGES_DIR"
    echo 'Unzipping train2014.zip'
    unzip -q train2014.zip
  fi
  if [ ! -d "$VAL_IMAGES_DIR" ]; then
    cd "$BASE_IMAGES_DIR"
    echo 'Unzipping val2014.zip'
    unzip -q val2014.zip
  fi
  
  cd "$BASE_COCO_DIR"

  # Download COCO Metadata
  if [ ! -f "$BASE_COCO_DIR/instances_train-val2014.zip" ]; then
    echo 'Downloading instances_train-val2014.zip'
    wget -q -c "https://pjreddie.com/media/files/instances_train-val2014.zip" --header "Referer: pjreddie.com"
  fi
  if [ ! -f "$BASE_COCO_DIR/5k.part" ]; then
    echo 'Downloading 5k.part'
    wget -q -c "https://pjreddie.com/media/files/coco/5k.part" --header "Referer: pjreddie.com"
  fi
  if [ ! -f "$BASE_COCO_DIR/trainvalno5k.part" ]; then
    echo 'Downloading trainvalno5k.part'
    wget -q -c "https://pjreddie.com/media/files/coco/trainvalno5k.part" --header "Referer: pjreddie.com"
  fi
  if [ ! -f "$BASE_COCO_DIR/labels.tgz" ]; then
    echo 'Downloading labels.tgz'
    wget -q -c "https://pjreddie.com/media/files/coco/labels.tgz" --header "Referer: pjreddie.com"
  fi

  if [ ! -d "$BASE_COCO_DIR/labels" ]; then
    echo 'Unzipping labels.tgz'
    tar xzf labels.tgz
  fi

  if [ ! -d "$BASE_COCO_DIR/annotations" ]; then
    echo 'Unzipping instances_train-val2014.zip'
    unzip -q instances_train-val2014.zip
  fi

  # Set Up Image Lists
  paste <(awk "{print \"$PWD\"}" <5k.part) 5k.part | tr -d '\t' > 5k.txt
  paste <(awk "{print \"$PWD\"}" <trainvalno5k.part) trainvalno5k.part | tr -d '\t' > trainvalno5k.txt

  # @FIX
  # some txt files in validation labels does not exists
  # because of this we are going 
  local COCO_TRAIN_TXT_FILE   = "$BASE_COCO_DIR/trainvalno5k.txt"
  local COCO_TRAIN_IMAGES_DIR = "$TRAIN_IMAGES_DIR"
  local COCO_VAL_TXT_FILE     = "$BASE_COCO_DIR/5k.txt"
  local COCO_VAL_IMAGES_DIR   = "$VAL_IMAGES_DIR"
  # For all files inside COCO_VAL_IMAGES_DIR
  # update COCO_VAL_TXT_FILE with paths to images
  find "$COCO_TRAIN_IMAGES_DIR" > "$COCO_TRAIN_TXT_FILE"
  find "$COCO_VAL_IMAGES_DIR" > "$COCO_VAL_TXT_FILE"
}

main
