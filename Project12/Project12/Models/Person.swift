//
//  Person.swift
//  Project10
//
//  Created by Thonatas Borges on 11/07/21.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
