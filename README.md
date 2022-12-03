# StateFormer Data Collection

This repository contains the ROS (noetic) packages used to gather data from the HunterSE vehicle (Frank) for StateFormer research.

## Below Details all instructions for using the needed packages for the StateFormer research:

- ## First to allow for wireless Xbox connectivity:
    - 1) >> sudo apt install sysfsutils
    - 2) >> sudo nano /etc/sysfs.conf
    - 3) place the following at the end of the file. "/module/bluetooth/parameters/disable_ertm=1"

    Now you should be able to open bluetooth and connect to Xbox One controller.

    If above does not work, try XPAD NEO.

- ## Install ROS Joy for comminicating with Xbox One controller

- ## Add the files from src/ directory in this repository to src in your workspace. Remove the empty directories, as they will be sourced from further instructions below.

- ## Hunter SE ROS 
    - ### Install Dependencies
        - >> sudo apt-get install build-essential git cmake libasio-dev

    - ### Enable gs_usb kernel module 
        - >> sudo modprobe gs_usb


    - ### Build and source your ROS workspace
        - >> cd ~/<your_ws>
        - >> catkin_make
        - >> source devel/setup.bash

- ## Allow for USB-CAN Communication
    - ### First time comminucating with Hunter SE
        - >> rosrun hunter_bringup setup_can2usb.bash

    - ### After first time communicating with Hunter SE
        - >> rosrun hunter_bringup bringup_can2usb.bash

    - ### Install and use can-utils to test the hardware 
        - >> sudo apt install can-utils

    - ### Testing command: receiving data from can0
        - >> candump can0

    - ### Testing command: send data to can0
        - >> cansend can0 001#1122334455667788

- ## Start Robot
    - ### Start a ROS MASTER 
        - >> roscore

    Now open a new terminal
        - >> cd ~/<your_ws>
        - >> source devel/setup.bash

    - ### Start Base Node for real robot
        - >> roslaunch hunter_bringup hunter_robot_base.launch

    Now open a new terminal
        - >> cd ~/<your_ws>
        - >> source devel/setup.bash

    - ### Start Xbox One control node (Assuming your Xbox controller is still connected via Bluetooth)
        - >> roslaunch learning_joy teleop_joy_cpp.launch

- ## Set up LORD IMU
    - ### Install driver for ROS
        - >> sudo apt-get install ros-ROS_noetic-microstrain-inertial-driver

    - ### Install RQT for LORD IMU
        - >> sudo apt-get install ros-ROS_noetic-microstrain-inertial-rqt

    - ### Run the IMU node:
        - >> roslaunch microstrain_inertial_driver microstrain.launch

    - ### Read IMU values:
        - >> rostopic echo /imu/data

- ## Setup Ouster LiDAR
    - ### Install dependencies
        - >> sudo apt install -y            \
             ros-noetic-pcl-ros             \
             ros-noetic-rviz                \
             ros-noetic-tf2-geometry-msgs

    - ### Install additional dependencies:
        - >> sudo apt install -y \
             build-essential \
             libeigen3-dev   \
             libjsoncpp-dev  \
             libspdlog-dev   \
             cmake

    - ### Install Package:
        - >> cd ~/<your_ws>/src
        - >> git clone --recurse-submodules https://github.com/ouster-lidar/ouster-ros.git

    - ### Compile the driver:
        - >> cd ~/<your_ws>
        - >> catkin_make --cmake-args -DCMAKE_BUILD_TYPE=Release -DBoost_LIBRARY_DIR_RELEASE=/usr/lib/x86_64-linux-gnu

    - ### Use in sensor mode:
        - >> roslaunch ouster_ros sensor.launch      \
             sensor_hostname:=<sensor host name>    \
             metadata:=<json file name>             # metadata is optional

    - ### Use in replay mode:
        - >> roslaunch ouster_ros replay.launch      \
             metadata:=<json file name>          \
             bag_file:=<path to rosbag file>


