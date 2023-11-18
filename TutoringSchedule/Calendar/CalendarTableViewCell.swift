//
//  CalendarTableViewCell.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/11/02.
//

import UIKit
import SnapKit

class CalendarTableViewCell: UITableViewCell {

    let backView = {
       let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.signatureColor.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let timeLabel = {
       let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .black
        view.textAlignment = .left
        return view
    }()
    
    let classNameLabel = {
       let view = UILabel()
        view.font = .boldSystemFont(ofSize: 16)
        view.textColor = .black
        view.textAlignment = .right
        return view
    }()
    
    let tutoringPlaceLabel = {
       let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .darkGray
        view.textAlignment = .right
        return view
    }()

    func setting() {
        setConfigure()
        setConstraint()
    }
    
    func setConfigure() {
        contentView.addSubview(backView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(classNameLabel)
        contentView.addSubview(tutoringPlaceLabel)
    }
    
    func centerYClassNameLabel() {
        classNameLabel.snp.remakeConstraints { make in
            make.right.equalTo(backView).inset(12)
            make.centerY.equalTo(backView)
        }
    }

    func setConstraint() {
        backView.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(12)
            make.horizontalEdges.equalTo(contentView).inset(4)
            make.bottom.equalTo(contentView).inset(1)
            make.height.equalTo(55)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(backView).inset(12)
            make.width.equalTo(100)
        }
        
        classNameLabel.snp.remakeConstraints { make in
            make.top.equalTo(timeLabel.snp.top)
            make.right.equalTo(backView).inset(12)
            make.left.equalTo(timeLabel.snp.right).offset(12)
        }
        
        tutoringPlaceLabel.snp.makeConstraints { make in
            make.top.equalTo(classNameLabel.snp.bottom).offset(4)
            make.trailing.equalTo(classNameLabel)
            make.bottom.equalTo(backView).inset(8)
            make.left.equalTo(timeLabel.snp.right).offset(12)
        }
    }
}
