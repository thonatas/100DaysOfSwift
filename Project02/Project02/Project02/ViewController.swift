//
//  ViewController.swift
//  Project02
//
//  Created by Thonatas Borges on 12/06/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let firstFlagButton: UIButton = UIButton()
    private let secondFlagButton: UIButton = UIButton()
    private let thirdFlagButton: UIButton = UIButton()
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        addFirsFlagButton()
        addSecondFlagButton()
        addThirdFlagButton()
        askQuestion()
        
    }
    
    private func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        firstFlagButton.setImage(UIImage(named: countries[0]), for: .normal)
        secondFlagButton.setImage(UIImage(named: countries[1]), for: .normal)
        thirdFlagButton.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
    }
    
    private func addFirsFlagButton() {
        view.addSubview(firstFlagButton)
        firstFlagButton.layer.borderWidth = 1
        firstFlagButton.layer.borderColor = UIColor.lightGray.cgColor
        firstFlagButton.tag = 0
        firstFlagButton.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        firstFlagButton.translatesAutoresizingMaskIntoConstraints = false
        
        firstFlagButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(100)
            make.height.equalTo(100)
            make.width.equalTo(200)
            make.centerX.equalTo(self.view)
        }
    }
    
    private func addSecondFlagButton() {
        view.addSubview(secondFlagButton)
        secondFlagButton.layer.borderWidth = 1
        secondFlagButton.layer.borderColor = UIColor.lightGray.cgColor
        secondFlagButton.tag = 1
        secondFlagButton.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        secondFlagButton.translatesAutoresizingMaskIntoConstraints = false
        
        secondFlagButton.snp.makeConstraints { make in
            make.top.equalTo(firstFlagButton.snp.bottom).offset(100)
            make.height.equalTo(100)
            make.width.equalTo(200)
            make.centerX.equalTo(self.view)
        }
    }
    
    private func addThirdFlagButton() {
        view.addSubview(thirdFlagButton)
        thirdFlagButton.layer.borderWidth = 1
        thirdFlagButton.layer.borderColor = UIColor.lightGray.cgColor
        thirdFlagButton.tag = 2
        thirdFlagButton.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        thirdFlagButton.translatesAutoresizingMaskIntoConstraints = false
        
        thirdFlagButton.snp.makeConstraints { make in
            make.top.equalTo(secondFlagButton.snp.bottom).offset(100)
            make.height.equalTo(100)
            make.width.equalTo(200)
            make.centerX.equalTo(self.view)
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        var title: String

        if sender.tag == correctAnswer {
            title = "Correct"
            print("correct")
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }

        let alert = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(alert, animated: true)
    }
}

