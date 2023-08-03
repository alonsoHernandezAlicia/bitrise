import UIKit

// Creado por Ismael Sabri Pérez en 17/7/2023

// FUNCIONES DE ALTO NIVEL

// map(_:): Esta función se utiliza para transformar cada elemento de una colección (array, diccionario, etc.) en otro valor utilizando una función de transformación. Devuelve una nueva colección con los elementos transformados.
let numbersMap = [1, 2, 3, 4, 5]
let squaredNumbers = numbersMap.map { $0 * $0 } // [1, 4, 9, 16, 25]


// filter(_:): Esta función se utiliza para filtrar los elementos de una colección basándose en una condición dada por una función de filtrado. Devuelve una nueva colección con los elementos que cumplen la condición.
let numbersFilter = [1, 2, 3, 4, 5]
let evenNumbers = numbersFilter.filter { $0 % 2 == 0 } // [2, 4]


// reduce(::): Esta función combina todos los elementos de una colección en un solo valor utilizando una función que especifica cómo combinar los elementos.
let numbersReduce = [1, 2, 3, 4, 5]
let sum = numbersReduce.reduce(0, { $0 + $1 }) // 15 (suma de todos los elementos)


// sorted(by:): Esta función ordena los elementos de una colección utilizando una función de comparación.
let numbersSortedBy = [5, 3, 1, 4, 2]
let sortedNumbers = numbersSortedBy.sorted(by: <) // [1, 2, 3, 4, 5]


// forEach(_:): Esta función itera sobre los elementos de una colección y aplica una función a cada elemento.
let numbersForeach = [1, 2, 3, 4, 5]
numbersForeach.forEach { print($0) } // Imprime cada número en una línea separada

// flatMap(_:): Esta función se utiliza para transformar cada elemento de una colección en una secuencia de elementos opcionales utilizando una función de transformación. Luego, aplana (combina) la secuencia de elementos opcionales en una sola colección y elimina los valores nulos.
let nestedArray = [[1, 2, 3], [4, 5], [6, 7, 8, 9]]
let flattenedArray = nestedArray.flatMap { $0 }
print(flattenedArray) // Output: [1, 2, 3, 4, 5, 6, 7, 8, 9]


// compactMap(_:): Esta función se utiliza para transformar cada elemento de una colección en un valor opcional utilizando una función de transformación. Luego, elimina los valores opcionales nulos y devuelve una nueva colección sin los valores nulos.
let numbersCompactMap = ["1", "2", "3", "Hola", "5"]
let convertedNumbers = numbersCompactMap.compactMap { Int($0) } // [1, 2, 3, 5]


// first(where:): Esta función devuelve el primer elemento de una colección que cumple una determinada condición dada por una función de filtrado.
let numbersFirst = [1, 2, 3, 4, 5]
if let firstEvenNumber = numbersFirst.first(where: { $0 % 2 == 0 }) {
    print(firstEvenNumber) // Imprime 2 (el primer número par)
}


// allSatisfy(_:): Esta función verifica si todos los elementos de una colección cumplen una determinada condición dada por una función de prueba.
let numbersAllSatisfy = [2, 4, 6, 8, 10]
let allEvenNumbers = numbersAllSatisfy.allSatisfy { $0 % 2 == 0 } // true (todos los números son pares)
