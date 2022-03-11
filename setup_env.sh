#!/usr/bin/env bash
set -e

if [ -z "$1" ]
  then
    echo "Please supply environment name, e.g: bash setup_env.sh tf_28"
    exit 1
fi

#Create the conda env
conda_env_name=$1
conda env create -n ${conda_env_name} -f environment.yaml

#Get the location of the install
conda_env_root=$(conda env list | grep $conda_env_name | awk '{print $2}')

#Put the activation scripts into the right place
mkdir -p ${conda_env_root}/etc/conda/activate.d
mkdir -p ${conda_env_root}/etc/conda/deactivate.d

echo "#!/bin/sh" >> ${conda_env_root}/etc/conda/activate.d/env_vars.sh
echo "export LD_LIBRARY_PATH_ORIG=\${LD_LIBRARY_PATH}" >> ${conda_env_root}/etc/conda/activate.d/env_vars.sh
echo "export LD_LIBRARY_PATH=${conda_env_root}/lib:\${LD_LIBRARY_PATH}" >> ${conda_env_root}/etc/conda/activate.d/env_vars.sh

echo "#!/bin/sh" >> ${conda_env_root}/etc/conda/deactivate.d/env_vars.sh
echo "export LD_LIBRARY_PATH=\${LD_LIBRARY_PATH_ORIG}" >> ${conda_env_root}/etc/conda/deactivate.d/env_vars.sh
echo "unset LD_LIBRARY_PATH_orig" >> ${conda_env_root}/etc/conda/deactivate.d/env_vars.sh
