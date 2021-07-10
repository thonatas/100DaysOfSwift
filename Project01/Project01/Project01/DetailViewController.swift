//
//  DetailViewController.swift
//  Project01
//
//  Created by Thonatas Borges on 12/06/21.
//

import UIKit

class DetailViewController: UIViewController {

    var selectedImage: String?
    
    private let imageView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = selectedImage ?? "View Picture"
        navigationItem.largeTitleDisplayMode = .never
        addImageView()

    }
    
    private func addImageView() {
        
            self.view.addSubview(imageView)
        
            if let imageToLoad = selectedImage {
                imageView.image  = UIImage(named: imageToLoad)
            }

            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        }

}
