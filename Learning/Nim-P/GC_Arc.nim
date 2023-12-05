# We can see how ORC works by inserting lifetime hooks into the generated code

### Move semantics
type
    mover = object
        x: string

# We'll see what this does later
#proc `=copy`(dest: var mover; source: mover) {.error.}

proc consume(x: sink mover) = discard "no implementation"
proc produce(x: string): mover =
    result.x = x

# Compile using nim r --expandArc:regular GC_Arc.nim

proc regular =
    let tup = (produce("a"), produce("b"))
    consume tup[0]
    # ok, only tup[0] was consumed, tup[1] is still alive:
    echo tup[1]
    # but we can still use tup[0]:
    echo tup[0]

regular()
