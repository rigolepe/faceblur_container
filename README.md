# Faceblur Container

This faceblur container repository makes it easy to build a fully contained docker image for applying a face blur on video files. 
It uses the [RetinaFace](https://github.com/biubug6/Pytorch_Retinaface) neural network in the backend. The repository is based on the 
[Pytorch_faceblur](https://github.com/rigolepe/Pytorch_faceblur) code.

## Building the image

Download the [trained weights](https://www.kaggle.com/keremt/retina-face/version/3) file `Resnet50_Final.pth` from Kaggle and place 
it in the top folder of this repository. 

Run the `docker-build.sh` script. Building the image may take a while the first time because the base images need to be downloaded as well.

## Running the container

`docker run -it --rm -v $(pwd):/work faceblur videoblur.sh --input_file video.mp4 --output_file video_blur.mp4 --cpu --blur_strength 0.8 `

This will mount your working folder `pwd` to the docker image and process the given video file, located relatively to your working folder. 
The blur strength usually ranges from 0.3 (not very blurred), to 0.4 (average blur), to 0.6 (a lot of blur), though any number beteen 
0.0 and 1.0 can be used. 

Check that the exit code is zero to make sure the algorithm finished sucessfully: 

```bash
retVal=$?
if [ $retVal -ne 0 ]; then
    echo "!!!"
    echo "!!! video file not processed correctly => manually check what happened !!!"
    echo "!!!"
fi
exit $retVal
```

You may want to re-encode the resulting video to compress it or change the codec, using:

`docker run -it --rm -v $(pwd):/work faceblur ffmpeg -i video_blur.mp4 -vcodec libx264 -crf 23 video_blur_enc.mp4`

## References
- [Pytorch-RetinaFace](https://github.com/biubug6/Pytorch_Retinaface)
- [FaceBoxes](https://github.com/zisianw/FaceBoxes.PyTorch)
- [Retinaface (mxnet)](https://github.com/deepinsight/insightface/tree/master/RetinaFace)
