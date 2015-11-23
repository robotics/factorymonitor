#!/usr/bin/env python
import socket, select
import sys
import rospy
import time
from thread import *
import threading
from Queue import Queue 
from std_msgs.msg import Int32

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
    msg = str(int(time.time())) + " " + "temperature" + str(data.data) + '\n'
    lock.acquire()
    q.put(msg)
    lock.release()


def main():
    """docstring for main"""
    rospy.init_node('foxserver',anonymous=True)
    server.bind((HOST,PORT))
    server.listen(5)
    rate = rospy.Rate(1)
    inputs = [ server ]
    outputs = []
#Subscribers:
    rospy.Subscriber("temperature_throttled", Int32, temperature_callback)
    while not rospy.is_shutdown():
        readable,writable,exceptional = select.select(inputs,outputs,inputs)
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
        for s in writable:
            try:
                lock.acquire()
                s.sendall(q.get())
                lock.release()
            except:
                pass
        for s in exceptional:
            print >>sys.stderr, 'handling exceptional condition for', s.getpeername()
            # Stop listening for input on the connection
            inputs.remove(s)
            if s in outputs:
                outputs.remove(s)
            s.close()
        rate.sleep()
    server.close()


if __name__ == '__main__':
    main()
