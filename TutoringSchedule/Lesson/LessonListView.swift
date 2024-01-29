//
//  LessonListView.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/30.
//

import UIKit

class LessonListView: BaseView {

    let tableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.rowHeight = 80
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    let addButton = CustomImageButton(image: .addList)

    override func setConfigure() {
        addSubview(tableView)
        addSubview(addButton)
    }
    
    override func setConstraint() {
        tableView.snp.makeConstraints {
            $0.verticalEdges.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        addButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            $0.size.equalTo(56)
        }
    }
}
