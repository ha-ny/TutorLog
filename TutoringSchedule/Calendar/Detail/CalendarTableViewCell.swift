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
        view.layer.borderColor = UIColor.pkBlue.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let timeLabel = {
       let view = UILabel()
        view.font = .customFont(sytle: .bold, ofSize: 17)
        view.textColor = .bdBlack
        view.textAlignment = .left
        return view
    }()
    
    let classNameLabel = {
       let view = UILabel()
        view.font = .customFont(sytle: .bold, ofSize: 15)
        view.textColor = .bdBlack
        view.textAlignment = .right
        return view
    }()
    
    let tutoringPlaceLabel = {
       let view = UILabel()
        view.font = .customFont(ofSize: 14)
        view.textColor = .darkGray
        view.textAlignment = .right
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear

        setConfigure()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConfigure() {
        contentView.addSubview(backView)
        backView.addSubview(timeLabel)
        backView.addSubview(classNameLabel)
        backView.addSubview(tutoringPlaceLabel)
    }
    
    func centerYClassNameLabel() {
        classNameLabel.snp.remakeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }

    func setConstraint() {
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.horizontalEdges.equalToSuperview().inset(4)
            make.bottom.equalToSuperview().inset(1)
            make.height.equalTo(62)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(120)
        }
        
        classNameLabel.snp.remakeConstraints { make in
            make.top.equalTo(timeLabel.snp.top)
            make.right.equalToSuperview().inset(16)
            make.left.equalTo(timeLabel.snp.right).offset(12)
        }
        
        tutoringPlaceLabel.snp.makeConstraints { make in
            make.top.equalTo(classNameLabel.snp.bottom).offset(4)
            make.trailing.equalTo(classNameLabel)
            make.bottom.equalToSuperview().inset(8)
            make.left.equalTo(timeLabel.snp.right).offset(16)
        }
    }
}
