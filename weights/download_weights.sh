#!/bin/bash

function main() {
  local HERE=$(cd $(dirname $0) && pwd -P)
  local PROJECT_ROOT=$(cd $HERE/.. && pwd -P)
  cd "$HERE"

  # stop on error
  set -e

  if [ ! -f "$HERE/yolov3.weights" ]; then
    echo 'Download weights for vanilla YOLOv3'
    wget -q -c "https://pjreddie.com/media/files/yolov3.weights" --header "Referer: pjreddie.com"
  fi

  if [ ! -f "$HERE/yolov3-tiny.weights" ]; then
    echo 'Download weights for tiny YOLOv3'
    wget -q -c "https://pjreddie.com/media/files/yolov3-tiny.weights" --header "Referer: pjreddie.com"
  fi

  if [ ! -f "$HERE/darknet53.conv.74" ]; then
    echo 'Download weights for backbone network'
    wget -q -c "https://pjreddie.com/media/files/darknet53.conv.74" --header "Referer: pjreddie.com"
  fi
}

main
