FROM nvidia/cuda:9.0-devel-ubuntu16.04
ENV FCRNN_ROOT=/cv/fast-rcnn
ENV CAFFE_ROOT=${FCRNN_ROOT}/caffe-fast-rcnn

# dependencies
RUN apt update

RUN apt-get install -y --no-install-recommends \
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
    python-dev \
    python-numpy \
    python-pip \
    python-setuptools \
    python-scipy \
    python-tk && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip && \
    pip install cython opencv-python easydict

# clone
RUN git clone --recursive https://github.com/rbgirshick/fast-rcnn.git ${FCRNN_ROOT}
RUN pip install -r ${CAFFE_ROOT}/python/requirements.txt

# get data
VOLUME ${CAFFE_ROOT}/data/scripts
RUN cd ${FCRNN_ROOT}/data/scripts && \
    ./fetch_fast_rcnn_models.sh && \
    ./fetch_fast_rcnn_models.sh

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
WORKDIR ${FCRNN_ROOT}

# X-server
RUN apt update && apt install -y x11-apps
ENV DISPLAY=:0
