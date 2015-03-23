#!/usr/bin/env python

import serial
# import rospy
# from sensor_msgs.msg import IMU
def main():
    s = serial.Serial("/dev/ttyUSB0",baudrate=9600)
    # imu_pub = rospy.Publisher('acc_node/imu',IMU,queue_size=10)
    # rospy.init_node('acc_node',anonymous=True)
    # rospy.loginfo("Accelerometer node started")

    while True:
        data = s.readline()
        # rospy.loginfo(data) 
        print data
if __name__ == '__main__':
    # try:
        main()
    # except rospy.ROSInterruptException:
        # pass
