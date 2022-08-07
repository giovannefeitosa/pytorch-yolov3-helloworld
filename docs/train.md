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

> GPU

Had to set this environment variable to work with 5gb video card.

```
PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:4310
```

But this didn't solve the issue.

Then I changed `batch=16` to `batch=1` in this file: `config/custom.cfg`

#### Yolov3 (pretrained)

Really Really Slow

```
poetry run yolo-train --n_cpu 8 --epochs 1 --data config/coco.data --model config/yolov3.cfg --pretrained_weights weights/darknet53.conv.74
```

#### Yolov3 Tiny (pretrained)

TESTING!

```
poetry run yolo-train --n_cpu 8 --epochs 5 --data config/yolov3-tiny.data --model config/yolov3-tiny.cfg --pretrained_weights weights/yolov3-tiny.weights
```

## Open Tensorboard

```
poetry run tensorboard --logdir='logs' --port=6006
```

http://localhost:6006
