import strutils

type
    Student = object
        fullName: string
        age: int
        grades: seq[float]

proc displayStudent(student: Student) =
    echo "Full Name: ", student.fullName
    echo "Age: ", student.age
    echo "Grades: ", student.grades.join(", ")

proc isPassing(student: Student): bool =
    var sum: float = 0.0
    for grade in student.grades:
        sum += grade
    let averageGrade = sum / student.grades.len.float
    return averageGrade >= 9.5


var
  students: array[3, Student]

# Input students
for i in 0 .. 2:
    echo "Enter details for Student ", i + 1
    echo "Full Name:"
    students[i].fullName = readLine(stdin)
    echo "Age:"
    students[i].age = parseInt(readLine(stdin))
    echo "Enter grades (separated by spaces):"
    let gradesInput = split(readLine(stdin))
    students[i].grades = @[]
    for grade in gradesInput:
        students[i].grades.add(parseFloat(grade))

# Display details of each student and if they're passing
for i in 0 .. 2:
  echo "\nDetails for Student ", i + 1
  displayStudent(students[i])
  echo "Passing Status:", isPassing(students[i])
  echo "----------------------"
