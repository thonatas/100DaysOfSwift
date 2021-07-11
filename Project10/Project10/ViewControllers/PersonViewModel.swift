//
//  PersonViewModel.swift
//  Project10
//
//  Created by Thonatas Borges on 11/07/21.
//

import Foundation

protocol PersonViewModelDelegate {
    func loadDataDidFinish()
}

class PersonViewModel {
    var people: [Person] = [] {
        didSet {
            delegate?.loadDataDidFinish()
        }
    }
    var delegate: PersonViewModelDelegate?
}
