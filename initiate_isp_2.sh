#!/bin/bash

# Run this script after:
# bash initiate_isp_1.sh
# source ~/.bashrc
conda config --add channels conda-forge
conda config --set channel_priority strict
conda install bash-completion
pip install nvitop