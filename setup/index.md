---
layout: page
title: Testing Setup
root: ..
---

This directory contains scripts for installing the 
environment needed for the course and testing your machine to make sure
you have the software you'll need for your workshop installed.  To use
these scripts:

## Linur or Mac 
### Download
If you are using Linux or Mac download:
* [`swc-installation.sh`](swc-installation.sh)
* [enviroment.yml](environment.yml) if Linux or Intel Mac
* [environment_apple_m.yml](environment_apple_m.yml) if you are using a new apple mac M1 or M2

### Install
If you are using **Linux** or **Mac**, find the directory where you downloaded the installation script
    and run the command from the shell.
    ~~~
    $ bash swc-installation.sh
    ~~~ 
    
## Windows
### Download 
If you are running **Windows**, download:
* [`swc-installation.ps1`](swc-installation.ps1)
* [requirements,txt](requirements.txt) 

### Install
Click with the right button on the `swc-installation.ps1` that you downloaded`swc-installation.ps1` that you downloaded and select `Run with PowerShell`. This may prompt a question about Change of policies, if so answer <key>Y</key>es.

    

1.  The install script above will create an environment named 'python_course'. Please 
    activate that environment with the following command:
   ~~~
   $ conda activate python_course
   ~~~

1.  Download [swc-installation-test-1.py](swc-installation-test-1.py).

1.  Run it from the shell:

    ~~~
    $ python swc-installation-test-1.py
    Passed
    ~~~

1.  Download [swc-installation-test-2.py](swc-installation-test-2.py).

1.  Run it from the shell:

    ~~~
    $ python swc-installation-test-2.py
    check virtual-shell...  pass
    ...
    Successes:

    virtual-shell Bourne Again Shell (bash) 4.2.37
    ...
    ~~~

    If you see something like:

    ~~~
    $ python swc-installation-test-2.py
    check virtual-shell...  fail
    ...
    check for command line shell (virtual-shell) failed:
      command line shell (virtual-shell) requires at least one of the following dependencies
      For instructions on installing an up-to-date version, see
      http://software-carpentry.org/setup/
      causes:
      check for Bourne Again Shell (bash) failed:
        could not find 'bash' executable for Bourne Again Shell (bash)
        For instructions on installing an up-to-date version, see
        http://software-carpentry.org/setup/
    ...
    ~~~

    follow the suggestions to try and install any missing software.  For
    additional troubleshooting information, you can use the `--verbose`
    option:

    ~~~
    $ python swc-installation-test-2.py --verbose
    check virtual-shell...  fail
    ...
    ==================
    System information
    ==================
    os.name            : posix
    ...
    ~~~
