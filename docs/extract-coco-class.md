# This docs teach how to extract specific coco class

Please update the vars inside the script

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

  mkdir -p $OUTPUT_DIR
  mkdir -p $OUTPUT_DIR/images
  mkdir -p $OUTPUT_DIR/labels
  echo "$CLASS_NAME" > $OUTPUT_DIR/classes.txt

  # for each label file
  for LABELFILE in $(find "$INPUT_LABELS_DIR" -name "*.txt"); do
    # filter only detections for this class
    local FILTERED_LABEL=$(grep -E "^$CLASS_ID " "$LABELFILE")

    if [ ! -z "$FILTERED_LABEL" ]; then
      local FILENAME=$(basename "$LABELFILE")
      local FILENAME_NOEXT="${FILENAME%.txt}"
      # output label
      echo "$FILTERED_LABEL" > "$OUTPUT_DIR/labels/$FILENAME"
      # output image
      cp "$INPUT_IMAGES_DIR/$FILENAME_NOEXT.$INPUT_IMAGES_EXT" "$OUTPUT_DIR/images/$FILENAME_NOEXT.$INPUT_IMAGES_EXT"
    fi
  done
}; extract_coco
```