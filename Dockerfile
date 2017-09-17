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
    scipy \
    spacy

RUN python -m spacy download en

RUN pip install git+https://github.com/robertnishihara/ray.git@5e96571ebe138a6cbf381e86624d7c96757dc173#subdirectory=python

COPY exercises/*.ipynb /home/$NB_USER/exercises/
COPY rl_exercises/*.ipynb /home/$NB_USER/rl_exercises/
COPY rl_exercises/pong_py_no_git /home/$NB_USER/rl_exercises/pong_py_no_git
COPY rl_exercises/javascript-pong /home/$NB_USER/rl_exercises/javascript-pong

RUN pip install /home/$NB_USER/rl_exercises/pong_py_no_git
RUN pip install /home/$NB_USER/rl_exercises/summarization

CMD cd /home/$NB_USER && start-notebook.sh
