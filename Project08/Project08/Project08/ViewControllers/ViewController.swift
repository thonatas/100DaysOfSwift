//
//  ViewController.swift
//  Project08
//
//  Created by Thonatas Borges on 07/07/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private var cluesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "CLUES"
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    private var answersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "ANSWER"
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    private var currentAnswerTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Tap letters to guess"
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 44)
        textField.isUserInteractionEnabled = false
        return textField
    }()
    private var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "Score: 0"
        label.textAlignment = .right
        return label
    }()
    private var letterButtons = [UIButton]()
    private var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SUBMIT", for: .normal)
        button.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        return button
    }()
    private var clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CLEAR", for: .normal)
        button.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        return button
    }()
    private var buttonsView = UIView()
    private var activatedButtons = [UIButton]()
    private var solutions = [String]()
    private var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    private var level = 1
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        addScoreLabel()
        addCluesLabel()
        addAnswerLabel()
        addCurrentAnswerTextField()
        addSubmitButton()
        addClearButton()
        addButtonsView()
        addLetterButtons()
        loadLevel()
        
    }

    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        currentAnswerTextField.text = currentAnswerTextField.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
    }

    @objc func clearTapped(_ sender: UIButton) {
        currentAnswerTextField.text = ""
        for btn in activatedButtons {
            btn.isHidden = false
        }
        activatedButtons.removeAll()
    }

    @objc func submitTapped(_ sender: UIButton) {
        guard let answerText = currentAnswerTextField.text else { return }
        
        if let solutionPosition = solutions.firstIndex(of: answerText) {
            activatedButtons.removeAll()
            
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            splitAnswers?[solutionPosition] = answerText
            answersLabel.text = splitAnswers?.joined(separator: "\n")
            
            currentAnswerTextField.text = ""
            score += 1
            
            if score % 7 == 0 {
                let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        }
    }
    
    private func levelUp(action: UIAlertAction) {
        level += 1
        solutions.removeAll(keepingCapacity: true)

        loadLevel()

        for btn in letterButtons {
            btn.isHidden = false
        }
    }
    
    private func addScoreLabel() {
        view.addSubview(scoreLabel)
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        
        scoreLabel.snp.makeConstraints { make in
            make.top.trailing.equalTo(view.layoutMarginsGuide)
        }
    }
    
    private func addCluesLabel() {
        view.addSubview(cluesLabel)
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        
        cluesLabel.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel.snp.bottom)
            make.leading.equalTo(view.layoutMarginsGuide).offset(100)
            make.width.equalTo(view.layoutMarginsGuide).multipliedBy(0.6).offset(-100)
        }
    }
    
    private func addAnswerLabel() {
        view.addSubview(answersLabel)
        
        answersLabel.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel.snp.bottom)
            make.trailing.equalTo(view.layoutMarginsGuide).offset(-100)
            make.width.equalTo(view.layoutMarginsGuide).multipliedBy(0.4).offset(-100)
            make.height.equalTo(cluesLabel)
        }
    }
    
    private func addCurrentAnswerTextField() {
        view.addSubview(currentAnswerTextField)
        
        currentAnswerTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.top.equalTo(cluesLabel.snp.bottom).offset(20)
        }
    }
    
    private func addSubmitButton() {
        view.addSubview(submitButton)
        
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(currentAnswerTextField.snp.bottom)
            make.centerX.equalToSuperview().offset(-100)
            make.height.equalTo(44)
        }
    }
    
    private func addClearButton() {
        view.addSubview(clearButton)
        
        clearButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(100)
            make.centerY.equalTo(submitButton.snp.centerY)
            make.height.equalTo(44)
        }
    }
    
    private func addButtonsView() {
        view.addSubview(buttonsView)
        
        buttonsView.snp.makeConstraints { make in
            make.width.equalTo(750)
            make.height.equalTo(320)
            make.centerX.equalToSuperview()
            make.top.equalTo(submitButton.snp.bottom).offset(20)
            make.bottom.equalTo(view.layoutMarginsGuide).offset(-20)
        }
    }
    
    private func addLetterButtons() {
        let width = 150
        let height = 80

        for row in 0..<4 {
            for col in 0..<5 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("WWW", for: .normal)
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
            }
        }
    }
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()

        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
            if let levelContents = try? String(contentsOf: levelFileURL) {
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()

                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]

                    clueString += "\(index + 1). \(clue)\n"

                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionWord.count) letters\n"
                    solutions.append(solutionWord)

                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
        }

        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)

        letterBits.shuffle()

        if letterBits.count == letterButtons.count {
            for i in 0 ..< letterButtons.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }
}

