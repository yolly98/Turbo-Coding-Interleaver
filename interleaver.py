from contextlib import nullcontext
import filecmp
import random
import re
from unicodedata import decimal

input = []
output = []
index_v = []


print("______________________________________________")
print("[INPUT]:")

random.seed(8964)


for i in range(0,1024):
    input.append(random.randint(0,1))
    
    

inputFile = open("ModelSim/input.txt","w")
for x in input:
    bit = "{} {}".format(str(x), "\n")
    inputFile.write(bit)
    print(x,end="")

inputFile.close()

print("")
print("______________________________________________")
print("[OUTPUT]")

for i in range (0,1024):
    index = (45 + 3 * i) % 1024
    output.append(input[index])
    index_v.append(index)


outputFile = open("ModelSim/output_py.txt","w")
for x in output:
    bit = "{} {}".format(str(x), "\n")
    outputFile.write(bit)
    print(x,end="")

outputFile.close()

print("")
print("______________________________________________")
print("[INDEX]")

indexFile = open("ModelSim/index_py.txt","w")
i = 0
for x in index_v:
    indexFile.write("input[" + str(x) + "]:" + str(input[x]) + "| output[" + str(i) + "]:" +str(output[i])+ "\n")
    print(x,end=" ")
    i+=1

indexFile.close()

print("")
print("______________________________________________")
print("[REUSLTS]")

print("compere resuts... ")

output_py = open("ModelSim/output_py.txt", "r")
output_vhdl = open("ModelSim/output_vhdl.txt", "r")
error = 0
for i in range(0,1024):
    bit1 = output_py.readline().strip()
    bit2 = output_vhdl.readline().strip()
    
    if(bit1 != bit2):
        print("[line " + str(i) + "] -> (" + bit1 + ", " + bit2 +")")
        error += 1
output_py.close()
output_vhdl.close()

if(error == 0):
    print("[+] 0 errors")
else:
    print("[-] " + str(error) + "errors")

print("________________________________________________")



