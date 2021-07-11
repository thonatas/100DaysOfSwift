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
        
        let imageView = UIImageView()
        let nameLabel = UILabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            //contentView.frame = CGRect(x: 0, y: 0, width: 140, height: 180)
            //contentView.clipsToBounds = true
            backgroundColor = .white
            layer.cornerRadius = 7
            addImageView()
            addNameLabel()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
     
    //MARK: - FUNCTIONS
        private func addImageView() {
            contentView.addSubview(imageView)
            
            imageView.contentMode = .scaleToFill
            imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
            imageView.layer.borderWidth = 2
            imageView.layer.cornerRadius = 3
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            imageView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(10)
                make.leading.equalToSuperview().offset(10)
                make.trailing.equalToSuperview().offset(-10)
                make.size.equalTo(120)
            }
        }
        
        private func addNameLabel() {
            contentView.addSubview(nameLabel)
            
            nameLabel.font = .systemFont(ofSize: 15, weight: .regular)
            nameLabel.textAlignment = .center
            nameLabel.numberOfLines = 2
            nameLabel.translatesAutoresizingMaskIntoConstraints = false

            nameLabel.snp.makeConstraints { make in
                make.top.equalTo(imageView.snp.bottom).offset(14)
                make.leading.equalToSuperview().offset(10)
                make.trailing.equalToSuperview().offset(-10)
                make.height.equalTo(40)
                make.width.equalTo(120)
            }
        }
}
