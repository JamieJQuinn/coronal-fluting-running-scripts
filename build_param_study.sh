#!/usr/bin/env bash

set -e

mpif90=mpiifort
compiler=intel
#mode=debug

for folder in "$@"; do
  defines=

  pushd $folder
  if [[ $folder =~ "-switching" ]]; then
    defines+=" -DSWITCHING_VISCOSITY "
  fi

  make clean
  make MPIF90=$mpif90 COMPILER=$compiler DEFINE="$defines" MODE="$mode" -j4

  popd
done
