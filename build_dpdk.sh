#!/bin/bash

################################################################################
#
#  build_dpdk.sh
#
#             - Build DPDK and pktgen-dpdk for 
#
#  Usage:     Adjust variables below before running, if necessary.
#
#  MAINTAINER:  jeder@redhat.com
#
#
################################################################################

################################################################################
#  Define Global Variables and Functions
################################################################################

URL=http://fast.dpdk.org/rel/dpdk-20.05.tar.xz
BASEDIR=/usr/src
VERSION=20.05
PACKAGE=dpdk
DPDKROOT=$BASEDIR/$PACKAGE-$VERSION
CONFIG=x86_64-native-linuxapp-gcc

# Download/Build DPDK
cd $BASEDIR
wget $URL
tar -xf dpdk-20.05.tar.xz
cd $DPDKROOT
make config T=$CONFIG
sed -ri 's,(PMD_PCAP=).*,\1y,' build/.config
make config T=$CONFIG install