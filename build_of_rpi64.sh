#!/usr/bin/env bash

sudo apt-get clean -y
sudo apt-get update
sudo apt-get upgrade -y
export URL=https://github.com/openframeworks/openFrameworks/releases/download/0.12.0/of_v0.12.0_linuxaarch64_release.tar.gz
curl -L -o ofx.tar.gz $URL
tar -xf ofx.tar.gz
rm ofx.tar.gz
mv of_* openFrameworks
cd openFrameworks
export OF_ROOT=$(pwd)
cd $OF_ROOT/scripts/linux/debian/
yes y| sudo ./install_dependencies.sh
pkill yes
# add jack for compiling midistuff
cd $OF_ROOT/libs/openFrameworksCompiled/project/makefileCommon/
sed -i 's/PLATFORM_PKG_CONFIG_LIBRARIES += libcurl/PLATFORM_PKG_CONFIG_LIBRARIES += libcurl\nPLATFORM_PKG_CONFIG_LIBRARIES += jack/' config.linux.common.mk
make Release -C $OF_ROOT/libs/openFrameworksCompiled/project
cd $OF_ROOT/examples/3d/3DPrimitivesExample/
#for ssh:
export DISPLAY=:0
make && make RunRelease