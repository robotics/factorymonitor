#!/usr/bin/env python

import serial
import rospy
from sensor_msgs.msg import Temperature,FluidPressure,RelativeHumidity,Illuminance
temp1 = 0;
temp2 = 0;
pressure = 0;
humidity = 0;
light = 0;
def main():
    s = serial.Serial("/dev/launchpad",baudrate=115200,timeout=1)
    temperature_pub = rospy.Publisher('temperature',Temperature,queue_size=10)
    humidity_pub = rospy.Publisher('humidity',RelativeHumidity,queue_size=10)
    pressure_pub = rospy.Publisher('pressure',FluidPressure,queue_size=10)
    light_pub = rospy.Publisher('illuminance',Illuminance,queue_size=10)
    rospy.init_node('sensor_hub',anonymous=True)
    rospy.loginfo("Sensor Hub node started")
    s.write('b')

    while not rospy.is_shutdown():
        msg = s.readline()
	data = msg.split()
        if not data:
            rospy.logerr("No Data Received")
            rospy.signal_shutdown("No data Received")
        t = rospy.Time.now()
        try:
            temp1 = float(data[1])
            pressure = float(data[2])
            temp2 = float(data[4])
            humidity = float(data[5])
            light = float(data[7])
            msg = FluidPressure()
            msg.header.stamp = t
            msg.fluid_pressure = pressure
            msg.variance = 0
            pressure_pub.publish(msg)
            msg = Temperature()
            msg.header.stamp = t
            msg.temperature = temp2
            msg.variance = 0
            temperature_pub.publish(msg)
            msg = RelativeHumidity()
            msg.header.stamp = t
            msg.relative_humidity = humidity
            msg.variance = 0
            humidity_pub.publish(msg)
            msg = Illuminance()
            msg.header.stamp = t
            msg.illuminance = light
            msg.variance = 0
            light_pub.publish(msg)
        except rospy.ROSInterruptException:
            raise
        except:
            s.write('s')
            pass
if __name__ == '__main__':
    try:
        main()
    except rospy.ROSInterruptException:
        pass
