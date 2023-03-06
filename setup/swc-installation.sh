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
source ${CONDA_PREFIX}/etc/profile.d/conda.sh
echo "Creating environment ${env_name}..."
conda create -y -n ${env_name} python=3.9 pip
echo "Activating environment ${env_name}..."
conda activate ${env_name}
# After an activate the CONDA_DEFAULT_ENV variable should change
# This is a STOP point in case it doesn't so that you aren't 
# messing with the base env
if [ "${CONDA_DEFAULT_ENV}" != "${env_name}" ]
then
    echo "The activation failed for some reason, so I'm bailing out of the install" 
    exit
fi
echo "Installing requirements..."
pip3 install -r ${script_dir}/requirements.txt

# Specific requirements in Mac OS
HOST_OS=`uname -s`
HOST_ARCH=`uname -m`
if [ "${HOST_OS}" == "Darwin" ]
then
    if [ "${HOST_ARCH}" == "arm64" ]
    then
        echo "Special instructions for Mac M1 and M2 chips"
        conda install -y -c apple tensorflow-deps
        python -m pip install tensorflow-macos
        python -m pip install tensorflow-metal
        pip3 install -r ${script_dir}/requirements_apple_m.txt
    fi
fi
echo "Adding DCM2NIIX"
conda install -y -c conda-forge dcm2niix
echo "Adding enviroment to Jupyter..."
conda install -y -c anaconda ipykernel
python -m ipykernel install --user --name=${env_name}
echo "Complete!"