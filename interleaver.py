from contextlib import nullcontext
import filecmp
import random
import re
from unicodedata import decimal

input_vector = []
output_vector = []
index_v = []
seeds = []
TX_CYCLES = 4

print("______________________________________________")
print("[SEEDS]]:")

random.seed(8964)


for i in range(0,TX_CYCLES):
    seeds.append(random.randint(0,1000))
    print(seeds[i])



print("______________________________________________")
print("[INPUTS]")

for s in range(0,TX_CYCLES) :

    print(f"----- INPUT {s} -----")
    input = []
    random.seed(s)
    for i in range(0,1024):
        input.append(random.randint(0,1))
        
    inputFile = open(f"ModelSim/input{s}.txt","w")
    for x in input:
        bit = "{} {}".format(str(x), "\n") 
        inputFile.write(bit)
        print(x,end="")

    inputFile.close()

    input_vector.append(input)

    print("")
print("______________________________________________")
print("[OUTPUT]")


for s in range(0, TX_CYCLES):

    print(f"----- OUTPUT {s} -----")
    input = input_vector[s]
    output = []
    for i in range (0,1024):
        index = (45 + 3 * i) % 1024
        output.append(input[index])
        index_v.append(index)


    outputFile = open(f"ModelSim/output_py{s}.txt","w")
    for x in output:
        bit = "{} {}".format(str(x), "\n")
        outputFile.write(bit)
        print(x,end="")

    outputFile.close()

    output_vector.append(output)

    print("")

print("______________________________________________")
print("[INDEX]")

for i in range (0,1024):
    index = (45 + 3 * i) % 1024
    index_v.append(index)


indexFile = open("ModelSim/index_py.txt","w")
i = 0
for x in index_v:
    indexFile.write("input[" + str(x) + "] = " + "| output[" + str(i) + "]\n")
    print(x,end=" ")
    i+=1

indexFile.close()

print("")
print("______________________________________________")
print("[REUSLTS]")

print("compere results... ")

for s in range(0, TX_CYCLES):
    output_py = open(f"ModelSim/output_py{s}.txt", "r")
    output_vhdl = open(f"ModelSim/output_vhdl{s}.txt", "r")
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
        print(f"[+] test {s} : 0 errors")
    else:
        print(f"[-] test {s} : " + str(error) + "errors")

print("________________________________________________")



