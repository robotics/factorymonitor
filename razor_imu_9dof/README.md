Official ROS Documentation
--------------------------
A much more extensive and standard ROS-style version of this documentation can be found on the ROS wiki at:

http://wiki.ros.org/razor_imu_9dof


Install and Configure ROS Package
---------------------------------
1) Install dependencies:

	$ sudo apt-get install python-visual

2) Download code:

	$ cd ~/catkin_workspace/src
	$ git clone https://github.com/KristofRobot/razor_imu_9dof.git
	$ cd ..
	$ catkin_make


Install Arduino firmware
-------------------------
1) Open ``src/Razor_AHRS/Razor_AHRS.ino`` in Arduino IDE. Note: this is a modified version
of Peter Bartz' original Arduino code (see https://github.com/ptrbrtz/razor-9dof-ahrs). 
Use this version - it emits linear acceleration and angular velocity data required by the ROS Imu message

2) Select your hardware here by uncommenting the right line in ``src/Razor_AHRS/Razor_AHRS.ino``, e.g.

<pre>
// HARDWARE OPTIONS
/*****************************************************************/
// Select your hardware here by uncommenting one line!
//#define HW__VERSION_CODE 10125 // SparkFun "9DOF Razor IMU" version "SEN-10125" (HMC5843 magnetometer)
//#define HW__VERSION_CODE 10736 // SparkFun "9DOF Razor IMU" version "SEN-10736" (HMC5883L magnetometer)
//#define HW__VERSION_CODE 10183 // SparkFun "9DOF Sensor Stick" version "SEN-10183" (HMC5843 magnetometer)
//#define HW__VERSION_CODE 10321 // SparkFun "9DOF Sensor Stick" version "SEN-10321" (HMC5843 magnetometer)
#define HW__VERSION_CODE 10724 // SparkFun "9DOF Sensor Stick" version "SEN-10724" (HMC5883L magnetometer)
</pre>

3) Upload Arduino sketch to the Sparkfun 9DOF Razor IMU board


Launch
------
Publisher and 3D visualization:
	
	$ roslaunch razor_imu_9dof razor-pub-and-display.launch device_port:=/dev/ttyUSB0

Publisher only:
	
	$ roslaunch razor_imu_9dof razor-pub.launch device_port:=/dev/ttyUSB0

3D visualization only:
	
	$ roslaunch razor_imu_9dof razor-display.launch


Calibrate
---------
For best accuracy, follow the tutorial to calibrate the sensors:

http://wiki.ros.org/razor_imu_9dof

A copy of Peter Bartz's magnetometer calibration scripts from https://github.com/ptrbrtz/razor-9dof-ahrs is provided in the ``magnetometer_calibration`` directory.
