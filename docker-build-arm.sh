#!/usr/bin/env bash

if [ ! -f Resnet50_Final.pth ]; then
    echo ""
    echo "Download the RetinaFace weights Resnet50_Final.pth from"
    echo "https://www.kaggle.com/keremt/retina-face/version/3"
    echo "and put it in the top level repository folder first."
    echo ""
    exit 1
fi

image_name="faceblur"

docker rmi -f "$image_name"

docker build -f Dockerfile.arm64 -t "$image_name" .
