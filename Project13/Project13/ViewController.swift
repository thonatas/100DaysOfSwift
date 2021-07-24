//
//  ViewController.swift
//  Project13
//
//  Created by Thonatas Borges on 23/07/21.
//

import UIKit
import SnapKit
import CoreImage

class ViewController: UIViewController {
    
    private let backgroundView = UIView()
    private let slider = UISlider()
    private let imageView = UIImageView()
    private let changeFilterButton = UIButton()
    private let saveButton = UIButton()
    private let label = UILabel()
    private var currentImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "InstaFilter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        setupView()
    }

    private func setupView() {
        addBackgroundView()
        addImageView()
        addLabel()
        addSlider()
        addChangeFilterButton()
        addSaveButton()
    }
    
    private func addBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.backgroundColor = .darkGray
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
            make.height.lessThanOrEqualTo(470)
            make.width.equalTo(375)
        }
    }
    
    private func addImageView() {
        backgroundView.addSubview(imageView)
        imageView.image = UIImage(systemName: "star")
        imageView.contentMode = .scaleAspectFit
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    private func addLabel() {
        view.addSubview(label)
        label.text = "Intensity"
        label.font = .systemFont(ofSize: 22, weight: .regular)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(self.backgroundView.snp.bottom).offset(20)
            make.leading.equalTo(backgroundView)
        }
    }
    
    private func addSlider() {
        view.addSubview(slider)
        slider.value = 0.5
        
        slider.snp.makeConstraints { make in
            make.top.equalTo(self.backgroundView.snp.bottom).offset(20)
            make.leading.equalTo(label.snp.trailing).offset(20)
            make.trailing.equalTo(backgroundView)
        }
    }
    
    private func addChangeFilterButton() {
        view.addSubview(changeFilterButton)
        changeFilterButton.setTitle("Change Filter", for: .normal)
        changeFilterButton.setTitleColor(.systemBlue, for: .normal)
        changeFilterButton.addTarget(self, action: #selector(changeFilterButtonTapped), for: .touchUpInside)
        
        changeFilterButton.snp.makeConstraints { make in
            make.top.equalTo(self.label.snp.bottom).offset(20)
            make.leading.equalTo(backgroundView)
            make.height.equalTo(40)
            make.width.equalTo(150)
            make.bottom.greaterThanOrEqualToSuperview().offset(-40)
        }
    }
    
    private func addSaveButton() {
        view.addSubview(saveButton)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(self.slider.snp.bottom).offset(20)
            make.leading.greaterThanOrEqualTo(changeFilterButton.snp.trailing).offset(20)
            make.trailing.equalTo(backgroundView)
            make.height.equalTo(40)
            make.width.equalTo(150)
            make.bottom.greaterThanOrEqualToSuperview().offset(-40)
        }
    }
    
    @objc private func changeFilterButtonTapped() {
        print(#function)
        
    }
    
    @objc private func saveButtonTapped() {
        print(#function)
        
    }
    
    @objc private func importPicture() {
        let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
            present(picker, animated: true)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        currentImage = image
        imageView.image = currentImage
    }
}
