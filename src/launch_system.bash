#!/bin/bash
# A simple script

# Configure Hunter SE CAN-to-USB
rosrun hunter_bringup bringup_can2usb.bash

# Start ROS Master
gnome-terminal --command="roscore"

#######################################
# Source workspace & start new terminal
gnome-terminal --command="roslaunch hunter_bringup hunter_robot_base.launch"

#######################################
# Source workspace & start new terminal
gnome-terminal --command="roslaunch learning_joy teleop_joy_cpp.launch"

#######################################
# Start new terminal, source ws, and launch Lord IMU
gnome-terminal --command="roslaunch hunter_bringup hunter_robot_base.launch"

#######################################
# Source workspace & start new terminal
gnome-terminal --command="roslaunch ouster_ros sensor.launch"

#######################################
# Record bag with all desired topic data to the desktop
#gnome-terminal --command="rosbag record -o 
