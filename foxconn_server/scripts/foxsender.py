#!/usr/bin/env python
import rospy
import time
import threading
from std_msgs.msg import *
from sensor_msgs.msg import *
import serial

lock = threading.Lock()
NODE_ID='321'
PORT  = '/dev/radio'
q = {'commotion': 0, 'temperature': 0, 'pressure': 0, 'humidity': 0, 'illuminance': 0, 'knock':0}
class satellite():
    def __init__(self, num):
        self.i = num
        self.subscribe()
    def subscribe(self):
        rospy.loginfo("Subscribing to topics")
        rospy.Subscriber("/satellite"+str(self.i)+"/temperature", Temperature, self.temperature_callback)
        rospy.Subscriber("/satellite"+str(self.i)+"/pressure", FluidPressure, self.pressure_callback)
        rospy.Subscriber("/satellite"+str(self.i)+"/humidity", RelativeHumidity, self.humidity_callback)
        rospy.Subscriber("/satellite"+str(self.i)+"/illuminance", Illuminance, self.illuminance_callback)
        rospy.Subscriber("/satellite"+str(self.i)+"/commotion", Int64, self.commotion_callback)

    def temperature_callback(self,data):
        lock.acquire()
        q['temperature'] = data.temperature
        lock.release()
    def pressure_callback(self, data):
        lock.acquire()
        q['pressure'] = data.fluid_pressure
        lock.release()
    def humidity_callback(self, data):
        lock.acquire()
        q['humidity'] = data.relative_humidity
        lock.release()
    def illuminance_callback(self, data):
        lock.acquire()
        q['illuminance'] = data.illuminance
        lock.release()
    def commotion_callback(self, data):
        lock.acquire()
        q['commotion'] = data.data
        lock.release()
    def knock_callback(self, data):
        lock.acquire()
        q['knock'] = data.data
        lock.release()

def main():
  rospy.init_node('foxsender', anonymous=True)
  rospy.loginfo("Starting application")
  rate_object = rospy.Rate(1)
  sat = satellite(1)
  radio = serial.Serial(PORT, baudrate=9600)
  while not rospy.is_shutdown():
    lock.acquire()
    r = q
    lock.release()

    checksum = r['commotion'] + r['temperature'] + r['pressure'] + r['humidity'] + r['illuminance'] + r['knock']
    msg = '<B,' + NODE_ID + ','
    msg = msg + str(r['commotion'])    + ','
    msg = msg + str(r['temperature'])  + ','
    msg = msg + str(r['pressure'])     + ','
    msg = msg + str(r['humidity'])     + ','
    msg = msg + str(r['illuminance'])  + ','
    msg = msg + str(r['knock'])        + ','
    msg = msg + str(checksum)         + '>\r\n'

    radio.write(msg)
    rate_object.sleep()




if __name__ == '__main__':
  main()



