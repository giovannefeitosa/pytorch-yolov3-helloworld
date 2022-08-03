#!/bin/bash

function main() {
  local HERE=$(cd $(dirname $0) && pwd -P)
  local PROJECT_ROOT=$(cd $HERE/.. && pwd -P)
  cd "$HERE"

  local CACHE_WEIGHTS_DIR='/tmp/pytorch-yolov3-helloworld/weights'
  mkdir -p "$CACHE_WEIGHTS_DIR"

  echo "CACHE_WEIGHTS_DIR=$CACHE_WEIGHTS_DIR"

  # stop on error
  set -e

  if [ ! -f "$HERE/yolov3.weights" ]; then
    if [ -f "$CACHE_WEIGHTS_DIR/yolov3.weights" ]; then
      echo 'Copy weights from cache: yolov3.weights'
      cp "$CACHE_WEIGHTS_DIR/yolov3.weights" "$HERE/yolov3.weights"
    else
      echo 'Download weights for vanilla YOLOv3'
      wget -q -c "https://pjreddie.com/media/files/yolov3.weights" --header "Referer: pjreddie.com"
      cp "$HERE/yolov3.weights" "$CACHE_WEIGHTS_DIR/yolov3.weights"
    fi
  fi

  if [ ! -f "$HERE/yolov3-tiny.weights" ]; then
    if [ -f "$CACHE_WEIGHTS_DIR/yolov3-tiny.weights" ]; then
      echo 'Copy weights from cache: yolov3-tiny.weights'
      cp "$CACHE_WEIGHTS_DIR/yolov3-tiny.weights" "$HERE/yolov3-tiny.weights"
    else
      echo 'Download weights for tiny YOLOv3'
      wget -q -c "https://pjreddie.com/media/files/yolov3-tiny.weights" --header "Referer: pjreddie.com"
      cp "$HERE/yolov3-tiny.weights" "$CACHE_WEIGHTS_DIR/yolov3-tiny.weights"
    fi
  fi

  if [ ! -f "$HERE/darknet53.conv.74" ]; then
    if [ -f "$CACHE_WEIGHTS_DIR/darknet53.conv.74" ]; then
      echo 'Copy weights from cache: darknet53.conv.74'
      cp "$CACHE_WEIGHTS_DIR/darknet53.conv.74" "$HERE/darknet53.conv.74"
    else
      echo 'Download weights for backbone network'
      wget -q -c "https://pjreddie.com/media/files/darknet53.conv.74" --header "Referer: pjreddie.com"
      cp "$HERE/darknet53.conv.74" "$CACHE_WEIGHTS_DIR/darknet53.conv.74"
    fi
  fi
}

main
