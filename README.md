# tensorflow_conda

A guide to setup tensorflow 2.8 with conda on stour. In short, you should be able to setup the environment by running

``` sh
./setup_env.sh <env_name>
```
You may need to chmod +x setup_env.sh to get the right permissions to run.

## What's happening
In the environment.yaml file, we setup the conda environment by installing cuda from the nvidia channel and a bunch of other things from the standard anaconda channel with then installs tensorflow 2.8.0 using pip. 

This, however, isn't enough because the tensorflow install will not be able to find the CUDA libraries by default. I'm not sure exactly why this doesn't happen inherently but we can make it work by including the `lib` folder from the conda environment in `LD_LIBRARY_PATH`. In order to make sure that the correct libraries are included when an environment is activated, we can use the instructions from https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#saving-environment-variables for setting environment variables. Essentially we create the `<conda_dir>/etc/conda/activate.d` and `<conda_dir>/etc/conda/deactivate.d` files which set LD_LIBRARY_PATH when the environment is activated and reset it back when the environment is deactivated. 
