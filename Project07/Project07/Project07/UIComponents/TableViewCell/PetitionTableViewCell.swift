//
//  CandidateTableViewCell.swift
//  AppAcademyChallenge
//
//  Created by Thonatas Borges on 20/05/21.
//

import UIKit
import SnapKit

class PetitionTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addTitleLabel()
        addBodyLabel()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(petition: Petition) {
        self.titleLabel.text = petition.title
        self.bodyLabel.text = petition.body
        self.accessoryType = .disclosureIndicator
    }
    
}

// MARK: - Constraints
private extension PetitionTableViewCell {
    
    func addTitleLabel() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    func addBodyLabel() {
        contentView.addSubview(bodyLabel)
        
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.bottom.trailing.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(15)
        }
    }
}
