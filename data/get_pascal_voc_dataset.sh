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
    tar -xvf "$VOCTAR"
  fi

  # update folder stucture
  if [ -d "$HERE/VOCdevkit" ]; then
    mv VOCdevkit/VOC2012 VOC2012
    rm -rf VOCdevkit
  fi


  $PROJECT_ROOT/python_modules/bin/python \
    $PROJECT_ROOT/etc/python_scripts/convert_pascal_voc_2012_dataset.py
}

main
