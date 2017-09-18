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

RUN pip install git+https://github.com/robertnishihara/ray.git@a1b26d410bb59a04b0043c740cd364ef2b72ca67#subdirectory=python

COPY exercises/*.ipynb /home/$NB_USER/exercises/
COPY rl_exercises/*.ipynb /home/$NB_USER/rl_exercises/
COPY rl_exercises/pong_py_no_git /home/$NB_USER/rl_exercises/pong_py_no_git
COPY rl_exercises/javascript-pong /home/$NB_USER/rl_exercises/javascript-pong
COPY rl_exercises/summarization /home/$NB_USER/rl_exercises/summarization

RUN pip install /home/$NB_USER/rl_exercises/pong_py_no_git
RUN pip install /home/$NB_USER/rl_exercises/summarization

# Precompute some data to speed up creating a summarization environment.
RUN python -c "import summarization"

# Finalize environment and boot notebook.
USER root
RUN chown -R $NB_USER:users /home/$NB_USER
COPY ./start-container.sh /opt
CMD cd /home/$NB_USER && /opt/start-container.sh
