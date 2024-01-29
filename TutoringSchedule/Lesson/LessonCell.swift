//
//  LessonCell.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/11/04.
//

import UIKit
import SnapKit

final class LessonCell: UITableViewCell {

    let backView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    var nameLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .bdBlack
        view.textAlignment = .left
        return view
    }()
    
    private let lineLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.backgroundColor = .gray
        view.textAlignment = .left
        return view
    }()
    
    var subjectLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .bdBlack
        view.textAlignment = .left
        return view
    }()
    
    var placeLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .bdBlack
        view.textAlignment = .left
        return view
    }()

    let detailButton = CustomImageButton(image: .right)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier) 
        backgroundColor = .clear
        selectionStyle = .none
        
        setConfigure()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setConfigure() {
        contentView.addSubview(backView)
        
        backView.addSubview(nameLabel)
        backView.addSubview(lineLabel)
        backView.addSubview(subjectLabel)
        backView.addSubview(placeLabel)
        backView.addSubview(detailButton)
    }
    
    func setConstraint() {
        backView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.height.equalTo(64)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(20)
        }

        lineLabel.snp.makeConstraints {
            $0.verticalEdges.equalTo(nameLabel).inset(3)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(4)
            $0.width.equalTo(1)
        }
        
        subjectLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.top)
            $0.leading.equalTo(lineLabel.snp.trailing).offset(4)
        }
        
        placeLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-10)
            $0.leading.equalTo(nameLabel.snp.leading)
        }

        detailButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
    }
}
