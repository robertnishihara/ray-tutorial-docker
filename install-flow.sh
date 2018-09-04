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
