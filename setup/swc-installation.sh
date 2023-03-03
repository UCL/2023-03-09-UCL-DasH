#! /usr/bin/env bash
if ! command -v conda &> /dev/null
then
    echo "conda could not be found"
    exit
fi
env_name="python_course"
script_dir=`dirname ${BASH_SOURCE}`
source ${CONDA_PREFIX}/etc/profile.d/conda.sh
echo "Creating environment ${env_name}..."
conda create -y -n ${env_name} python=3.9 pip
echo "Activating environment ${env_name}..."
conda activate ${env_name}
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