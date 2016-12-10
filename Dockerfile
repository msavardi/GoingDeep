# Mattia Savardi nov, 17 2016
FROM	ubuntu:14.04
MAINTAINER Mattia Savardi <sava.met@gmail.com>

# Python setup
RUN	apt-get update && apt-get install -y --no-install-recommends \
	python2.7 \
	python2.7-dev \
	python-numpy \
	python-scipy \
	python-matplotlib \
	ipython ipython-notebook \
	python-pandas \
	python-sympy \
	python-nose \
	python-pip \
	python-skimage \
	python-tk \
	graphviz

# Jupyter
RUN 	pip install jupyter && \
	jupyter notebook --generate-config && \
	echo "c.NotebookApp.ip = '*'" >> ~/.jupyter/jupyter_notebook_config.py && \
	echo "c.NotebookApp.notebook_dir = u'/workspace/'" >> ~/.jupyter/jupyter_notebook_config.py && \
	echo "c.NotebookApp.token = u''" >> ~/.jupyter/jupyter_notebook_config.py && \
	echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py

# Dependencies
RUN apt-get install -y --no-install-recommends \
	build-essential \
	cmake \
	git \
	wget \
	curl\
	unzip \
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
	protobuf-compiler 

# Opencv 2.4 setup
RUN	pip install -U scikit-learn==0.14.1 && pip install scikit-image && pip install lmdb
RUN	apt-get install -y -q libavformat-dev \
	libavcodec-dev \
	libswscale-dev \
	libjpeg-dev \
	libpng-dev \
	libtiff-dev \
	libjasper-dev \
	zlib1g-dev \
	libopenexr-dev \
	libxine-dev \
	libeigen3-dev \
	libtbb-dev \
	libavfilter-dev
RUN	apt-get -qq install libopencv-dev \
	checkinstall \
	pkg-config \
	yasm \
	libjpeg-dev \	
	libjasper-dev \
	libavcodec-dev \
	libavformat-dev \
	libswscale-dev \
	libdc1394-22-dev \
	libxine-dev \
	libgstreamer0.10-dev \
	libgstreamer-plugins-base0.10-dev \
	libv4l-dev \
	libtbb-dev \
	libqt4-dev \
	libgtk2.0-dev \
	libmp3lame-dev \
	libopencore-amrnb-dev \
	libopencore-amrwb-dev \
	libtheora-dev \
	libvorbis-dev \
	libxvidcore-dev \
	x264 \
	v4l-utils && \
    rm -rf /var/lib/apt/lists/*

RUN	wget https://github.com/opencv/opencv/archive/2.4.zip && unzip 2.4.zip && rm 2.4.zip 
RUN	cd opencv-2.4/ && mkdir release && cd release && \
	cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D BUILD_PYTHON_SUPPORT=ON -D WITH_XINE=ON -D WITH_TBB=ON .. && \
	make -j"$(nproc)" && make install && cd / && rm -rf opencv-2.4.7
RUN	export PYTHONPATH=/usr/local/python/2.7:$PYTHONPATH && sudo ldconfig && sudo ln /dev/null /dev/raw1394


# Caffe setup
ENV 	CAFFE_ROOT=/opt/caffe
WORKDIR	$CAFFE_ROOT

# FIXME: clone a specific git tag and use ARG instead of ENV once DockerHub supports this.
ENV 	CLONE_TAG=master

RUN 	git clone -b ${CLONE_TAG} --depth 1 https://github.com/BVLC/caffe.git . && \
    	for req in $(cat python/requirements.txt) pydot; do pip install $req; done && \
    	mkdir build && cd build && \
    	cmake -DCPU_ONLY=1 .. && \
    	make -j"$(nproc)"

ENV 	PYCAFFE_ROOT $CAFFE_ROOT/python
ENV 	PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV 	PATH $CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH
RUN 	echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig

WORKDIR	/workspace


EXPOSE	8888

CMD ipython notebook --port-retries=0 --port=8888 --no-browser --ip=* 
