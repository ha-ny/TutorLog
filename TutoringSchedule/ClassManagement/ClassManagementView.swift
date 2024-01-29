//
//  ClassManagementView.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/06.
//

import UIKit

class ClassManagementView: BaseView {
    
    let searchBar = {
        let view = UISearchBar()
        view.placeholder = "placeOfClassName".localized
        view.searchBarStyle = .minimal
        return view
    }()
    
    let lineView = {
       let view = UILabel()
        view.backgroundColor = .bdLine
        return view
    }()
    
    let tableView = {
        let view = UITableView()
        view.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    let addButton = {
        let view = UIButton()
        view.setImage(.addList, for: .normal)
        view.setImage(.addList, for: .highlighted)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let lineView2 = {
       let view = UILabel()
        view.backgroundColor = .bdLine
        return view
    }()

    override func setConfigure() {
        addSubview(searchBar)
        addSubview(lineView)
        addSubview(tableView)
        addSubview(addButton)
        addSubview(lineView2)
    }
    
    override func setConstraint() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(0.7)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(8)
            make.leading.trailing.equalTo(searchBar)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        addButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(56)
        }
        
        lineView2.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(0.7)
        }
    }
}
