import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d.axes3d import Axes3D, get_test_data
from matplotlib import cm
import numpy as np

def pulse(m, n, tups):
	img = np.zeros(shape=(m,n))
	for t in tups:
		img[t[0]-1][t[1]-1] = 1
	return img

pops = [(10,20),(20,40),(30,60),(40,80),(50,100),(60,80),(70,60),(80,40),(90,20)]
impulseimg = pulse(100, 200, pops)

fig = plt.figure(figsize=plt.figaspect(0.5))

ax = fig.add_subplot(1, 2, 1, projection='3d')

X = np.arange(1,201,1)
Y = np.arange(1,101,1)

X, Y = np.meshgrid(X, Y)

surf = ax.plot_surface(X, Y, impulseimg, rstride=1, cstride=1, cmap=cm.coolwarm, linewidth=0, antialiased=False)

ax.set_zlim(-0.01, 1.01)
fig.colorbar(surf, shrink=0.5, aspect=10)

plt.show()

