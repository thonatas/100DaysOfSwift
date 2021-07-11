//
//  PersonCollectionViewCell.swift
//  Project10
//
//  Created by Thonatas Borges on 11/07/21.
//

import UIKit
import SnapKit

class PersonCollectionViewCell: UICollectionViewCell {
 
    //MARK: - DECLARATION OF VARIABLES / INITIALIZATION
        static let identifier = "PersonCollectionViewCell"
        
        private let imageView = UIImageView()
        private let nameLabel = UILabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .white
            layer.cornerRadius = 15
            addImageView()
            addNameLabel()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
     
    //MARK: - FUNCTIONS
        func setupCell(with person: Person) {
            nameLabel.text = person.name
            //imageView.image = person.image
        }
        
        private func addImageView() {
            addSubview(imageView)
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .center
            
            imageView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(10)
                make.leading.equalToSuperview().offset(10)
                make.trailing.equalToSuperview().offset(-10)
                make.size.equalTo(120)
            }
        }
        
        private func addNameLabel() {
            addSubview(nameLabel)
            
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            nameLabel.font = .systemFont(ofSize: 15, weight: .regular)
            nameLabel.textAlignment = .center

            nameLabel.snp.makeConstraints { make in
                make.top.equalTo(imageView.snp.bottom).offset(14)
                make.leading.equalToSuperview().offset(10)
                make.trailing.equalToSuperview().offset(-10)
                make.height.equalTo(40)
                make.width.equalTo(120)
            }
        }
}
