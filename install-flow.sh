apt-get install cmake swig libgtest-dev autoconf libtool pkg-config libgdal-dev libxerces-c-dev libproj-dev libfox-1.6-dev libxml2-dev libxslt1-dev build-essential curl unzip flex bison

pip install cmake cython opencv-python

# Install SUMO
cd ~
git clone https://github.com/eclipse/sumo.git
cd sumo
git checkout 1d4338ab80
make -f Makefile.cvs
./configure
make -j10

# Install Flow
cd ~
git clone https://github.com/pcmoritz/flow.git
cd flow
git checkout web3d
python setup.py develop

# Download sumo_web3d
git clone https://github.com/ray-project/sumo-web3d/
cd sumo-web3d
git checkout flow
python setup.py develop
