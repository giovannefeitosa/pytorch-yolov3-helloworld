#!/bin/bash

function prepare_person_dataset() {
  local HERE=$(cd $(dirname "$0") && pwd -P)
  local PROJECT_ROOT=$(cd "$HERE/../.." && pwd -P)
  local DATASET_RELATIVE_DIR="io/datasets/person"
  local DATASET_DIR="$PROJECT_ROOT/$DATASET_RELATIVE_DIR"
  local INPUT_TRAIN_PART="$DATASET_DIR/train.part"
  local INPUT_TEST_PART="$DATASET_DIR/test.part"
  local OUTPUT_TRAIN_TXT="$DATASET_DIR/train.txt"
  local OUTPUT_TEST_TXT="$DATASET_DIR/test.txt"

  echo "Preparing person dataset..."
  echo "  Input train part: $INPUT_TRAIN_PART"
  echo "  Input test part: $INPUT_TEST_PART"
  echo "  Output train txt: $OUTPUT_TRAIN_TXT"
  echo "  Output test txt: $OUTPUT_TEST_TXT"
  echo ""

  copy_part_with_absolute_path "$INPUT_TRAIN_PART" "$OUTPUT_TRAIN_TXT"
  copy_part_with_absolute_path "$INPUT_TEST_PART" "$OUTPUT_TEST_TXT"

  echo "Prepare stage: Done."
}

function copy_part_with_absolute_path() {
  local INPUT_PART="$1"
  local OUTPUT_TXT="$2"
  # reset OUTPUT_TXT
  rm -f "$OUTPUT_TXT"
  # foreach line in INPUT_PART
  for line in $(cat "$INPUT_PART"); do
    # split line into two parts
    # where the separator is DATASET_RELATIVE_DIR
    local SPLIT=(${line//$DATASET_RELATIVE_DIR/ })
    # get the last part of SPLIT
    local IMAGE_PATH=${SPLIT[${#SPLIT[@]} - 1]}
    # prepend with DATASET_DIR
    IMAGE_PATH="$DATASET_DIR/$IMAGE_PATH"
    # echo to OUTPUT_TXT
    echo "$IMAGE_PATH" >> "$OUTPUT_TXT"
  done
}

( prepare_person_dataset $@ )
