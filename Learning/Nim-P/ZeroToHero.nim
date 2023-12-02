import math

# This is a comment

#[  This is a multiline comment
]#

# Printing is done with echo
echo "Hello World!"

######################################## Variables ########################################

# Mutable variables are declared with 'var'
var player: string = "John"
var
    country = "PT" # Type inference
    letter: char = 'n'

# let can be used to create immutable variables
let arms = 2_000_000 # underscores are ignored and can be useful to write large numbers

# constants are immutable and computed at compile time, which may be useful for optimization
const compileBadCode = false

######################################## Types ########################################

# Integers
var
    nLength: int = 10
    positive: uint = 10 # unsigned int
    boar: int8 = 127    # int8, int16, int32, int64, uint8, uint16, uint32, uint64

# Floats
var
    magic: float = 42.0
    pi: float32 = 3.14159265358979323846264338327950288419716939937510582097494459230781640628620899
    betterPI: float64 = 3.14159265358979323846264338327950288419716939937510582097494459230781640628620899

######################################## Operators ########################################

# Arithmetic
let
    sum = 1 + 1
    difference = 2 - 1
    product = 2 * 2
    quotient = 10 / 2
    integer_quotient = 10 div 3
    remainder = 10 mod 3
    power = 2 ^ 3

# Bitwise
let
    bit_and = 0b1010 and 0b1100
    bit_or = 0b1010 or 0b1100
    bit_xor = 0b1010 xor 0b1100
    bit_not = not 0b1010
    bit_shift_left = 0b1010 shl 2
    bit_shift_right = 0b1010 shr 2

# Boolean
let
    bool_and = true and false
    bool_or = true or false
    bool_xor = true xor false

# String (most are functions in strutils)
let
    concat = "Hello " & "World!"

# Overloading

# You can overload operators for your own types (which is how most of the operators are implemented)
type
    MyInt = distinct int # distinct makes a new type incompatible with it base type
proc `+`(a, b: MyInt): MyInt = # `+` is the name of the operator
    result = a + b
let a = 1.MyInt + 2.MyInt # 3

######################################## Control Flow ########################################

# If statements
if nLength > 10:
    echo "Long"
elif nLength < 10:
    echo "Short"
else:
    echo "Just right"

# When is a compile time if-statement
when compileBadCode:
    legs = legs + 1 # This error will never be compiled
    const input = readline(stdin) # Const values must be known at compile time


# Ternary operator
let description = if nLength > 10: "Long" else: "Short"

# Case statements (must cover all cases or have an else)
case letter
of 'a'..'z':
    echo "Lowercase"
of 'A'..'Z':
    echo "Uppercase"
else:
    echo "Not a letter"

# For loops
for i in 0..10:
    echo i # Prints 0 to 10
for i in 0..<10:
    echo i # Prints 0 to 9

let forseq = @[1, 2, 3, 4, 5]
for i in forseq:
    echo i # Prints 1 to 5

# While loops
while nLength > 0:
    echo nLength
    nLength -= 1

######################################## Containers ########################################

# Arrays
var zeroindex: array[5, int] = [1, 2, 3, 4, 5]
zeroindex[0] = 10
var oneindex: array[1..5, int] = [1, 2, 3, 4, 5]
oneindex[5] = 10

# Sequences (dynamic arrays)

var empty: seq[int] = @[] # Empty sequence
var drinks: seq[string] = @["Water", "Juice", "SODA"]

echo drinks[0] # Access an element at a given index
drinks.add "Milk" # Add an element to the end
drinks.insert("Tea", 1) # Insert an element at a given index
drinks.del(0) # Delete an element at a given index by swapping it with the last element | 0(1)
drinks.delete(0) # Delete an element at a given index by shifting all elements after it | 0(n)

if "Milk" in drinks:
    echo "We have Milk and ", drinks.len - 1, " other drinks"
    echo "The last drink is ", drinks[drinks.high] # high equals the last index

# Tuples
var
    child: tuple[name: string, age: int]   # Tuples have field names
    today: tuple[sun: string, temp: float] # and order

child = ("Lopes da Silva", 35) # Assign all fields at once by order
child = (name: "Lopes da Silva", age: 35) # Assign all fields at once by name
today.sun = "Overcast" # Or individually
today.temp = 70.1


######################################## Functions ########################################

# Functions in nim are called procedures
proc sayHello(name: string) =
    echo "Hello ", name

sayHello("John") # Prints "Hello John"

# Procedures can have multiple return values
proc getPi(): (float, float) =
    return (3.14, 3.14159265358979323846264338327950288419716939937510582097494459230781640628620899)

let (aboutPi, debug) = getPi() # Destructuring assignment

# Procedures can have optional parameters
proc drink(name: string, drink: string = "Water") =
    echo name, " drinks ", drink

# Procedures can have variadic parameters
proc add(numbers: varargs[int]): int =
    for n in numbers:
        result += n

# Procedures with return values have a result variable initialized

proc add(a, b: int): int =
    result = a + b

proc add2(a, b: int): int =
    return a + b

