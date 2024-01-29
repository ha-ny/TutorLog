//
//  StudentTableViewCell.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/11/04.
//

import UIKit
import SnapKit

class StudentTableViewCell: UITableViewCell {
    
    let backView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.pkBlue.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let nameLabel = {
        let view = UILabel()
        view.font = .customFont(ofSize: 15)
        view.textColor = .bdBlack
        view.textAlignment = .left
        return view
    }()
    
    let editButton = {
        let view = UIImageView()
        view.image = .edit
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    func setting() {
        backgroundColor = .clear
        setConfigure()
        setConstraint()
    }
    
    func setConfigure() {
        contentView.addSubview(backView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(editButton)
    }
    
    func setConstraint() {
        backView.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(12)
            make.horizontalEdges.equalTo(contentView).inset(4)
            make.bottom.equalTo(contentView).inset(1)
            make.height.equalTo(55)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.verticalEdges.left.equalTo(backView).inset(8)
            make.right.equalTo(editButton.snp.left).offset(14)
        }
        
        editButton.snp.makeConstraints { make in
            make.verticalEdges.right.equalTo(backView).inset(8)
            make.size.equalTo(25)
        }
    }
}
