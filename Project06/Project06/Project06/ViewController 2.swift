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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.red
        label.text = "THESE"
        label.sizeToFit()
        return label
    }()
    
    private let label2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.cyan
        label.text = "ARE"
        label.sizeToFit()
        return label
    }()
    
    private let label3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.yellow
        label.text = "SOME"
        label.sizeToFit()
        return label
    }()
    
    private let label4: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.green
        label.text = "AWESOME"
        label.sizeToFit()
        return label
    }()
    
    private let label5: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.orange
        label.text = "LABELS"
        label.sizeToFit()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        addConstraints()
        
    }
    
    func addConstraints() {
        var previous: UILabel?
        
        for label in [label1, label2, label3, label4, label5] {
            
            label.snp.makeConstraints { make in
                make.width.equalToSuperview()
                make.height.equalTo(self.view.safeAreaLayoutGuide).dividedBy(5).offset(-10)
                make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)

                if let previous = previous {
                    make.top.equalTo(previous.snp.bottom).offset(10)
                } else {
                    make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                }
            }
            previous = label
        }
    }
}

