Function Test-CommandExists
{
    # https://devblogs.microsoft.com/scripting/use-a-powershell-function-to-see-if-a-command-exists/
    Param ($command)
    $oldPreference = $ErrorActionPreference
    $ErrorActionPreference = "stop"
    try {if(Get-Command $command){RETURN $true}}
    Catch {Write-Host “$command does not exist”; RETURN $false}
    Finally {$ErrorActionPreference=$oldPreference}
} #end function test-CommandExists


If( ! (Test-CommandExists conda)) {
Write-Host "Install anaconda before to proceed"
# https://stackoverflow.com/questions/2022326/terminating-a-script-in-powershell
Exit
}

$env_name = "python_course"
# Split-Path "c:\temp\abc\myproj1\newdata.txt" -Leaf # No needed with the new ps3
# https://stackoverflow.com/a/5466355/1087595
$script_dir = $PSScriptRoot
# Since we are running this within a script, we need to source
# this first, lest we want errors about conda init in this
#source ${CONDA_PREFIX}/etc/profile.d/conda.sh # FIXME do I need this in powershell?
#  if so, look into: https://github.com/conda/conda/blob/main/conda/shell/condabin/conda-hook.ps1
#     and https://github.com/conda/conda/blob/main/conda/shell/condabin/Conda.psm1
Write-Host "Creating environment ${env_name}..."
conda create -y -n $env_name python=3.9 pip
Write-Host "Activating environment ${env_name}..."
conda activate $env_name
# After an activate the CONDA_DEFAULT_ENV variable should change
# This is a STOP point in case it doesn't so that you aren't
# messing with the base env
If ( $Env:CONDA_DEFAULT_ENV -ne $env_name ){
    Write-Host "The activation failed for some reason, so I'm bailing out of the install"
    Exit
}

Write-Host "Installing requirements..."
pip3 install -r $script_dir/requirements.txt
Write-Host "Adding DCM2NIIX"
conda install -y -c conda-forge dcm2niix
Write-Host "Adding enviroment to Jupyter..."
conda install -y -c anaconda ipykernel
python -m ipykernel install --user --name=${env_name}
Write-Host "Complete!"
