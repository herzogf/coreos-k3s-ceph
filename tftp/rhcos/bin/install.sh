#!/bin/bash

OCP_VER=4.2.12

if [ ! -f openshift-install-linux-${OCP_VER}.tar.gz ]
then
    wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${OCP_VER}/openshift-install-linux-${OCP_VER}.tar.gz
fi

rm -rf openshift-install
tar zxf openshift-install-linux-${OCP_VER}.tar.gz
