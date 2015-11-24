#!/usr/bin/env python
import socket, select
import sys
import rospy
import time
from thread import *
import threading
from Queue import Queue 
from std_msgs.msg import Int32
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

def temperature_callback(data):
    msg = str(int(time.time())) + "\t" + "temperature1" + "\t" + str(data.temperature) + '\n'
    lock.acquire()
    q.put(msg)
    lock.release()
def pressure_callback(data):
    msg = str(int(time.time())) + "\t" + "pressure1" + "\t" + str(data.fluid_pressure) + '\n'
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
#Subscribers:
    rospy.Subscriber("temperature_throttled", Temperature, temperature_callback)
    rospy.Subscriber("pressure_throttled", FluidPressure, pressure_callback)
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
                data = s.recv(1024)
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
	    with open("data.log", "a") as myfile:
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
