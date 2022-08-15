# This docs teach how to extract specific coco class

Please update the vars inside the script

The following script creates the following structure:

* io
  * datasets
    * person
      * classes.txt
      * images
      * labels
      * train.part
      * test.part

```bash
function extract_coco() {
  # class
  local CLASS_ID=0
  local CLASS_NAME=person
  # output
  local OUTPUT_DIR=io/datasets/${CLASS_NAME}
  # input
  local INPUT_IMAGES_EXT=jpg
  local INPUT_IMAGES_DIR=data/coco/images/train2014
  local INPUT_LABELS_DIR=data/coco/labels/train2014

  #mkdir -p $OUTPUT_DIR
  #mkdir -p $OUTPUT_DIR/images
  #mkdir -p $OUTPUT_DIR/labels
  #echo "$CLASS_NAME" > $OUTPUT_DIR/classes.txt
  #
  ## for each label file
  #for LABELFILE in $(find "$INPUT_LABELS_DIR" -name "*.txt"); do
  #  # filter only detections for this class
  #  local FILTERED_LABEL=$(grep -E "^$CLASS_ID " "$LABELFILE")
  #
  #  if [ ! -z "$FILTERED_LABEL" ]; then
  #    local FILENAME=$(basename "$LABELFILE")
  #    local FILENAME_NOEXT="${FILENAME%.txt}"
  #    # output label
  #    echo "$FILTERED_LABEL" > "$OUTPUT_DIR/labels/$FILENAME"
  #    # output image
  #    cp "$INPUT_IMAGES_DIR/$FILENAME_NOEXT.$INPUT_IMAGES_EXT" "$OUTPUT_DIR/images/$FILENAME_NOEXT.$INPUT_IMAGES_EXT"
  #  fi
  #done

  # create train.part and test.part
  cd "$OUTPUT_DIR"
  local TRAIN_PART_FILE="train.part"
  local TRAIN_TXT_FILE="train.txt"
  local TEST_PART_FILE="test.part"
  local TEST_TXT_FILE="test.txt"
  local GET_VALID_COUNT=1000
  local FILENAMES=$(ls images/ | grep ".$INPUT_IMAGES_EXT")
  for FNAME in $FILENAMES; do
    echo "images/$FNAME" >> "$TRAIN_PART_FILE"
    echo "$PWD/images/$FNAME" >> "$TRAIN_TXT_FILE"
  done
  tail -n $GET_VALID_COUNT "$TRAIN_PART_FILE" > "$TEST_PART_FILE"
  tail -n $GET_VALID_COUNT "$TRAIN_TXT_FILE" > "$TEST_TXT_FILE"
}; ( extract_coco )
```