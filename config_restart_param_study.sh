#!/usr/bin/env bash

set -e

latest_snapshot=$(ls Data/*.sdf | sort | tail -n 1 | grep -Eo '[0-9]{4}')

#snapshot=latest_snapshot # use latest
snapshot=5 # specify specific snapshot number
t_end=50.0_num # End time
dt_snapshot=0.5 # specify new snapshot cadence (or comment out line below to disable)

for folder in "$@"; do
  cd $folder
  sed -i -e 's/\(initial = \).*/\1IC_RESTART/' src/control.f90
  sed -i -e 's/\(restart_snapshot = \).*/\1'${snapshot}'/' src/control.f90
  sed -i -e 's/\(t_end = \).*/\1'${t_end}'/' src/control.f90
  #sed -i -e 's/\(dt_snapshots = \).*\(_num\)/\1'${dt_snapshots}'\2/' src/control.f90
  #sed -i -e 's/dump_mask(1:8) = .*/dump_mask(2:5) = .TRUE./' src/control.f90 # specify new variables to dump
  cd ..
done

