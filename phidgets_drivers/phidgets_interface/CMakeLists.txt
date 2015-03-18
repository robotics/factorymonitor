cmake_minimum_required(VERSION 2.8.3)
project(phidgets_interface)

find_package(catkin REQUIRED COMPONENTS nodelet phidgets_api roscpp sensor_msgs std_msgs std_srvs tf message_generation)

add_service_files(
  FILES
  SetOutputState.srv
  )
add_message_files(
  FILES 
  Int16MultiArrayStamped.msg
  Float32Stamped.msg
  )
generate_messages(DEPENDENCIES std_msgs)
catkin_package(
  INCLUDE_DIRS include
  CATKIN_DEPENDS nodelet phidgets_api roscpp sensor_msgs std_msgs std_srvs tf message_runtime
)

include_directories(include ${catkin_INCLUDE_DIRS})

#add_library(phidgets_interface src/interface_ros_i.cpp)

add_executable(phidgets_interface_node src/interface_ros_i.cpp src/phidgets_interface_node.cpp)
add_executable(phidgets_temperature_node src/phidgets_temperature_node.cpp)
add_executable(phidgets_humidity_node src/phidgets_humidity_node.cpp)
add_executable(phidgets_pressure_node src/phidgets_pressure_node.cpp)

#add_dependencies(phidgets_api)
#target_link_libraries(phidgets_interface ${catkin_LIBRARIES})
target_link_libraries(phidgets_interface_node ${catkin_LIBRARIES} phidgets_api)
target_link_libraries(phidgets_temperature_node ${catkin_LIBRARIES} phidgets_api)
target_link_libraries(phidgets_pressure_node ${catkin_LIBRARIES} phidgets_api)
target_link_libraries(phidgets_humidity_node ${catkin_LIBRARIES} phidgets_api)

install(TARGETS phidgets_interface_node
   ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
   LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
   RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

install(DIRECTORY include/${PROJECT_NAME}/
   DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
   FILES_MATCHING PATTERN "*.h"
)
