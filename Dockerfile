FROM nvidia/cuda:11.4.1-cudnn8-runtime-ubuntu20.04
# FROM nvidia/cuda:11.4.1-cudnn8-devel-ubuntu20.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
	ca-certificates git wget sudo python3-dev python3-pip bzip2 ffmpeg && \
    rm -rf /var/lib/apt/lists/*
RUN ln -sv /usr/bin/python3 /usr/bin/python && \
    pip3 install --upgrade pip 

# install faceblur dependencies 
WORKDIR /app
RUN git clone https://github.com/rigolepe/Pytorch_faceblur && \
    cd Pytorch_faceblur && \
    pip3 install --user --no-deps -r requirements.txt && \
    cd ..
ENV PYTHONPATH=/app/Pytorch_faceblur/:$PYTHONPATH
# the docker image must be self-contained, so we have to copy the large weights file into it
COPY Resnet50_Final.pth /weights/
COPY videoblur.sh /bin/

WORKDIR /work
RUN sudo chmod -R 777 /work
ENV PYTHONPATH=/work/:$PYTHONPATH

ENV FVCORE_CACHE="/tmp"

# let RetinaFace download the default model file into the docker image 
RUN videoblur.sh --load_model_only --input_file dummy.mp4 --output_file dummy.mp4 --cpu --blur_strength 0.4

CMD ["bash"]
