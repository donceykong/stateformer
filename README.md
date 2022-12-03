# StateFormer Packages

## First to allow for wireless Xbox connectivity:
>> sudo apt install sysfsutils
>> sudo nano /etc/sysfs.conf
place the following at the end of the file. "/module/bluetooth/parameters/disable_ertm=1"

Now you should be able to open bluetooth and connect to Xbox One controller.

If above does not work, try XPAD NEO.

## Install ROS Joy for comminicating with Xbox One controller

## Hunter SE ROS 
### Install Dependencies
>> sudo apt-get install build-essential git cmake libasio-dev

### Enable gs_usb kernel module 
>> sudo modprobe gs_usb


## Build workspace
>> cd ~/<your_ws>
>> catkin_make
>> source devel/setup.bash

## Allow for USB-CAN Communication
### First time comminucating with Hunter SE
>> rosrun hunter_bringup setup_can2usb.bash

### After first time communicating with Hunter SE
>> rosrun hunter_bringup bringup_can2usb.bash

### Install and use can-utils to test the hardware 
>> sudo apt install can-utils

### Testing command: receiving data from can0
>> candump can0

### Testing command: send data to can0
cansend can0 001#1122334455667788

## Start Robot
### Start a ROS MASTER 
>> roscore

Now open a new terminal
>> cd ~/<your_ws>
>> source devel/setup.bash

### Start Base Node for real robot
>> roslaunch hunter_bringup hunter_robot_base.launch

Now open a new terminal
>> cd ~/<your_ws>
>> source devel/setup.bash

Now open a new terminal
>> cd ~/<your_ws>
>> source devel/setup.bash

### Start Xbox One control node (Assuming your Xbox controller is still connected via Bluetooth)
>> roslaunch learning_joy teleop_joy_cpp.launch 
