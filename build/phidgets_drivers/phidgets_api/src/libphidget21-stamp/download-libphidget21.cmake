message(STATUS "downloading...
     src='http://www.phidgets.com/downloads/libraries/libphidget_2.1.8.20130723.tar.gz'
     dst='/home/satellite/factorymonitor/build/phidgets_drivers/phidgets_api/download/libphidget_2.1.8.20130723.tar.gz'
     timeout='none'")




file(DOWNLOAD
  "http://www.phidgets.com/downloads/libraries/libphidget_2.1.8.20130723.tar.gz"
  "/home/satellite/factorymonitor/build/phidgets_drivers/phidgets_api/download/libphidget_2.1.8.20130723.tar.gz"
  SHOW_PROGRESS
  EXPECTED_HASH;MD5=04b4c3a58cf69ecd09431b01471bcd1d
  # no TIMEOUT
  STATUS status
  LOG log)

list(GET status 0 status_code)
list(GET status 1 status_string)

if(NOT status_code EQUAL 0)
  message(FATAL_ERROR "error: downloading 'http://www.phidgets.com/downloads/libraries/libphidget_2.1.8.20130723.tar.gz' failed
  status_code: ${status_code}
  status_string: ${status_string}
  log: ${log}
")
endif()

message(STATUS "downloading... done")
