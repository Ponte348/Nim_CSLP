# Using this file to debug easier

elfos = []

with open('input.txt', 'r') as f:
    data = f.read().splitlines()
    
    totalCalorias = 0
    for value in data:
        if value == '':
            pass
        else:
            totalCalorias += int(value)