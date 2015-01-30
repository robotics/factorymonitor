import numpy as N
import wave

class SoundFile:
  def  __init__(self, signal):
    self.file = wave.open('test.wav', 'wb')
    self.signal = signal
    self.sr = 192000

  def write(self):
    self.file.setparams((1, 2, self.sr, 192000*4, 'NONE', 'noncompressed'))
    self.file.writeframes(self.signal)
    self.file.close()

# let's prepare signal
duration = 4 # seconds
samplerate = 192000 # Hz
samples = duration*samplerate
frequency = 38000 # Hz
period = samplerate / float(frequency) # in sample points
omega = N.pi * 2 / period

xaxis = N.arange(int(period),dtype = N.float) * omega
ydata = 16384 * N.sin(xaxis)

signal = N.resize(ydata, (samples,))

ssignal = ''
for i in range(len(signal)):
  ssignal += wave.struct.pack('h',signal[i]) # transform to binary
f = SoundFile(ssignal)
f.write()
print 'file written'
