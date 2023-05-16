import imageio
from ipywidgets import widgets
import numpy as np
import matplotlib.pyplot as plt
plt.style.use('fivethirtyeight')

reader = imageio.get_reader('*Insert Video File Name*.mp4', format='mp4')

%matplotlib notebook

def onclick(event):
'''Capture the x,y coordinates of a mouse click on the image'''
ix, iy = event.xdata, event.ydata
baseline.append([ix, iy])

image = reader.get_data(1)
fig = plt.figure()
plt.imshow(image, interpolation='nearest')
baseline = []
connectId = fig.canvas.mpl_connect('button_press_event', onclick)

x_lines = np.array(baseline)[:,0]
gap_lines = x_lines[1:] - x_lines[0:-1]

def onclick2(event):
'''Capture the x,y coordinates of a mouse click on the image'''
ix, iy = event.xdata, event.ydata
coords.append([ix, iy])

selector = widgets.BoundedIntText(value=510, min=510, max=560, step=1,
description='Frame:',
disabled=False)
coords = []
def catchclick(frame):
image = reader.get_data(frame)
plt.imshow(image, interpolation='nearest');
fig = plt.figure()
connectId = fig.canvas.mpl_connect('button_press_event',onclick2)
widgets.interact(catchclick, frame=selector);

y = np.array(coords)[:,1] * (*Insert Reference Distance*)  / gap_lines.mean()

fps = reader.get_meta_data()['fps']
time = np.array(range(*Insert Number of Frames Per Cycle*)) / fps

fig = plt.figure()
plt.scatter(time,-y)
z = np.polyfit(time,-y,10)
p = np.poly1d(z)
plt.plot(time,p(x))
plt.xlabel('Time (s)')
plt.ylabel('Vertical Displacement (mm)')
plt.title('*Insert Iteration Name*')
