# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "phidgets_interface: 2 messages, 1 services")

set(MSG_I_FLAGS "-Iphidgets_interface:/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/msg;-Istd_msgs:/opt/ros/indigo/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(phidgets_interface_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/msg/Int16MultiArrayStamped.msg" NAME_WE)
add_custom_target(_phidgets_interface_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "phidgets_interface" "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/msg/Int16MultiArrayStamped.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/srv/SetOutputState.srv" NAME_WE)
add_custom_target(_phidgets_interface_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "phidgets_interface" "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/srv/SetOutputState.srv" ""
)

get_filename_component(_filename "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/msg/Float32Stamped.msg" NAME_WE)
add_custom_target(_phidgets_interface_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "phidgets_interface" "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/msg/Float32Stamped.msg" "std_msgs/Header"
)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(phidgets_interface
  "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/msg/Int16MultiArrayStamped.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/phidgets_interface
)
_generate_msg_cpp(phidgets_interface
  "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/msg/Float32Stamped.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/phidgets_interface
)

### Generating Services
_generate_srv_cpp(phidgets_interface
  "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/srv/SetOutputState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/phidgets_interface
)

### Generating Module File
_generate_module_cpp(phidgets_interface
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/phidgets_interface
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(phidgets_interface_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(phidgets_interface_generate_messages phidgets_interface_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/msg/Int16MultiArrayStamped.msg" NAME_WE)
add_dependencies(phidgets_interface_generate_messages_cpp _phidgets_interface_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/srv/SetOutputState.srv" NAME_WE)
add_dependencies(phidgets_interface_generate_messages_cpp _phidgets_interface_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/msg/Float32Stamped.msg" NAME_WE)
add_dependencies(phidgets_interface_generate_messages_cpp _phidgets_interface_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(phidgets_interface_gencpp)
add_dependencies(phidgets_interface_gencpp phidgets_interface_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS phidgets_interface_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(phidgets_interface
  "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/msg/Int16MultiArrayStamped.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/phidgets_interface
)
_generate_msg_lisp(phidgets_interface
  "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/msg/Float32Stamped.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/phidgets_interface
)

### Generating Services
_generate_srv_lisp(phidgets_interface
  "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/srv/SetOutputState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/phidgets_interface
)

### Generating Module File
_generate_module_lisp(phidgets_interface
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/phidgets_interface
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(phidgets_interface_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(phidgets_interface_generate_messages phidgets_interface_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/msg/Int16MultiArrayStamped.msg" NAME_WE)
add_dependencies(phidgets_interface_generate_messages_lisp _phidgets_interface_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/srv/SetOutputState.srv" NAME_WE)
add_dependencies(phidgets_interface_generate_messages_lisp _phidgets_interface_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/msg/Float32Stamped.msg" NAME_WE)
add_dependencies(phidgets_interface_generate_messages_lisp _phidgets_interface_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(phidgets_interface_genlisp)
add_dependencies(phidgets_interface_genlisp phidgets_interface_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS phidgets_interface_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(phidgets_interface
  "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/msg/Int16MultiArrayStamped.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/phidgets_interface
)
_generate_msg_py(phidgets_interface
  "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/msg/Float32Stamped.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/phidgets_interface
)

### Generating Services
_generate_srv_py(phidgets_interface
  "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/srv/SetOutputState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/phidgets_interface
)

### Generating Module File
_generate_module_py(phidgets_interface
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/phidgets_interface
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(phidgets_interface_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(phidgets_interface_generate_messages phidgets_interface_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/msg/Int16MultiArrayStamped.msg" NAME_WE)
add_dependencies(phidgets_interface_generate_messages_py _phidgets_interface_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/srv/SetOutputState.srv" NAME_WE)
add_dependencies(phidgets_interface_generate_messages_py _phidgets_interface_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/satellite/factorymonitor/src/phidgets_drivers/phidgets_interface/msg/Float32Stamped.msg" NAME_WE)
add_dependencies(phidgets_interface_generate_messages_py _phidgets_interface_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(phidgets_interface_genpy)
add_dependencies(phidgets_interface_genpy phidgets_interface_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS phidgets_interface_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/phidgets_interface)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/phidgets_interface
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(phidgets_interface_generate_messages_cpp std_msgs_generate_messages_cpp)

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/phidgets_interface)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/phidgets_interface
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(phidgets_interface_generate_messages_lisp std_msgs_generate_messages_lisp)

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/phidgets_interface)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/phidgets_interface\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/phidgets_interface
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(phidgets_interface_generate_messages_py std_msgs_generate_messages_py)
