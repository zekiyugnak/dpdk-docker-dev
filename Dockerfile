FROM centos:8
MAINTAINER zeki yugnak <zeki.yugnak@aurea.com>

#LABEL "RUN docker run -it --privileged -v /sys/bus/pci/drivers:/sys/bus/pci/drivers -v /sys/kernel/mm/hugepages:/sys/kernel/mm/hugepages -v /sys/devices/system/node:/sys/devices/system/node -v /dev:/dev --name NAME -e NAME=NAME -e IMAGE=IMAGE IMAGE"
# Setup yum repos, or use subscription-manager
# Install DPDK support packages.

#
# Install required packages
#
RUN yum groupinstall -y "Development Tools"
RUN yum install -y wget numactl-devel git golang make; yum clean all
# Debug Tools (if needed):
RUN yum install -y pciutils iproute; yum clean all
RUN yum install -y sudo libhugetlbfs-utils libpcap \
    kernel kernel-devel kernel-headers

# Build DPDK and pktgen-dpdk for x86_64-native-linuxapp-gcc.
WORKDIR /usr/src
COPY ./build_dpdk.sh /usr/src/build_dpdk.sh
COPY ./dpdk-profile.sh /etc/profile.d/
RUN ["chmod", "+x", "/usr/src/build_dpdk.sh"]
RUN /usr/src/build_dpdk.sh


# Defaults to a bash shell, you could put your DPDK-based application here.
CMD ["/usr/bin/bash"]