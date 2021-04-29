import PyQuantumWalk
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

plt.plot(nodeProbabilities)
plt.savefig('quantumWalk')
