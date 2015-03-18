cmake_minimum_required(VERSION 2.8.3)
project(razor_imu_9dof)

find_package(catkin REQUIRED dynamic_reconfigure)

catkin_package(CATKIN_DEPENDS dynamic_reconfigure)


install(DIRECTORY launch
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

install(DIRECTORY src
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

install(DIRECTORY magnetometer_calibration
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

catkin_install_python(PROGRAMS 
	scripts/node.py
	scripts/display_3D_visualization.py
	scripts/orient_to_tf.py
	scripts/knock_sensor.py
        DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/scripts
)

generate_dynamic_reconfigure_options(
  cfg/razor.cfg
)
