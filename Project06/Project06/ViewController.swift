//
//  ViewController.swift
//  Project06
//
//  Created by Thonatas Borges on 30/06/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private let label1: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let label2: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let label3: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let label4: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let label5: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLabels()
    }
    
    var previous: UILabel?

    func addLabels() {
        for label in [label1, label2, label3, label4, label5] {
            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 88).isActive = true

            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            }
            previous = label
        }

        if let previous = previous {
            label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
        } else {
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        }
    }
    
    
}

