#!/bin/sh

# launch turtlebot_world.launch to deploy turtlebot environment
xterm -e "cd $(pwd)/../..;
source devel/setup.bash;
export ROBOT_INITIAL_POSE='-x -4 -y 1 -z 0.1 -R 0 -P 0 -Y 1.6';
roslaunch turtlebot_gazebo turtlebot_world.launch  world_file:=$(pwd)/../map/myroboworld.world" & 

sleep 15

# launch amcl_demo.launch for localization
xterm -e "cd $(pwd)/../..;
source devel/setup.bash;
roslaunch turtlebot_gazebo amcl_demo.launch map_file:=$(pwd)/../map/myroboworldmap.yaml initial_pose_x:=1.0 initial_pose_y:=4.0" &

sleep 5

# launch view_navigation for rviz
xterm -e "cd $(pwd)/../..;
source devel/setup.bash;
roslaunch turtlebot_rviz_launchers view_navigation.launch" &

sleep 20 # keeping large to enable visualization

# launch pick_objects node
xterm -e "cd $(pwd)/../..;
source devel/setup.bash;
rosparam load $(pwd)/../config/marker_config.yaml;
rosrun pick_objects pick_objects_test " &
