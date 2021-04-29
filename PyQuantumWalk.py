'''
Cython tutorial - Building a Quantum Walk Simulator

'''

from math import sqrt
import matplotlib.pyplot as plt
import time

H = [[1/sqrt(2),1/sqrt(2)],[1/sqrt(2),-1/sqrt(2)]]


def ApplyCoinOperator(spinStates):

    nSpinStates =  len(spinStates)

    for i in range(nSpinStates):
        for j in range(2):
            for k in range(2):

                spinStates[i][k] += H[j][k]*spinStates[i][k]

    return spinStates

def ApplyShiftOperator(nodeStates, spinStates):
    
    numberOfNodes = len(nodeStates)

    nodeStatesUpdate = numberOfNodes*[0.0]
    spinStatesUpdate = numberOfNodes*[[0.0, 0.0]]

    for i in range(numberOfNodes):

        if spinStates[i][0] != 0:
            if i != 0:
                nodeStatesUpdate[i - 1] += nodeStates[i]
                spinStatesUpdate[i - 1][0] += spinStates[i][0]
            else:
                nodeStatesUpdate[-1] += nodeStates[i]
                spinStatesUpdate[-1][0] += spinStates[i][0]

        if spinStates[i][1] != 0:
            if i != (numberOfNodes - 1):
                nodeStatesUpdate[i + 1] += nodeStates[i]
                spinStatesUpdate[i + 1][1] += spinStates[i][1]
            else:
                nodeStatesUpdate[0] += nodeStates[i]
                spinStatesUpdate[0][1] += spinStates[i][1]

    nodeStates[:] = nodeStatesUpdate
    spinStates[:] = spinStatesUpdate

    return nodeStates, spinStates

def NodeProbabilities(nodeStates):

    numberOfNodes = len(nodeStates)

    probabilities = []

    for i in range(numberOfNodes):

        probabilities.append(abs(nodeStates[i])**2)

    return probabilities

def NormaliseNodeStates(nodeStates):

    numberOfNodes = len(nodeStates)
    probabilities = NodeProbabilities(nodeStates)

    totalProbability = 0

    for i in range(numberOfNodes):
        totalProbability += probabilities[i]

    normalisationFactor = 1/sqrt(totalProbability)

    for i in range(numberOfNodes):
        nodeStates[i] *= normalisationFactor

    return nodeStates


def NormaliseSpinStates(spinStates):
    
    numberOfNodes = len(spinStates)

    totalProbability = 0

    for i in range(numberOfNodes):
        for j in range(2):
            totalProbability += abs(spinStates[i][j])**2

    normalisationFactor = 1/sqrt(totalProbability)

    for i in range(numberOfNodes):
        for j in range(2):
            spinStates[i][j] *= normalisationFactor

    return spinStates

def QuantumWalk(numberOfNodes, startingNode, startingSpin, numberOfSteps):

    nodeStates = numberOfNodes*[0.0]
    nodeStates[startingNode] = 1.0

    spinStates = numberOfNodes*[[0.0, 0.0]]
    spinStates[startingNode] = startingSpin

    for step in range(numberOfSteps):

        spinStates = ApplyCoinOperator(spinStates)

        nodeStates, spinStates = ApplyShiftOperator(nodeStates, spinStates)
        
        nodeStates = NormaliseNodeStates(nodeStates)
        spinStates = NormaliseSpinStates(spinStates)

    return NodeProbabilities(nodeStates)
