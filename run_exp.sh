#!/bin/sh
# Emulab experiment execution script
# Run this script on Emulab Ops Server

# Custom inputs
USER=boots
PROJECT=Infosphere
EXPERIMENT=cloudsurfing

ssh node1.$EXPERIMENT.infosphere.emulab.net
cd /proj/Infosphere/$USER/common/rubbosMulini6
