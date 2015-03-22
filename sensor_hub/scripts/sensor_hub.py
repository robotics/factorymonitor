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
    s = serial.Serial("/dev/ttyACM0",baudrate=115200)
    temperature_pub = rospy.Publisher('temperature',Temperature,queue_size=10)
    humidity_pub = rospy.Publisher('humidity',RelativeHumidity,queue_size=10)
    pressure_pub = rospy.Publisher('pressure',FluidPressure,queue_size=10)
    light_pub = rospy.Publisher('illuminance',Illuminance,queue_size=10)
    rospy.init_node('sensor_hub',anonymous=True)
    rospy.loginfo("Sensor Hub node started")

    while not rospy.is_shutdown():
        data = s.readline()
        t = rospy.Time.now()
        try:
            temp1 = float(data[2:7])
            pressure = float(data[8:14])
            msg = FluidPressure()
            msg.header.stamp = t
            msg.fluid_pressure = pressure
            msg.variance = 0
            pressure_pub.publish(msg)
            temp2 = float(data[16:22])
            msg = Temperature()
            msg.header.stamp = t
            msg.temperature = temp2
            msg.variance = 0
            temperature_pub.publish(msg)
            humidity = float(data[23:28])
            msg = RelativeHumidity()
            msg.header.stamp = t
            msg.relative_humidity = humidity
            msg.variance = 0
            humidity_pub.publish(msg)
            light = float(data[30:-1])
            msg = Illuminance()
            msg.header.stamp = t
            msg.illuminance = light
            msg.variance = 0
            light_pub.publish(msg)
        except rospy.ROSInterruptException:
            raise
        except:
            pass
if __name__ == '__main__':
    try:
        main()
    except rospy.ROSInterruptException:
        pass
