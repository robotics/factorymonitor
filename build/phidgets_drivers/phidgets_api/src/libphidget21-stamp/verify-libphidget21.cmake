set(file "/home/satellite/factorymonitor/build/phidgets_drivers/phidgets_api/download/libphidget_2.1.8.20130723.tar.gz")
message(STATUS "verifying file...
     file='${file}'")
set(expect_value "04b4c3a58cf69ecd09431b01471bcd1d")
file(MD5 "${file}" actual_value)
if("${actual_value}" STREQUAL "${expect_value}")
  message(STATUS "verifying file... done")
else()
  message(FATAL_ERROR "error: MD5 hash of
  ${file}
does not match expected value
  expected: ${expect_value}
    actual: ${actual_value}
")
endif()
