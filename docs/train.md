# How to train

https://github.com/eriklindernoren/PyTorch-YOLOv3

## Copy images and labels

Images should go into:
`data/custom/images/<class_name>/<image>`

Labels should go into:
`data/custom/labels/<class_name>/<image_name>.txt`

## Update classes.names

Add name of each class

The first line is class id = 0

The class and annotations should match in class id

## Update train.txt and valid.txt

Put the path to the images

Remember to split dataset into train and valid

Only the images path are required

## Train

Close everything before testing!

#### Custom dataset from scratch

```
poetry run yolo-train --n_cpu 8 --epochs 30 --model config/custom.cfg --data config/custom.data --checkpoint_interval 10 --evaluation_interval 10 --nms_thres 1.0
```

#### Yolov3 (pretrained)

Slow

```
poetry run yolo-train --n_cpu 5 --epochs 300 --data config/custom.data  --pretrained_weights weights/darknet53.conv.74
```

#### Yolov3 Tiny (pretrained)

Not working (infer identifies everything as person)

```
poetry run yolo-train --n_cpu 5 --epochs 300 --data config/custom.data --model config/yolov3-tiny.cfg  --pretrained_weights weights/yolov3-tiny.weights
```

## Open Tensorboard

```
poetry run tensorboard --logdir='logs' --port=6006
```

http://localhost:6006
