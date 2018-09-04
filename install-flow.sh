pip install cmake cython opencv-python

pip uninstall tensorflow
pip install tensorflow==1.10.0 --upgrade

# Install Flow
cd ~
git clone https://github.com/pcmoritz/flow.git
cd flow
git checkout web3d
pip install -e . --ignore-installed six
