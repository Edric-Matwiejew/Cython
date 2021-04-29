import PyQuantumWalk
import CyQuantumWalk
import matplotlib.pyplot as plt
import time

numberOfNodes = 100
startingNode = numberOfNodes//2
startingSpin = [1,0]
numberOfSteps = 700

start = time.time()
nodeProbabilities = PyQuantumWalk.QuantumWalk(numberOfNodes, startingNode, startingSpin, numberOfSteps)
ptime = time.time() - start
print('Time: ', time.time() - start)

start = time.time()
nodeProbabilities = CyQuantumWalk.QuantumWalk(numberOfNodes, startingNode, startingSpin, numberOfSteps)
print('Time: ', ptime/(time.time() - start))


plt.plot(nodeProbabilities)
plt.savefig('quantumWalk')
