#!/bin/bash
set -e
set -x
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [[ $TRAVIS_OS_NAME = "linux" ]]
then
    tag=Linux
else
    tag=MacOSX
fi

# install conda
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-$tag-x86_64.sh
sudo bash Miniconda3-latest-$tag-x86_64.sh -b -p /anaconda
sudo chown -R $USER /anaconda
export PATH=/anaconda/bin:$PATH
conda update -y conda
python -c 'import sys; print("\n".join(sys.path))'
ls /anaconda/lib/python3.5/site-packages
$SCRIPT_DIR/../simulate-travis.py --set-channel-order
$SCRIPT_DIR/../simulate-travis.py --install-requirements

conda index /anaconda/conda-bld/linux-64 /anaconda/conda-bld/osx-64
conda config --add channels file://anaconda/conda-bld
