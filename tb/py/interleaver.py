from contextlib import nullcontext
import filecmp
import random
from unicodedata import decimal

input = []
output = []
index_v = []


print("______________________________________________")
print("[INPUT]:")

random.seed(14546744)


for i in range(0,1024):
    input.append(random.randint(0,1))
    
    

inputFile = open("input.txt","w")
for x in input:
    inputFile.write(str(x) + " \n")
    print(x,end="")

inputFile.close()

print("")
print("______________________________________________")
print("[OUTPUT]")

for i in range (0,1024):
    index = (45 + 3 * i) % 1024
    output.append(input[index])
    index_v.append(index)


outputFile = open("output_py.txt","w")
for x in output:
    outputFile.write(str(x) + " \n")
    print(x,end="")

outputFile.close()

print("")
print("______________________________________________")
print("[INDEX]")

indexFile = open("index_py.txt","w")
i = 0
for x in index_v:
    indexFile.write("input[" + str(x) + "]:" + str(input[x]) + "| output[" + str(i) + "]:" +str(output[i])+ "\n")
    print(x,end=" ")
    i+=1

indexFile.close()

print("")
print("______________________________________________")

print("compere resuts: ", end="")
print(filecmp.cmp('output_py.txt', '../../ModelSim/output_vhdl.txt'))

