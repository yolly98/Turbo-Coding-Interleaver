from contextlib import nullcontext
import random
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




