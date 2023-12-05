# https://nim-lang.org/docs/mm.html
# By default, memory is managed by the ORC, collecting cycles and using move semantics
# There are two kinds of references: traced (ref) and untraced (ptr)

# Traced references are managed by the ORC and are the default
type
    Person = ref object
        name: string
        age: int

let person = Person(name: "John", age: 26) # This is a traced reference

# Allocate memory for Data and save an untraced reference to it:
var p: ptr Person = cast[ptr Person](alloc0(sizeof(Person)))

# Free the memory:
dealloc(d)
