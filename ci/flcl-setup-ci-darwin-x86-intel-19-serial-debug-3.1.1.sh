#!/bin/tcsh
## salloc -n 1 --constraint=gpu_vendor:nvidia,cpu_vendor:Intel,gpu1_model:Tesla_K40c
setenv CI_PATH_PREFIX /home/$USER/kt
setenv CI_INSTALL_DIR $CI_PATH_PREFIX/3.1.1-x86-intel-19.0.5-serial-debug
setenv CI_BUILD_DIR $CI_PATH_PREFIX/3.1.1-x86-intel-19.0.5-serial-debug-build
rm -rf $CI_INSTALL_DIR
rm -rf $CI_BUILD_DIR
mkdir -p $CI_INSTALL_DIR
mkdir -p $CI_BUILD_DIR
module load cmake/3.17.3
module load intel/19.0.5
cd $CI_BUILD_DIR
cmake /home/$USER/kokkos/kokkos-3.1.01 \
    -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTING=ON \
    -DCMAKE_INSTALL_PREFIX=$CI_INSTALL_DIR \
    -DKokkos_ENABLE_SERIAL=ON \
    -DKokkos_ENABLE_TESTS=ON
make -j check
make install
rm -rf $CI_BUILD_DIR
