

import Foundation



//print("----------------------------------------------------------")
//print("--------------------MAIN----------------------------------")
//print("----------------------------------------------------------")
//
//// Usando caso reales
//DispatchQueue.main.async {
//    print("Actualizo la UI en el hilo main o me pasan cosas malas")
//}
//// Podemos ejecutar código con retrasos (delays)
//DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//    print("Tarea ejecutada con 4 segundos de retraso en el hilo main")
//    sleep(3)
//    print("Tarea ejecutada después de esperar 3 segundos en el hilo main")
//}

//print("")
//print("")
//print("----------------------------------------------------------")
//print("--------------------GLOBAL--------------------------------")
//print("----------------------------------------------------------")
//
//func sum(num1: Int, num2: Int) -> Int {
//    return num1 + num2
//}
//
//var number = 2
//
//// Execute code asynchronously on a global queue -> Enseñar comentando la cola de abajo y el código de main. Esto es lo que ocurre cuando hacemos un closure escaping del login.
//DispatchQueue.global(qos: .background).async {
//    print("Async task: performing sum")
//    number = sum(num1: 1, num2: 2)
//    print(number)
//    // Simulate some time-consuming task
//    sleep(2)
//    print("Async task completed")
//}
//
//// Execute code synchronously on a global queue -> Enseñar comentando la cola de arriba: no tiene sentido hacer esto porque se espera hasta que el código termina
//DispatchQueue.global(qos: .background).sync {
//    print("Sync task: sending an email")
//    // Simulate some time-consuming task
//    sleep(1)
//    print("Sync task completed")
//}
//
//print("Code execution continues here")






print("----------------------------------------------------------")
print("--------------------CUSTOM---------------------------------")
print("----------------------------------------------------------")
let serialQueue = DispatchQueue.init(label: "myCola.serial.queue")

print("Tarea 1")
print("Tarea 2")

serialQueue.async {
    print("Tarea serie 1")
    print("Tarea serie 2")
}

serialQueue.async {
    print("Tarea serie 3")
    print("Tarea serie 4")
}

// Creando una cola concurrente
let concurrentQueue = DispatchQueue.init(label: "myCola.concurrente.queue", attributes: .concurrent)

concurrentQueue.async {
    print("Tarea concurrente 1")
    print("Tarea concurrente 2")
    print("Tarea concurrente 3")
    print("Tarea concurrente 4")
}

print("After all or not?")








