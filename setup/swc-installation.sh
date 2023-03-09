#! /usr/bin/env bash
if ! command -v conda &> /dev/null
then
    echo "conda could not be found"
    exit
fi
env_name="python_course"
script_dir=`dirname ${BASH_SOURCE}`
# Since we are running this within a script, we need to source 
# this first, lest we want errors about conda init in this
echo "Creating environment ${env_name}..."
# This is a STOP point in case it doesn't so that you aren't 
# messing with the base env
echo "Installing requirements..."
# Specific requirements in Mac OS
HOST_OS=`uname -s`
HOST_ARCH=`uname -m`
if [ "${HOST_OS}" == "Darwin" ] && [ "${HOST_ARCH}" == "arm64" ]
then
    echo "Special instructions for Mac M1 and M2 chips"
    conda env create -f ${script_dir}/environment_apple_m.yml
else
    conda env create -f ${script_dir}/environment.yml
fi
echo "Adding enviroment to Jupyter..."
python -m ipykernel install --user --name=${env_name}
echo "Complete!"