#!/usr/bin/env python
import socket, select
import sys
import rospy
import time
from thread import *
import threading
from Queue import Queue 
from std_msgs.msg import *
from sensor_msgs.msg import *

#Socket Specific globals
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
HOST = ''   # Symbolic name meaning all available interfaces
PORT = 8888 # Arbitrary non-privileged port
q = Queue()
lock = threading.Lock()

#scheduler specific globals

def logger():
    print "help"
class satellite():
    def __init__(self, num):
        self.i = num
        self.subscribe()
    def subscribe(self):
        rospy.Subscriber("/satellite"+str(self.i)+"/temperature", Temperature, self.temperature_callback)
        rospy.Subscriber("/satellite"+str(self.i)+"/pressure", FluidPressure, self.pressure_callback)
        rospy.Subscriber("/satellite"+str(self.i)+"/humidity", RelativeHumidity, self.humidity_callback)
        rospy.Subscriber("/satellite"+str(self.i)+"/illuminance", Illuminance, self.illuminance_callback)
        rospy.Subscriber("/satellite"+str(self.i)+"/commotion", Int64, self.commotion_callback)

    def temperature_callback(self,data):
        msg = str(int(time.time())) + "\t" + "temperature"+str(self.i) + "\t" + str(data.temperature) + '\n'
        lock.acquire()
        q.put(msg)
        lock.release()
    def pressure_callback(self, data):
        msg = str(int(time.time())) + "\t" + "pressure"+str(self.i) + "\t" + str(data.fluid_pressure) + '\n'
        lock.acquire()
        q.put(msg)
        lock.release()
    def humidity_callback(self, data):
        msg = str(int(time.time())) + "\t" + "humidity"+str(self.i) + "\t" + str(data.relative_humidity) + '\n'
        lock.acquire()
        q.put(msg)
        lock.release()
    def illuminance_callback(self, data):
        msg = str(int(time.time())) + "\t" + "illuminance"+str(self.i) + "\t" + str(data.illuminance) + '\n'
        lock.acquire()
        q.put(msg)
        lock.release()
    def commotion_callback(self, data):
        msg = str(int(time.time())) + "\t" + "commotion"+str(self.i) + "\t" + str(data.data) + '\n'
        lock.acquire()
        q.put(msg)
        lock.release()
    def knock_callback(self, data):
        msg = str(int(time.time())) + "\t" + "knock"+str(self.i) + "\t" + str(data.data) + '\n'
        lock.acquire()
        q.put(msg)
        lock.release()


def main():
    """docstring for main"""
    rospy.init_node('foxserver',anonymous=True)
    server.bind((HOST,PORT))
    server.listen(5)
    r = rospy.Rate(10)
    inputs = [ server ]
    outputs = []
    s1 = satellite(1)
    s2 = satellite(2)
    s3 = satellite(3)
    s4 = satellite(4)
    s5 = satellite(5)
#Subscribers:
    while not rospy.is_shutdown():
      try:
        readable,writable,exceptional = select.select(inputs,outputs,inputs,0.1)
        for s in readable:
            if s is server:
                connection, client_address = s.accept()
                print >>sys.stderr, 'new connection from', client_address
                connection.setblocking(0)
                inputs.append(connection)
                outputs.append(connection)
            else:
                try:
                    data = s.recv(2048)
                except:
                    rospy.logerr("Data Recv Problem")
                if data:
                    print data
                else:
                    print >>sys.stderr, 'closing', client_address, 'after reading no data'
                    if s in outputs:
                        outputs.remove(s)
                        inputs.remove(s)
                    s.close()
	if not q.empty():
	    lock.acquire()
	    msg = q.get()
	    lock.release()
	    with open("/home/satellite/data.log", "a") as myfile:
		myfile.write(msg)
	    for s in writable:
	        try:
	    	    s.send(msg)
		except:
		    print "Exception"
		
        for s in exceptional:
            print >>sys.stderr, 'handling exceptional condition for', s.getpeername()
            # Stop listening for input on the connection
            inputs.remove(s)
            if s in outputs:
                outputs.remove(s)
            s.close()
      except KeyboardInterrupt:
	break
    server.close()


if __name__ == '__main__':
    main()
