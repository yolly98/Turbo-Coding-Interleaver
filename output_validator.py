from contextlib import nullcontext
from unicodedata import decimal

index_v = []
TX_CYCLES = 4


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



