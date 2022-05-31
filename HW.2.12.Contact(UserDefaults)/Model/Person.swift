//
//  Person.swift
//  HW.2.12.Contact(UserDefaults)
//
//  Created by Sergey Yurtaev on 31.05.2022.
//

import Foundation

struct Person: Codable {
    let firstName: String
    let lastName: String
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}
