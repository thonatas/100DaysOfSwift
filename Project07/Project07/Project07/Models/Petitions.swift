//
//  Petitions.swift
//  Project07
//
//  Created by Thonatas Borges on 03/07/21.
//

import UIKit

struct Petitions: Codable {
    var results: [Petition]
}

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
