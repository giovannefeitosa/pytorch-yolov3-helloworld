# How to test yolo (default)

```
poetry run yolo-test -w weights/darknet53.conv.74
```


# How to test yolo tiny

against valid.txt, outputs in terminal

```
yolov3_tiny_yolo_test () {
  WEIGHTS_PATH='weights/yolov3-tiny.weights'
  MODEL_PATH='config/yolov3-tiny.cfg'
  DATA_PATH='config/coco.data'
  poetry run yolo-test -w "$WEIGHTS_PATH" -m "$MODEL_PATH" --data "$DATA_PATH" --n_cpu 5
}; yolov3_tiny_yolo_test
```

against $IMAGE_PATH, outputs in `outputs/`
using default downloaded weights.

```
yolov3_tiny_yolo_detect () {
  WEIGHTS_PATH='weights/yolov3-tiny.weights'
  MODEL_PATH='config/yolov3-tiny.cfg'
  NAMES_PATH='data/coco.names'
  IMAGES_PATH='data/samples'
  poetry run yolo-detect -w "$WEIGHTS_PATH" -m "$MODEL_PATH" -c "$NAMES_PATH" --n_cpu 5 --images "$IMAGES_PATH"
}; yolov3_tiny_yolo_detect
```

yolov3 tiny with the last checkpoint
get samples and output in `outputs/`

```
yolov3_tiny_yolo_detect_checkpoint () {
  WEIGHTS_PATH=checkpoints/checkpoints/$(ls checkpoints/checkpoints | grep ".pth" | tail -1)
  MODEL_PATH='config/yolov3-tiny.cfg'
  NAMES_PATH='data/coco.names'
  IMAGES_PATH='data/samples'
  poetry run yolo-detect -w "$WEIGHTS_PATH" -m "$MODEL_PATH" -c "$NAMES_PATH" --n_cpu 5 --images "$IMAGES_PATH"
}; yolov3_tiny_yolo_detect_checkpoint
```


The `data` file is like this:

`config/custom.data`
```conf
classes=1
train=data/custom/train.txt
valid=data/custom/valid.txt
names=data/custom/classes.names
```

`config/coco.data`
```conf
classes=80
train=data/coco/trainvalno5k.txt
valid=data/coco/5k.txt
names=data/coco.names
backup=backup/
eval=coco
```

So I need to have this data for yolov3-tiny, and I have to download:
* yolov3-tiny train txt files
* yolov3-tiny valid txt files
* yolov3-tiny names file

> I need to know what is `eval`

## What is Eval?

?

# How to test a custom weights file

```
poetry run yolo-detect -w checkpoints/yolov3_ckpt_300.pth -m config/yolov3-tiny.cfg -c data/custom/classes.names
```

---

> single line test yolov3 tiny - WITH VOC DOES NOT WORK
> 
> poetry run yolo-detect -w "weights/yolov3-tiny.weights" -m "config/yolov3-tiny.cfg" -c "data/VOC2012/voc2012.names" --n_cpu 5 --images "data/> samples"

