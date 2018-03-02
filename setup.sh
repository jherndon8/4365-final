#!/bin/sh
# Emulab project setup script
# Run this script on Emulab Ops Server

# Custom inputs
USER=boots
PROJECT=Infosphere
EXPERIMENT=cloudsurfing

# Useful variables
ELBA_REPO=https://github.com/coc-gatech-newelba/NewElbaAlpha.git
XML_CONFIG=RUBBOS-4411-$PROJECT-$EXPERIMENT-$USER.xml


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
tar -zxf ./NewElbaAlpha/generator/shared_files.tar.gz --directory=/proj/Infosphere/$USER/rubbos/rubbos_yasu
mkdir -p /proj/Infosphere/$USER/softwares/data
cp -r ./NewElbaAlpha/mScopeEventMonitors /proj/Infosphere/$USER/softwares
cp -r ./NewElbaAlpha/mScopeResourceMonitors /proj/Infosphere/$USER/softwares
cp /proj/Infosphere/shared_software/rubbos_orig_data.tar.gz /proj/Infosphere/$USER/softwares/data

# Describing the Experiment by editing/completing Experiment XML
cd /proj/Infosphere/$USER/common/experiment_xml
cp RUBBOS-1111-EMULAB-DEFAULT.xml $XML_CONFIG


# Replace xml values with name and experiment name
# http://www.yourownlinux.com/2015/05/sed-command-in-linux-search-replace-patterns-in-file.html

sed -i '' "/ <param name=\"EMULAB_EXPERIMENT_NAME\"/s/value=.*/value=\"$EXPERIMENT.infosphere.emulab.net\"\/>/g" /proj/Infosphere/$USER/common/experiment_xml/$XML_CONFIG
sed -i '' "/ <param name=\"USERNAME\"/s/value=.*/value=\"$USER\"\/>/g" /proj/Infosphere/$USER/common/experiment_xml/$XML_CONFIG
sed -i '' "/ <param name=\"WORK_HOME\"/s/value=.*/value=\"\/proj\/Infosphere\/$USER\/rubbos\/rubbos_yasu\"\/>/g" /proj/Infosphere/$USER/common/experiment_xml/$XML_CONFIG
sed -i '' "/ <param name=\"OUTPUT_HOME\"/s/value=.*/value=\"\/proj\/Infosphere\/$USER\/rubbos\/rubbos_yasu\/$EXPERIMENT\"\/>/g" /proj/Infosphere/$USER/common/experiment_xml/$XML_CONFIG
sed -i '' "/ <param name=\"RUBBOS_RESULTS_HOST\"/s/value=.*/value=\"$USER@users.emulab.net\"\/>/g" /proj/Infosphere/$USER/common/experiment_xml/$XML_CONFIG
sed -i '' "/ <param name=\"RUBBOS_RESULTS_DIR_BASE\"/s/value=.*/value=\"\/proj\/Infosphere\/$USER\/results\"\/>/g" /proj/Infosphere/$USER/common/experiment_xml/$XML_CONFIG
sed -i '' "/ <param name=\"RUBBOS_RESULTS_PARSE\"/s/value=.*/value=\"\/proj\/Infosphere\/$USER\/results\"\/>/g" /proj/Infosphere/$USER/common/experiment_xml/$XML_CONFIG

sed -i '' "/ <param name=\"psMonitor\"/s/value=.*/value=\"false\"\/>/g" /proj/Infosphere/$USER/common/experiment_xml/$XML_CONFIG
sed -i '' "/ <param name=\"iostatMonitor\"/s/value=.*/value=\"false\"\/>/g" /proj/Infosphere/$USER/common/experiment_xml/$XML_CONFIG
sed -i '' "/ <param name=\"sarMonitor\"/s/value=.*/value=\"false\"\/>/g" /proj/Infosphere/$USER/common/experiment_xml/$XML_CONFIG
sed -i '' "/ <param name=\"XML_ENABLED\"/s/value=.*/value=\"false\"\/>/g" /proj/Infosphere/$USER/common/experiment_xml/$XML_CONFIG
























