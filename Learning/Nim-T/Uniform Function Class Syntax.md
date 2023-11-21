#nim #cslp
Programming language feature in **Nim** and **D** (another programming language) that allows any function to be called using the syntax for method calls (as in **object-oriented programming**), by using the receiver as the first aprameter, and the given arguments as the remaining parameters.

**UFCS** is particularly useful when function calls are chained.
It allows free-functions to fill a role similar to extension methods in some other languages.

**Nim example**
```Nim
type Vector = tuple[x, y: int]

proc add(a, b: Vector): Vector =
  (a.x + b.x, a.y + b.y)

let
  v1 = (x: -1, y: 4)
  v2 = (x: 5, y: -2)

  # all the following are correct
  v3 = add(v1, v2)
  v4 = v1.add(v2)
  v5 = v1.add(v2).add(v4)
```
