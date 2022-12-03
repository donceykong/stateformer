# StateFormer Packages

- ## First to allow for wireless Xbox connectivity:
    - 1) >> sudo apt install sysfsutils
    - 2) >> sudo nano /etc/sysfs.conf
    - 3) place the following at the end of the file. "/module/bluetooth/parameters/disable_ertm=1"

Now you should be able to open bluetooth and connect to Xbox One controller.

If above does not work, try XPAD NEO.

## Install ROS Joy for comminicating with Xbox One controller

## Hunter SE ROS 
### Install Dependencies
- >> sudo apt-get install build-essential git cmake libasio-dev

### Enable gs_usb kernel module 
- >> sudo modprobe gs_usb


## Build and source your ROS workspace
- >> cd ~/<your_ws>
- >> catkin_make
- >> source devel/setup.bash

## Allow for USB-CAN Communication
1) ### First time comminucating with Hunter SE
- >> rosrun hunter_bringup setup_can2usb.bash

2) ### After first time communicating with Hunter SE
- >> rosrun hunter_bringup bringup_can2usb.bash

3) ### Install and use can-utils to test the hardware 
- >> sudo apt install can-utils

4) ### Testing command: receiving data from can0
- >> candump can0

5) ### Testing command: send data to can0
cansend can0 001#1122334455667788

## Start Robot
1) ### Start a ROS MASTER 
- >> roscore

Now open a new terminal
- >> cd ~/<your_ws>
- >> source devel/setup.bash

2) ### Start Base Node for real robot
- >> roslaunch hunter_bringup hunter_robot_base.launch

Now open a new terminal
- >> cd ~/<your_ws>
- >> source devel/setup.bash

3) ### Start Xbox One control node (Assuming your Xbox controller is still connected via Bluetooth)
- >> roslaunch learning_joy teleop_joy_cpp.launch

## Set up LORD IMU
1) ### Install driver for ROS
- >> sudo apt-get install ros-ROS_noetic-microstrain-inertial-driver

2) ### Install RQT for LORD IMU
- >> sudo apt-get install ros-ROS_noetic-microstrain-inertial-rqt

3) ### Run the IMU node:
- >> roslaunch microstrain_inertial_driver microstrain.launch

4) ### Read IMU values:
- >> rostopic echo /imu/data

## Setup Ouster LiDAR
1) ### Install dependencies
- >> sudo apt install -y                  \
    ros-noetic-pcl-ros             \
    ros-noetic-rviz                \
    ros-noetic-tf2-geometry-msgs

2) ### Install additional dependencies:
- >> sudo apt install -y \
    build-essential \
    libeigen3-dev   \
    libjsoncpp-dev  \
    libspdlog-dev   \
    cmake

4) ### Install Package:
- >> cd ~/<your_ws>/src
- >> git clone --recurse-submodules https://github.com/ouster-lidar/ouster-ros.git

5) ### Compile the driver:
- >> cd ~/<your_ws>
- >> catkin_make --cmake-args -DCMAKE_BUILD_TYPE=Release -DBoost_LIBRARY_DIR_RELEASE=/usr/lib/x86_64-linux-gnu

6) ### Use in sensor mode:
- >> roslaunch ouster_ros sensor.launch      \
    sensor_hostname:=<sensor host name>    \
    metadata:=<json file name>             # metadata is optional

7) ### Use in replay mode:
- >> roslaunch ouster_ros replay.launch      \
    metadata:=<json file name>          \
    bag_file:=<path to rosbag file>


