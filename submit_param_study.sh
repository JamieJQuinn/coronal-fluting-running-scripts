#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" >/dev/null && pwd  )"

for folder in "$@"
do
  pushd $folder
  qsub $SCRIPT_DIR/myriad_lare3d_submission.sh
  popd
done
