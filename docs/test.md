# How to test yolo (default)

```
poetry run yolo-test -w weights/darknet53.conv.74
```


# How to test yolo tiny

```
poetry run yolo-test -w weights/yolov3-tiny.weights -m config/yolov3-tiny.cfg --data config/yolov3-tiny.data
```

Not possible to do this test because of the `data` file.

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

Test yolov3 tiny

```
MODEL_PATH='config/yolov3-tiny.cfg' \
WEIGHTS_PATH='weights/yolov3-tiny.weights' \
NAMES_PATH='data/VOC2012/voc2012.names' \
IMAGES_PATH='data/samples' \
poetry run yolo-detect \
  -w "$WEIGHTS_PATH" \
  -m "$MODEL_PATH" \
  -c "$(cat $NAMES_PATH)" \
  --n_cpu 5 \
  --images "$IMAGES_PATH"
```

single line test yolov3 tiny

```
poetry run yolo-detect -w "weights/yolov3-tiny.weights" -m "config/yolov3-tiny.cfg" -c "data/VOC2012/voc2012.names" --n_cpu 5 --images "data/samples"
```
