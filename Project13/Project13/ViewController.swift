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
    private var currentImage: UIImage!
    private var context: CIContext!
    private var currentFilter: CIFilter!
    private var intensity: Float = 0.0 {
        didSet {
            
            self.loadViewIfNeeded()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "InstaFilter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        setupView()
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
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
        slider.value = intensity
        slider.addTarget(self, action: #selector(changeValue), for: .valueChanged)
        slider.isUserInteractionEnabled = true
        slider.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    @objc private func changeValue() {
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        DispatchQueue.main.async {
            self.applyProcessing()
        }
        
    }
    
    @objc private func changeFilterButtonTapped() {
        let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
           ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
           ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
           ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
           ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
           ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
           ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
           ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
           ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
           present(ac, animated: true)
    }
    
    @objc private func saveButtonTapped() {
        guard let image = imageView.image else {
            fatalError("Error, image is nil")
        }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc private func importPicture() {
        let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
            present(picker, animated: true)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    private func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(slider.value, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(slider.value * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(slider.value * 10, forKey: kCIInputScaleKey) }
        if inputKeys.contains(kCIInputCenterKey) { currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey) }
        
        if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            self.imageView.image = processedImage
        }
    }
    
    private func setFilter(action: UIAlertAction) {
        guard currentImage != nil else { return }
        guard let actionTitle = action.title else { return }
        currentFilter = CIFilter(name: actionTitle)
        let beginImage = CIImage(image: currentImage)
        currentFilter?.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        currentImage = image
        imageView.image = currentImage
        
        let beginImage = CIImage(image: currentImage)
        currentFilter?.setValue(beginImage, forKey: kCIInputImageKey)

        applyProcessing()
    }
}
