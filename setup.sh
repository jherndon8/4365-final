#!/bin/sh
# Emulab project setup script
# Run this script on Emulab Ops Server

# Custom inputs
USER=boots
PROJECT=Infosphere

# Useful variables
ELBA_REPO=https://github.com/coc-gatech-newelba/NewElbaAlpha.git


# Make a user directory
cd /proj/$PROJECT
if [ ! -d $USER ];  then
    mkdir $USER
    echo $USER folder created.
fi


# Initial Setup
cd /proj/$PROJECT/$USER
git clone $ELBA_REPO

cp -r ./NewElbaAlpha/generator/common /proj/Infosphere/$USER
mkdir -p /proj/Infosphere/$USER/rubbos/rubbos_yasu
tar -zxvf ./NewElbaAlpha/generator/shared_files.tar.gz --directory=/proj/Infosphere/$USER/rubbos/rubbos_yasu
mkdir -p /proj/Infosphere/$USER/softwares/data
cp -r ./NewElbaAlpha/mScopeEventMonitors /proj/Infosphere/$USER/softwares
cp -r ./NewElbaAlpha/mScopeResourceMonitors /proj/Infosphere/$USER/softwares
cp /proj/Infosphere/shared_software/rubbos_orig_data.tar.gz /proj/Infosphere/$USER/softwares/data
