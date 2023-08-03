import UIKit




//UNA FUNCIÓN ES UN CLOSURE
print("")
print("")
print("--------------------------------------------------------")
print("-----------------UNA FUNCIÓN ES UN CLOSURE--------------")
print("--------------------------------------------------------")

var name = "Pedro"
var age = "25"
var work = "Medico"

// Las funciones son closures → sí, pero no hay mejor manera de que os explote la cabeza
func gaveAge(name: String, age: String) -> String {
    return "Hello my name is: \(name) and my age: \(age)"
}
let gaveAgeConstant = { (name: String, age: String) -> String in
  return "Hello my name is: \(name) and my age: \(age)"
}

print(gaveAge(name: name, age: age))
print(gaveAgeConstant(name, age))

// EJERCICIOS
print("")
print("--------------------------------------------------------")
print("-----------------EJERCICIO------------------------------")
// Exercise función es un closure:
// Create a closure that takes two parameters (name and job) and returns a greeting message including the name and job. Call the closure and print the result.

let greetPerson = { (name: String, job: String) -> String in
  return "Hello, my name is \(name) and my job is \(job)"
}
print(greetPerson("John", "Engineer"))



// TIPOS DE CLOSURES
print("")
print("")
print("--------------------------------------------------------")
print("-----------------TIPOS DE CLOSURES----------------------")
print("--------------------------------------------------------")
let intParameterReturnInt = { (integer: Int) -> Int in
    return integer * 2
}
print("Must be 6 -> \(intParameterReturnInt(3))")

let noParameterReturn = { () -> String in
    return "Returns String"
}
print("Must be Returns String -> \(noParameterReturn())")

let firstParameterStringSecondParameterIntNoReturn = { (string: String, number: Int) -> () in
    print("\(string) is the string parameter and \(number) is the int parameter")
}
// Parar -> enseñar que hay que ejecutarla
firstParameterStringSecondParameterIntNoReturn("5", 6)


// EJERCICIOS
print("")
print("--------------------------------------------------------")
print("-----------------EJERCICIO------------------------------")
// Exercise: Create a closure that takes an array of integers as a parameter and returns the sum of all the numbers. Call the closure and print the result.
let sumClosure = { (numbers: [Int]) -> Int in
  var sum = 0
  for number in numbers {
    sum += number
  }
  return sum
}
let numbers = [1, 2, 3, 4, 5]
print("Sum of numbers: \(sumClosure(numbers))")








//CLOSURES COMO PARÁMETROS
print("")
print("")
print("--------------------------------------------------------")
print("-----------------CLOSURES COMO PARÁMETROS---------------")
print("--------------------------------------------------------")
let gaveJob = { (job: String) -> String in
  return "my job is: \(job)"
}

func getDataPerson(nameAndAge: ((String, String) -> String), job: ((String) -> String)) {
    let nameAge = nameAndAge(name, age)
    let jobUser = job(work)
  print("\(nameAge) and \(jobUser)" )
}

getDataPerson(nameAndAge: gaveAge, job: gaveJob)

// EJERCICIOS
print("")
print("--------------------------------------------------------")
print("-----------------EJERCICIO------------------------------")
// Exercise: Write a function called `perform` that takes a closure as a parameter. Inside the function, call the closure and pass the values 10 and 20. The closure should print the sum of the two values. Call the `performOperation` function and provide the closure.
func perform(closure: (Int, Int) -> Void) {
  closure(10, 20)
}
perform { (a, b) in
  print("Sum: \(a + b)")
}



// SINTAXIS ABREVIADA: MANERAS DE ESCRIBIR UN CLOSURE (xcode deduce el tipo, pero lo que ves son estas tres)
print("")
print("")
print("--------------------------------------------------------")
print("-----------------SINTAXIS ABREVIADA---------------------")
print("--------------------------------------------------------")
// Variation 1 -> El más explícito
let intParameterReturnIntExample = { (integer: Int) -> Int in
    return integer * 2
}
// Variation 2 -> Bastante usado, también es explícito
let intParameterReturnInt1: (Int) -> Int = { integer in
    return integer * 2
}
// Variation 3: Puf...
let intParameterReturnInt4: (Int) -> Int = {
    $0 * 2
}




// ESCAPING: explicar y después pedir que pongan números

print("")
print("")
print("--------------------------------------------------------")
print("-----------------ESCAPING-------------------------------")
print("--------------------------------------------------------")

// Non escaping
func performOperation1(completion: () -> Void) {
    print("1. Performing operation...for non escaping")
    completion()
    print("3. Operation1 completed!")
}
performOperation1 {
    print("2. This is the completion block")
}
print("4. This is written after the performOperation1 closure")

// Escaping
func performOperation2(completion: @escaping () -> Void) {
    print("")
    print("")
    print("1. Performing operation2...escaping")
    DispatchQueue.global().async { // normalmente los closures se llaman en procesos asíncronos
        // Simulating an asynchronous operation
        sleep(2)
        completion()
        print("4. Operation2 completed!")
    }
}
func processCompletion() {
    print("3. This is the completion block")
}
performOperation2 {
    processCompletion()
}
print("2. This is written after the performOperation2 closure")


/**
// EJERCICIOS
print("")
print("--------------------------------------------------------")
print("-----------------EJERCICIO------------------------------")
// Exercise: Create a function called `performLogin` that takes a closure as a parameter. Inside the function, simulate a login process by introducing a delay of 2 seconds using `sleep(2)`. After the delay, call the closure to simulate a successful login. Outside the function, call the `performLogin` function and provide a closure that prints "Login successful".
func performLogin(completion: @escaping () -> Void) {
    DispatchQueue.global().async {
        print("2. Starting login process...")
        sleep(2)
        completion()
        print("4. Login completed!")
    }
}
performLogin {
    print("3. Login successful")
}
print("1. This is written after the performLogin closure")
*/


