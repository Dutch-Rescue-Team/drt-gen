# drt-gen
This script is used to create the sdcard image for the Raspberry Pi driving the Dutch Rescue Team robot.

## Usage
The generated image can best be installed with Raspberry Pi Imager as a custom image.

The advanced options in Imager can be used.
* It is especially recommended to choose another name for your robot to make it unique.
* If you don't use one of the pre-configured wifi networks, it is advised to provide your wifi credentials.
  * Otherwise, you can still connect via ethernet.
* NOTE: Sometimes the pre-configured wifi connections will only be available after the second boot.

You can connect using:
* ssh
* vnc client
  * NOTE: Insecure authentication is used to allow non-realvnc clients. So an SSH Gateway should be used.
  * NOTE: Some vnc clients won't connect with a new host until the remote host is accepted as known host using a plain ssh connection (e.g. MobaXterm).
* rdp client
* Visual Studio Code via Remote-SSH

## Preconfigured wifi networks
* DRT - prio 5
* NT-DEV - prio 3
* OnsMorsOnsTyd - prio 1
* RobotJoep - prio 3
* wavelan2 - prio 1
* West2 - prio 1
* West5 - prio 1

## Default values
* Hostname: drtbot
* Username: drt

## Installed os packages
* SSH - enabled
* VNC Server 1920x1080
* RDP Server
* Minicom
* Git
* Git Cola - GIT GUI (https://git-cola.github.io/)
* GitHub CLI
* Thonny (https://thonny.org/)
* Mu Editor (https://codewith.mu/)
* OpenCV for Python3 (https://opencv.org/)
* Numpy for Python3 (https://numpy.org/)
* Matplotlib for Python3 (https://matplotlib.org/)

## Installed python packages
* python_json_config
* pupil-apriltags==1.0.4
  * The current standard numpy version for Raspberry Pi OS is 1.19.5.
  * The latest pupil-apriltags release is depending on functions introduced in numpy 1.20.
  * Based on the release dates of the two libraries, pupil-apriltags 1.0.4 has been selected as the most likely candidate to function with numpy 1.19.5.

## Check installed os and python packages
The image contains files listing which os and python packages are available on the image.
After installation this information is available in directory /var/log/drt-gen.
* apt_auto: OS packages installed because required for manual installed packages without its version.
* apt_manual: OS packages installed manually without its version.
* pip_freeze: Python packages installed by pip, including version.
* pip_list: All python packages, including version.
* pkg_query: All installed os packages including version.

## Check config used for generation
The git status of the configuration used for the image generation can be found in file /var/log/drt-gen/drt-gen_git_status.log.

## DRT environment
* Directory $HOME/log
* Directory $HOME/src
* File $HOME/.drt-env takes care of setting environment variables:
  * PYTHONPATH
  * DrtConfigRoot
  * DrtLogRoot
* At the end of $HOME/.bashrc .drt-env is sourced.
* At the end of $HOME/.profile .drt-env is sourced.

## drt scripts
* ~/bin/rtc : start minicom for communication with the RTC