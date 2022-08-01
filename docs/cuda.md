# CUDA

Install cuda 11.6, not the newest one.

Install by conda:

```
mamba install -c nvidia/label/cuda-11.6.2 cuda-nvml-dev
mamba install -c nvidia/label/cuda-11.6.2 cuda
```

> Seems that pytorch does not support cuda 11.7

## Test cuda

```
python is_cuda_available.py
python is_cuda_available_test2.py
```

## Tried to install pytorch for cuda 11.6

Got this command from here:
https://pytorch.org/get-started/locally/

```
pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu116
```

This worked for `is_cuda_available_test2.py` but not using pytorch

```
conda install -c pytorch cudatoolkit=11.7
python -c 'import torch; print(torch.rand(2,3).cuda())'
```

gave me the following error:

`AssertionError: Torch not compiled with CUDA enabled`

```
pip install torch==1.12.0+cu116 torchvision==0.13.0+cu116 torchaudio==0.12.0 -f https://download.pytorch.org/whl/torch_stable.html
python -c 'import torch; print(torch.rand(2,3).cuda())'
python is_cuda_available.py
```

WORKED!

But I got the following error:

```
Training Epoch 1:   0%|                                                                                                                                                                                             | 0/179 [00:11<?, ?it/s]
Traceback (most recent call last):
  File "<string>", line 1, in <module>
  File "C:\Users\Gamer\dev\giovanne\pytorch-yolov3-helloworld\pytorchyolo\train.py", line 165, in run
    loss, loss_components = compute_loss(outputs, targets, model)
  File "C:\Users\Gamer\dev\giovanne\pytorch-yolov3-helloworld\pytorchyolo\utils\loss.py", line 66, in compute_loss
    tcls, tbox, indices, anchors = build_targets(predictions, targets, model)  # targets
  File "C:\Users\Gamer\dev\giovanne\pytorch-yolov3-helloworld\pytorchyolo\utils\loss.py", line 174, in build_targets
    indices.append((b, a, gj.clamp_(0, gain[3] - 1), gi.clamp_(0, gain[2] - 1)))
RuntimeError: result type Float can't be cast to the desired output type __int64
```

So I will try to downgrade torch, torchvision and torchaudio:

```
pip install torch==1.10.2+cu113 torchvision==0.11.3+cu113 torchaudio==0.10.2 -f https://download.pytorch.org/whl/torch_stable.html
python -c 'import torch; print(torch.rand(2,3).cuda())'
python is_cuda_available.py
```

pip install torch==1.9.1+cu111 -f https://download.pytorch.org/whl/torch_stable.html
pip install torchvision==0.8.2+cu110 -f https://download.pytorch.org/whl/torch_stable.html
pip install torchaudio==0.9.0


