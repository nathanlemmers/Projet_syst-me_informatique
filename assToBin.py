import sys
import math


lines = open ("test.S", "r").readlines()
lines = [line.split() for line in lines]
prog = lines


for pc in range(len(prog)) :
    if (prog[pc][0]) == "ADD" :
        val = (1, int(prog[pc][1]), int(prog[pc][2]), int(prog[pc][3]))
        print("x\"%02x%02x%02x%02x\"," % tuple(val))
    elif (prog[pc][0]) == "MUL" :
        val = (2, int(prog[pc][1]), int(prog[pc][2]), int(prog[pc][3]))
        print("x\"%02x%02x%02x%02x\"," % tuple(val))    
    elif (prog[pc][0]) == "SUB" :
        val = (3, int(prog[pc][1]), int(prog[pc][2]), int(prog[pc][3]))
        print("x\"%02x%02x%02x%02x\"," % tuple(val))
    elif (prog[pc][0]) == "COP" :
        val = (5, int(prog[pc][1]), int(prog[pc][2]), 0)
        print("x\"%02x%02x%02x%02x\"," % tuple(val))
    elif (prog[pc][0]) == "PUT" :
        val = (6, int(prog[pc][1]), int(prog[pc][2]), 0)
        print("x\"%02x%02x%02x%02x\"," % tuple(val))
    elif (prog[pc][0]) == "LOAD" :
        val = (7, int(prog[pc][1]), int(prog[pc][2]), 0)
        print("x\"%02x%02x%02x%02x\"," % tuple(val))
    elif (prog[pc][0]) == "STORE" :
        val = (8, int(prog[pc][1]), int(prog[pc][2]), 0)
        print("x\"%02x%02x%02x%02x\"," % tuple(val))
    elif (prog[pc][0]) == "GT" :
        val = (9, int(prog[pc][1]), int(prog[pc][2]), int(prog[pc][3]))
        print("x\"%02x%02x%02x%02x\"," % tuple(val))
    elif (prog[pc][0]) == "LT" :
        val = (10, int(prog[pc][1]), int(prog[pc][2]), int(prog[pc][3]))
        print("x\"%02x%02x%02x%02x\"," % tuple(val))
    elif (prog[pc][0]) == "EQ" :
        val = (11, int(prog[pc][1]), int(prog[pc][2]), int(prog[pc][3]) )
        print("x\"%02x%02x%02x%02x\"," % tuple(val))
    elif prog[pc][0] == "JMF":
        label = prog[pc][1] + ":"
        index = prog.index([label])  # Remplacez cette valeur par l'index approprié dans votre liste prog
        val = (12, int(index+1), int(prog[pc][2]), 0)
        print("x\"%02x%02x%02x%02x\"," % tuple(val))
    else :
        print("x\"00000000\",")



# Rediriger les sorties print vers un fichier
sys.stdout = open('outputbinary.txt', 'w')

# Vos instructions de print

# Restaurer la sortie standard
sys.stdout.close()
sys.stdout = sys.__stdout__

#Commande pour lancer et utiliser : python assToBin.py > outputbinary.txt
