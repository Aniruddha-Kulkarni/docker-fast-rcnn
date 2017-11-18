FROM ubuntu:16.04
ENV SS_ROOT=/cv
ENV FCRNN_ROOT=${SS_ROOT}/fast-rcnn
ENV CAFFE_ROOT=${FCRNN_ROOT}/caffe-fast-rcnn
ENV DISPLAY=:0

# dependencies
RUN apt update && \
    apt-get install -y --no-install-recommends \
    x11-apps \
    build-essential \
    cmake \
    git \
    wget \
    libatlas-base-dev \
    libboost-all-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    libhdf5-serial-dev \
    libleveldb-dev \
    liblmdb-dev \
    libopencv-dev \
    libprotobuf-dev \
    libsnappy-dev \
    libopencv-dev \
    protobuf-compiler \
    bc \
    libopenblas-dev \
    python-dev \
    python-numpy \
    python-pip \
    python-setuptools \
    python-scipy \
    python-tk && \
    rm -rf /var/lib/apt/lists/*

COPY ./selective_search/fast-rcnn/caffe-fast-rcnn/python/requirements.txt /requirements.txt
RUN pip install --upgrade pip && \
    pip install -U jupyter cython opencv-python easydict scikit-learn scikit-image && \
    pip install -r /requirements.txt

# clone
COPY ./selective_search ${SS_ROOT}

# copy config file
COPY ./Makefile.config ${CAFFE_ROOT}
# RUN cp ${CAFFE_ROOT}/Makefile.config.example ${CAFFE_ROOT}/Makefile.config

# fix path
ENV CPLUS_INCLUDE_PATH=/usr/include/python2.7:/usr/local/lib/python2.7/dist-packages/numpy/core/include

# build
RUN cd ${FCRNN_ROOT}/lib && \
    make

RUN cd ${CAFFE_ROOT} && \
    make && \
    make pycaffe

# set workdir
WORKDIR ${SS_ROOT}

# copy custom data
COPY data ${SS_ROOT}/Data/img
