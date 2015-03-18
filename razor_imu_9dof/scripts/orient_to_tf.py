#!/usr/bin/env python
import rospy
import math
from sensor_msgs.msg import Imu
import tf
def imu_handle(msg):
    br = tf.TransformBroadcaster()
    br.sendTransform((0,0,0),(msg.orientation.x,msg.orientation.y,msg.orientation.z,msg.orientation.w),rospy.Time.now(),"satellite","world")

def main():
    rospy.init_node('quat_to_tf')
    rospy.Subscriber('imu',Imu,imu_handle)
    rospy.spin()

if __name__ == '__main__':
    main()
