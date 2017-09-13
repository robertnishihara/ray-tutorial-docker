FROM jupyter/minimal-notebook:ae885c0a6226

USER root

RUN apt-get update \
    && apt-get install -y vim \
    git \
    wget \
    emacs-nox \
    cmake \
    pkg-config \
    build-essential \
    autoconf \
    curl \
    libtool \
    unzip

USER $NB_USER

RUN conda install -y libgcc

RUN pip install numpy \
    cython \
    funcsigs \
    click \
    psutil \
    redis \
    flatbuffers \
    cloudpickle==0.3.0 \
    tensorflow==1.3.0 \
    gym==0.9.2 \
    smart_open \
    opencv-python \
    scipy

RUN pip install git+https://github.com/robertnishihara/ray.git@3ce394764276772bc9e9a1e1ac026363a4cd18ea#subdirectory=python

COPY exercises/*.ipynb /home/$NB_USER/exercises/
COPY rl_exercises/*.ipynb /home/$NB_USER/rl_exercises/

CMD cd /home/$NB_USER && start-notebook.sh
