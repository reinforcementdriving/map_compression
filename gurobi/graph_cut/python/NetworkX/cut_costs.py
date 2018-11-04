import sys
import time

import matplotlib.pyplot as plt
import networkx as nx
from networkx.algorithms import flow
from networkx.algorithms.flow import shortest_augmenting_path

# init
# 4924 poses in YQ dataset
pathLength = 4924
G = nx.Graph();

for i in range(0, pathLength-1):
	G.add_node(i)

file = open("/home/yinhuan/pose_graph_yq_vis200.txt")

print('file open, adding edges')

for line in file.readlines():
	line.strip('\n')	
	nums = line.split(" ")
	nums = [int(x) for x in nums ]
	G.add_weighted_edges_from([tuple(nums)])

file.close()

print('start eval cut costs')


saveFile = open("/home/yinhuan/cut_costs_yq_vis200.txt", 'w')
setA = []
for i in range(0, pathLength-2):  # the last point is not in
	print i
	setA.append(i)
	# setB is the complement
	cut_value = nx.cut_size(G, setA, weight='weight')
	saveFile.write(str(cut_value) + "\n")

saveFile.close()