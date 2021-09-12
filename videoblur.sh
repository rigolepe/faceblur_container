#!/usr/bin/env bash

# echo "python path: $PYTHONPATH"
# echo "list: $(ls -lha $HOME/Pytorch_faceblur)"

python $HOME/Pytorch_faceblur/video.py -m /weights/Resnet50_Final.pth  "$@" 
