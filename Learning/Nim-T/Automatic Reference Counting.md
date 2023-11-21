#nim #cslp 
# What is Reference Counting

Reference Counting is one of the most popular algorithms for freeing unused resources of the program. The **reference count** for any managed (controlled by the runtime) reference is how many times that reference is used elsewhere. When that count becomes zero, the reference and all of its underlying data is destroyed.

The main difference between **ARC** and **Nim GCs** is that **ARC** is **fully deterministic** - the compiler automatically **injects** destructors when it deems that some variable (a string, sequence, reference or something else) is no longer needed.