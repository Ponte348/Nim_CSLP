# Compile using nim r --mm:orc --expandArc:main GC_Arc.nim

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
