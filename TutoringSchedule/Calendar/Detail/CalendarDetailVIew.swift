//
//  CalendarDetailVIew.swift
//  TutoringSchedule
//
//  Created by 김하은 on 1/25/24.
//

import UIKit

class CalendarDetailView: BaseView {

    let dateLabel = {
        let view = UILabel()
        view.text = ""
        view.textColor = .bdBlack
        view.font = .customFont(sytle: .bold, ofSize: 16)
        return view
    }()
    
    private let line = {
        let view = UILabel()
        view.backgroundColor = .bdLine
        return view
    }()

    let tableView = {
       let view = UITableView()
        view.rowHeight = 78
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = .none
        return view
    }()
    
    override func setConfigure() {
        addSubview(dateLabel)
        addSubview(line)
        addSubview(tableView)
    }

    override func setConstraint() {
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(37)
            $0.leading.equalToSuperview().inset(26)
        }
        
        line.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(line.snp.bottom).offset(10)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-5)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
}
