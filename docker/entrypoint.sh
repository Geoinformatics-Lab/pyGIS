#!/bin/bash
source /opt/conda/etc/profile.d/conda.sh
conda activate pygile_base

if [ "$1" = "jupyter" ] || [ $# -eq 0 ]; then
    jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --notebook-dir=/workspace
else
    exec "$@"
fi