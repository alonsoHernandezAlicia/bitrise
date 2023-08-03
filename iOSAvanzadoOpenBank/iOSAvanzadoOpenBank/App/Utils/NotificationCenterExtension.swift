//
//  NotificationCenterExtension.swift
//  iOSAvanzadoOpenBank
//
//  Created by Ismael Sabri Pérez on 26/7/23.
//

import Foundation

extension Notification.Name {
    static let deleteToken = Notification.Name("DeleteToken")
}




// 1. Evento que se emite --> llega a notification center --> notification center avisa a todos los interesados en ese evento

// 1. Emitir el evento

// Logout (tabBarVC) -> tabBarVM -> repository -------- CLOSURES
// Más facil pasar datos
// 1 - 1
// Mantiene el canal cerrado
// Da lugar a menos errores
// Tipado
// Es más explícito

// Logout (tabBarVC) -> NotificationCenter -> repository----- NOTIFICATION CENTER
// Se pueden pasar datos más dificil
// 1 - n
// Da lugar a más errores
// No te aseguras el tipo de parámetros
