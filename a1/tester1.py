import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d.axes3d import Axes3D, get_test_data
from matplotlib import cm
import numpy as np

fig = plt.figure(figsize=plt.figaspect(0.5))

ax = fig.add_subplot(1, 2, 1, projection='3d')

X = np.arange(1,201,1) # 3
Y = np.arange(1,101,1) # 2

X, Y = np.meshgrid(X, Y)

z = np.zeros(shape=(100,200))
z[9][19] = 1
z[19][39] = 1
z[29][59] = 1
z[39][79] = 1
z[49][99] = 1
z[59][79] = 1
z[69][59] = 1
z[79][39] = 1
z[89][19] = 1

surf = ax.plot_surface(X, Y, z, rstride=1, cstride=1, cmap=cm.coolwarm, linewidth=0, antialiased=False)

ax.set_zlim(-0.01, 1.01)
fig.colorbar(surf, shrink=0.5, aspect=10)

plt.show()

