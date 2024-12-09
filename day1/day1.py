#!/usr/bin/env python3

filename = "input.txt"

# Generate 2 lists by the input
l1 = []
l2 = []
with open(filename,'r') as file:
    for line in file:
        value1, value2 = map(int, line.split())
        l1.append(value1)
        l2.append(value2)

#Sorting lists
l1.sort()
l2.sort()

#print de sum of the minor
print(sum([abs(l1[i]-l2[i])for i in range(len(l1))]))
