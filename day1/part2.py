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

total = 0

for element in l1:
    total += element * l2.count(element)

print(total)
