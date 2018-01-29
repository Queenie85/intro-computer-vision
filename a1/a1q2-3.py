import numpy as np

a = np.matrix('10 40 8; 5 3 5; 12 5 2')
b = np.matrix('6 3 6; 2 1 2; 6 3 6')

U1, s1, V1 = np.linalg.svd(a, full_matrices=True)
U2, s2, V2 = np.linalg.svd(b, full_matrices=True)

print(s1)
print(s2)



