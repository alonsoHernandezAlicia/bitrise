//
//  Hero.swift
//  iOSAvanzadoOpenBank
//
//  Created by Ismael Sabri Pérez on 20/7/23.
//

import Foundation

struct Hero: Decodable {
    let photo: URL
    let id: String
    let name: String
    let description: String
}
