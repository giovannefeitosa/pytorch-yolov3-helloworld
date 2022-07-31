# Datasets

## images and labels

Images should go into:
`data/custom/images/<class_name>/<image>`

Labels should go into:
`data/custom/labels/<class_name>/<image_name>.txt`

## How to upload images by ssh to a server

Run this **FROM HOST** in the root of the repo

```bash
# variables
SSH_ADDR=$GIOVANNE_SSH_ADDR
SSH_USER=$GIOVANNE_SSH_USER

LOCAL_HERE=$(pwd -P)
LOCAL_IMAGES_DIR="$LOCAL_HERE/data/custom/images"
LOCAL_LABELS_DIR="$LOCAL_HERE/data/custom/labels"
LOCAL_IMAGES_TARGZ="$LOCAL_HERE/images.tar.gz"
LOCAL_LABELS_TARGZ="$LOCAL_HERE/labels.tar.gz"

REMOTE_PROJECT_ROOT="~/pytorch-yolov3-helloworld"
REMOTE_IMAGES_DIR="$REMOTE_PROJECT_ROOT/$LOCAL_IMAGES_DIR"
REMOTE_LABELS_DIR="$REMOTE_PROJECT_ROOT/$LOCAL_LABELS_DIR"
REMOTE_IMAGES_TARGZ="$REMOTE_PROJECT_ROOT/images.tar.gz"
REMOTE_LABELS_TARGZ="$REMOTE_PROJECT_ROOT/labels.tar.gz"

# compress
function compressImagesAndLabels() {
  tar -C "$LOCAL_IMAGES_DIR" -czvf "$LOCAL_IMAGES_TARGZ" .
  tar -C "$LOCAL_LABELS_DIR" -czvf "$LOCAL_LABELS_TARGZ" .
}
( compressImagesAndLabels )

# copy
scp $LOCAL_IMAGES_TARGZ $SSH_USER@$SSH_ADDR:$REMOTE_IMAGES_TARGZ
scp $LOCAL_LABELS_TARGZ $SSH_USER@$SSH_ADDR:$REMOTE_LABELS_TARGZ

# run in remote
ssh $SSH_USER@$SSH_ADDR "
  rm -rf $REMOTE_IMAGES_DIR $REMOTE_LABELS_DIR
  mkdir -p $REMOTE_IMAGES_DIR $REMOTE_LABELS_DIR
  tar -xzvf $REMOTE_IMAGES_TARGZ -C $REMOTE_IMAGES_DIR
  tar -xzvf $REMOTE_LABELS_TARGZ -C $REMOTE_LABELS_DIR
"

rm -f $LOCAL_IMAGES_TARGZ $LOCAL_LABELS_TARGZ
```
