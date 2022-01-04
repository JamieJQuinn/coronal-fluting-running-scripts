#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" >/dev/null && pwd  )"

resolution=512
time_end=50.0
dt_snapshots=5.0
switching_param=150 # Large enough to ensure basically parallel visc throughout domain

twisting_velocity=0.15
ramp_time=2.0

param_study_folder=results/standard
mkdir -p $param_study_folder

for n in 4; do
  for m in 3 4; do
    for visc in '-isotropic' '-switching'; do
      folder=$param_study_folder/v-${n}r-$m$visc
      cp -rv $SCRIPT_DIR/lare3d $folder

      pushd $folder

      sed -i -e 's/\(visc3 = 1.0e-\)[0-9]*/\1'$n'/' src/control.f90
      # This line disables resistivity
      #sed -i -e 's/\(eta_background =\) .*/\1'0.0_num'/' src/control.f90
      sed -i -e 's/\(eta_background = 1.0e-\)[0-9]*/\1'$m'/' src/control.f90
      sed -i -e 's/\(switching_param = \).*/\1'${switching_param}'/' src/control.f90
      sed -i -e 's/\(nx_global = \).*/\1'${resolution}'/' src/control.f90
      sed -i -e 's/\(ny_global = \).*/\1'${resolution}'/' src/control.f90
      sed -i -e 's/\(nz_global = \).*/\1'${resolution}'/' src/control.f90
      sed -i -e 's/\(t_end = \).*\(_num\)/\1'${time_end}'\2/' src/control.f90
      sed -i -e 's/\(dt_snapshots = \).*\(_num\)/\1'${dt_snapshots}'\2/' src/control.f90
      sed -i -e 's/\(twisting_velocity = \).*\(_num\)/\1'${twisting_velocity}'\2/' src/control.f90
      sed -i -e 's/\(ramp_time = \).*\(_num\)/\1'${ramp_time}'\2/' src/control.f90

      popd
    done
  done
done
