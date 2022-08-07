#!/bin/bash
# http://host.robots.ox.ac.uk/pascal/VOC/voc2012/index.html#devkit

function main() {
  local HERE=$(cd $(dirname $0) && pwd -P)
  local PROJECT_ROOT=$(cd $HERE/.. && pwd -P)

  local VOCTAR="$HERE/VOCtrainval_11-May-2012.tar"

  if [ ! -f "$VOCTAR" ]; then
    wget \
      -c "http://host.robots.ox.ac.uk/pascal/VOC/voc2012/VOCtrainval_11-May-2012.tar" \
      -O "$VOCTAR"
  fi

  # untar
  if [ -f "$VOCTAR" ]; then
    tar -xvf "$VOCTAR" -C "$HERE"
  fi

  # update folder stucture
  if [ -d "$HERE/VOCdevkit" ]; then
    mv "$HERE/VOCdevkit/VOC2012" "$HERE/VOC2012"
    rm -rf "$HERE/VOCdevkit"
  fi

  $PROJECT_ROOT/python_modules/bin/python \
  $PROJECT_ROOT/etc/python_scripts/convert_pascal_voc_2012_dataset.py

  # @FIX
  # some txt files in validation labels does not exists
  # because of this we are going to create a txt file manually
  local DATASET_TRAIN_TXT_FILE="$PROJECT_ROOT/data/VOC2012/train.txt"
  local DATASET_VALID_TXT_FILE="$PROJECT_ROOT/data/VOC2012/valid.txt"
  local DATASET_ALL_IMAGES_DIR="$PROJECT_ROOT/data/VOC2012/JPEGImages"
  # Reset train.txt and valid.txt
  rm -f "$DATASET_TRAIN_TXT_FILE"
  rm -f "$DATASET_VALID_TXT_FILE"
  # For all files inside the VOC2012 images dir
  # update train.txt and valid.txt files
  local IMAGE_INDEX=0
  local COUNT_TRAIN_FILES=0
  local COUNT_VALID_FILES=0
  for IMAGE_FILE in $(find "$DATASET_ALL_IMAGES_DIR" -type f | grep "jpg"); do
    local IMAGE_FILENAME=$(basename "$IMAGE_FILE")
    local IMAGE_FILENAME_NO_EXTENSION=$(basename "$IMAGE_FILE" .jpg)
    # 1/6 of the images are for validation
    if [ $((IMAGE_INDEX % 6)) -eq 0 ]; then
      echo "$IMAGE_FILE" >> "$DATASET_VALID_TXT_FILE"
      COUNT_VALID_FILES=$((COUNT_VALID_FILES + 1))
    else
      echo "$IMAGE_FILE" >> "$DATASET_TRAIN_TXT_FILE"
      COUNT_TRAIN_FILES=$((COUNT_TRAIN_FILES + 1))
    fi
    IMAGE_INDEX=$((IMAGE_INDEX + 1))
  done

  echo "Traning images:    $COUNT_TRAIN_FILES"
  echo "Validation images: $COUNT_VALID_FILES"
  echo "Done"
}

main
