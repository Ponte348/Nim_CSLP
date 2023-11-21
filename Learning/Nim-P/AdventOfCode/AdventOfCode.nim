# Doing Advent of Code exercises to practice

import os
import strutils as str

# Day 1

proc argmax(sequence: seq[int]): int =
    var maxIndex = 0
    for i in 1..<sequence.len:
        if sequence[i] > sequence[maxIndex]:
            maxIndex = i
    return maxIndex

# Receives sequence of ints and number of top values, return seq with top values
proc argmax(sequence: seq[int], top: int): seq[int] =
    # Create array to store top values
    var topValues: seq[int] = newSeq[int](top)
    for i in 0..<topValues.len:
        topValues[i] = int.low

    # Check if the current value is greater than any of the top values
    for i in 0..<sequence.len:
        for j in 0..<topValues.len:
            if sequence[i] > topValues[j]:
                # Shift all smaller values down
                for k in countdown(j+1, 1):
                    topValues[k] = topValues[k-1]
                # Insert the new value
                topValues[j] = sequence[i]
                break

    return topValues

# Read input.txt and add each line to a list
var 
    elves: seq[int] = @[]
    totalCalories = 0

let filename = "input.txt"
if fileExists(filename):
    let file = open(filename)

    # Each line is a number of calories, empty lines separate elves
    for line in file.lines:
        if line == "":
            elves.add(totalCalories)
            totalCalories = 0
        else:
            totalCalories += str.parseInt(line)
    
    close(file)

else:
    echo "File doesn't exist"
    # end program
    quit(1)

# Day 1 - Part 1
# Add the last elf's total calories if the file doesn't end with an empty line
if totalCalories > 0:
    elves.add(totalCalories)
# Now go through every elf and check which has more calories
var
    maxIndex = argmax(elves)
    maxElf = elves[maxIndex]
echo "Elf " & $(maxIndex + 1) & " ate the most calories: " & $maxElf


# Day 1 - Part 2
# Now we need to find the top 3 elves
var top3 = argmax(elves, 3)
echo "The top 3 elves are: "
for i in 0..<top3.len:
    echo "Elf " & $(i + 1) & " with " & $top3[i] & " calories"
echo "The sum of the calories are: " & $(top3[0] + top3[1] + top3[2])