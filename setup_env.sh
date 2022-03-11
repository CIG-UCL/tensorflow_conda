#!/usr/bin/env bash

conda_env_name=tf28

conda env create -n ${conda_env_name} -f environment.yaml

mkdir -p ${CONDA_PREFIX}/etc/conda/activate.d
mkdir -p ${CONDA_PREFIX}/etc/conda/deactivate.d

cp ./activate.d/env_vars.sh ${CONDA_PREFIX}/etc/conda/activate.d/env_vars.sh
cp ./deactivate.d/env_vars.sh ${CONDA_PREFIX}/etc/conda/deactivate.d/env_vars.sh
