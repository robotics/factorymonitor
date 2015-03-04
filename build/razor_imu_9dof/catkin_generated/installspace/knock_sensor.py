#!/usr/bin/env python
import rospy
import math
import numpy as np
from sensor_msgs.msg import Imu
from std_msgs.msg import Float32
import tf
prev_acc = np.array([0,0,0])
pub = rospy.Publisher('/satellite/knock',Float32,queue_size = 1)
threshold = 0.5;
def imu_handle(msg):
    global prev_acc
    global threshold
    acceleration = np.array([msg.linear_acceleration.x,msg.linear_acceleration.y, msg.linear_acceleration.z])
    pubmsg = Float32()
    if np.linalg.norm(acceleration-prev_acc)>threshold:         
        pubmsg.data = 1
    else:
        pubmsg.data = 0

    pub.publish(pubmsg)
    prev_acc = acceleration



def main():
    rospy.init_node('knock_sensor')
    rospy.Subscriber('imu',Imu,imu_handle)
    rospy.spin()

if __name__ == '__main__':
    main()
