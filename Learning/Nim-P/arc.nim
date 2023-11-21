# Compile using nim c --mm:orc --expandArc:main arc.nim

proc main = 
    let mystr = stdin.readLine()
    
    case mystr
    of "hello":
        echo "Nice to meet you!"
    of "bye":
        echo "Goodbye!"
        quit()
    else:
        discard

main()
