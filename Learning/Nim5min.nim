# This is a comment

#[  This is a multiline comment
    In Nim comments can be nested 
]#

discard """
    This is also a multinime comment
"""

# Variables can be delcared with or without type
var
    letter: char = 'n'
    lang = "N" & "im"
    nLength: int = len(lang)
    boar: float
    truth: bool = false

# let can be used to create immutable variables
let
    legs = 400
    arms = 2_000_000 # underscores are ignored and can be useful to write large numbers
    aboutPi = 3.15

discard legs

# constants are computed at compile time, this provides performance benefits
const 
    debug = true
    compileBadCode = false

# In this case, when is a compile time if statement
when compileBadCode:
    legs = legs + 1                 # This error will never be compiled
    const input = readline(stdin)   # Const values must be known at compile time

# The compiler will complain if the result of an expression is not used but discard bypasses it
discard 1 > 2

# 
# Data Strcutures
#

# Tuples
var
    child: tuple[name: string, age: int]    # Tuples have field names
    today: tuple[sun: string, temp: float]  # and order

child = (name:"Lopes da Silva", age: 35)    # Assign all fields at once
today.sun = "Overcast"                      # Or individually
today.temp = 70.1


# Sequences

var
    drinks: seq[string]

drinks = @["Water", "Juice", "SODA"] # @[V1,...,Vn] is the sequence literal

drinks.add("Milk") # Add an element to the end

if "Milk" in drinks:
    echo "We have Milk and ", drinks.len - 1, " other drinks"

let myDrink = drinks[2]


#
# Defining Types
#

# Defining your own data types puts the compiler to work for you

type
    Name = string # A type alias gives you a new type that is interchangeable
    Age = int       # with the old type but is more descriptive
    Person = tuple[name: Name, age: Age] # Define data strcutures too
    #AnotherSyntax = tuple
    #    fieldOne: string
    #    secondField: int

var
    john: Person = (name: "John D.", age: 26)
    newage: int = john.age + 1 # It would be better to use Age than int

john.age = newage # But it still works because int and Age are synonyms

type
    Cash = distinct int # distinct makes a new type incompatible with it base type
    Desc = distinct string

var 
    money: Cash = 100.Cash # .Cash converts int to our type
    description: Desc = "Interesting".Desc

when compileBadCode:
    jhon.age = money # This would be an error because Age is of type int and money is type Cash
    john.name = description # Compiler doesn't like this



#
# More types and data structures
#

# Enumerations allow a type to have one of a limited number of values

type
    Color = enum cRed, cBlue, cGreen
    Direction = enum  # Two formatting options
        dNorth
        dEast
        dSouth
        dWest

var
    orient = dNorth # orient is now of type Direction, with the value dNorth
    pixel = cGreen # pixel is now of type Color, with the value cGreen

discard dNorth > dEast # Enums are usually an "ordinal" type, meaning they can be compared


# Subranges specify a limited valid range
type
    DieFaces = range[1..20] # Only an int from 1 to 20 is a valid value
var
    my_roll: DieFaces = 13

when compileBadCode:
    my_roll = 21 # Compiler will complain because 21 is not in the range


# Arrays

type
    RollCounter = array[DieFaces, int] # Arrays are fixed length and
    DirNames = array[Direction, string] # indexed by any ordinal type
    Truths = array[42..44, bool] # or subrange
var
    counter: RollCounter
    directions: DirNames
    possible: Truths

possible = [false, false, true] # Literal arrays are created with [V1,...,Vn]
possible[42] = true

directions[dNorth] = "The Great White North"
directions[dWest] = "Yeah don't go there"

my_roll = 13
counter[my_roll] += 1
counter[my_roll] += 1

var anotherArray = ["Default index", "starts at", "0"]

# More data structures are available, including tables, sets, lists, queues,
# and crit bit trees.
# http://nim-lang.org/docs/lib.html#collections-and-algorithms


#
# IO and Control Flow
#

# 'case', 'readline()'

echo "Read any good books lately?"
case readLine(stdin)
of "no", "No":
    echo "Go to your local library."
of "yes", "Yes":
    echo "Great!"
else:
    echo "I did not understand that."

# 'while', 'if', 'continue', 'break'

import strutils as str # http://nim-lang.org/docs/strutils.html
import std/random as rand
randomize()
echo "I'm thinking of a number between 1 and 10. Guess which!"
let number: int = rand(1..10)
var
    raw_guess: string
    guess: int
while guess != number:
    raw_guess = readLine(stdin)
    if raw_guess == "": continue # skip this one
    guess = str.parseInt(raw_guess)
    # check if it's out of bounds
    if guess < 1 or guess > 10:
        echo "That's not between 1 and 10!"
        continue
    if guess < number:
        echo "Too low!"
    elif guess > number:
        echo "Too high!"
echo "You got it!"


#
# Iteration
#

for i, elem in ["Yes", "No", "Maybe"]: # or just 'for elem in'
    echo(elem, " is at index: ", i)

for k, v in items(@[(person: "You", power: 100), (person: "Me", power: 9001)]):
    echo v

let myString = """
an <example>
'string' to
play with
""" # Multiline raw string

for line in splitLines(myString):
    echo(line)

for i, c in myString: # Index and letter, Or 'for j in' for just letter
    if i mod 2 == 0: continue # Compact if form
    elif c == 'X': break
    else: echo(c)


#
# Procedures
#

type Answer = enum aYes, aNo

proc ask(question: string): Answer =
    echo(question, " (y/n)")
    while true:
        case readLine(stdin)
        of "y", "Y", "yes", "Yes":
            return Answer.aYes # Enums can be qualified
        of "n", "N", "no", "No":
            return Answer.aNo
        else:
            echo("Please answer yes or no.")

proc addSugar(amount: int = 2) = # Deafult is 2, returns nothing
    assert(amount > 0 and amount < 9000, "Crazy Sugar")
    for a in 1..amount:
        echo(a, " sugar...")

case ask("Would you like sugar in your tea?")
of aYes:
    addSugar(6)
of aNo:
    echo("Just a little bit :)))")
    addSugar()

# Procedures that gets a question and returns aYes or aNo
# addSugar takes and int (if not given, it's 2) and just prints stuff
# case uses ask to get the value and then does stuff based on it, doesn't need an else because ask already controls that


#
# FFI - Foreign Function Interface
#

# Since Nim compiles to C, FFI, is easy:
proc strcmp(s1, s2: cstring): cint {.importc: "strcmp", nodecl.}
let cmp = strcmp("C?", "Easy!")
echo cmp




# Let's discard stuff so the compiler doesn't complain
let dummy = (letter, nLength, boar, truth, arms, aboutPi, debug, myDrink, money, description, orient, pixel, anotherArray)
discard dummy