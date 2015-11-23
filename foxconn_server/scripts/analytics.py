import threading.Lock
class Analytics:
    def __init__(self):
        self.reset()
        self.lock = Lock()
    def acquire(self);
        self.lock.acquire()
    def release(self):
        self.lock.release()

    def reset(self):
        self.lock.acquire()
        self.average = 0
        self.maximum = float("-inf") 
        self.minimum = float("inf") 
        self.variance = self.maximum - self.minimum
        self.count = 0
        self.lock.release()
    def add(self,data):
        self.lock.acquire()
        self.average = (self.count*self.average + data)/(self.count+1)
        self.count+=1
        if data>self.maximum:
            self.maximum = data
        if data<self.minimum:
            self.minimum = data
        self.variance = self.maximum - self.minimum
        self.lock.release()