echo add(1, 2) == add2(1, 2) # true

######################################## Types ########################################

### Type casting

type holes = enum
    h1 = 2
    h2 = 4
    h3 = 6

# This is a regular, safe type cast
echo 1 + h1.int # 3

# This is an unsafe type cast, which just reinterprets the bits
echo 1 + cast[int](h1) # Undefined behavior

### Objects

type
    Animal = object of RootObj # Inheritable objects must inherit from RootObj
        alive: bool
    Cat = object of Animal # Objects are passed by value by default
        name: string
    Dog = ref object of Animal # Ref objects are passed by reference
        name: string

### Methods

# In Nim, methods are just procedures that take the object as the first argument because of UFCS
proc sound(this: Cat) =
    echo this.name, " says meow"
let cat = Cat(name: "Fluffy")
cat.sound() # Prints "Fluffy says meow"
sound(cat) # Also prints "Fluffy says meow"

# To make a procedure that modifies a per-value object, use the 'var' keyword
proc kill(this: var Animal) =
    this.alive = false
# This works because Dog is a ref object
proc kill(this: Dog) =
    this.alive = false

### Concepts (Interfaces)
type
    AnimalSound = concept
        proc sound(this: Animal)

### Generics

# Generics allow you to write code that works with any type
proc allTypes[T](x: T) =
    echo x

# Or restrict it to a subset of types
proc onlyPositive[T: Positive](x: T): T =
    return x

# Any inheritor of Animal that has a sound() method can be passed to makeSound
proc makeSound[T: AnimalSound](animal: T) =
    animal.sound()

### Type Aliases

type
    Name = string # A type alias gives you a new type that is interchangeable with the base type
    Person = tuple[name: Name, age: Positive] # Define data structures too
    Cash = distinct int # distinct makes a new type incompatible with it base type

var
    john: Person = ("John D.", 26) # We must specify the type
    newAge: int = john.age + 1
    money: Cash = 100.Cash         # .Cash converts int to our type

john.age = newAge # Works because int and Age are synonyms
echo compiles(money += 100) == false #  Doesn't work because int and Cash are distinct


### Enums, Subranges and Slices

## Enums

type
    Color = enum cRed, cBlue, cGreen
    Direction = enum # Two formatting options
        dNorth
        dEast
        dSouth
        dWest

var
    orient = dNorth # orient is now of type Direction, with the value dNorth
    pixel = cGreen

discard dNorth > dEast # Enums are usually an "ordinal" type, meaning they can be compared

## Subranges specify a limited valid range
type
    DieFaces = range[1..20] # Only an int from 1 to 20 is a valid value
var
    my_roll: DieFaces = 13

when compileBadCode:
    my_roll = 21 # Compiler will complain because 21 is not in the range

## Slices are a view into an array or sequence
var cocktail: seq[string] = @["Rum", "Gin", "Vodka", "Tequila", "Triple Sec", "Lime Juice"]
var myDrink = cocktail[0..2] # myDrink is a slice of cocktail
echo myDrink # Prints @["Rum", "Gin", "Vodka"]
myDrink = @[myDrink[0], "Orange Juice"] # Slices can be used to modify the original

### Arrays (again)

# Arrays can be indexed by any ordinal type
type
    RollCounter = array[DieFaces, int] # This means Subranges,
    DirNames = array[Direction, string] # Enums,
    Truths = array[42..44, bool] # and Slices are all valid indexes
var
    counter: RollCounter
    directions: DirNames
    possible: Truths

possible = [false, false, true] # Literal arrays are created with [V1,...,Vn]
possible[42] = true
echo compiles(possible[45]) # false, because 45 is not in the range

directions[dNorth] = "The Great White North"
directions[dWest] = "Yeah don't go there"

my_roll = 13
counter[my_roll] += 1

######################################## Imports ########################################

# Importing modules
import math # Import a module
import std/[random, strutils] # Import multiple modules at once

# Importing is done based on the program's location

######################################## Basic IO ########################################

# Reading from stdin

# Case can be compared to a switch statement in other languages

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
"""                                                       # Multiline raw string

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

proc addSugar(amount: int = 2) = # Default is 2, returns nothing
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
# addSugar takes an int (if not given, it's 2) and just prints stuff
# case uses ask to get the value and then does stuff based on it, doesn't need an else because ask already controls that


######################################## FFI ########################################

# Since Nim compiles to C, FFI, is easy:
proc strcmp(s1, s2: cstring): cint {.importc: "strcmp", nodecl.}
let cmp = strcmp("C?", "Easy!")
echo cmp

# This means that you can use any C/C++ library with Nim


######################################## Macros ########################################

# See metaprog.nim as it's too big to fit here :)

####################################### Compiling #######################################

# Run with:     nim r file.nim
# Compile with: nim c file.nim

# Compile with optimizations
# nim c -d:release file.nim

# Foregoing some safety checks
# nim c -d:danger file.nim

# Compile with debugging symbols
# nim c -d:debug file.nim

# For more info: https://nim-lang.org/docs/nimc.html
