//
//  ClassManagementView.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/06.
//

import UIKit

//class ClassManagementView: BaseView {
//    
//    let searchBar = {
//        let view = UISearchBar()
//        view.placeholder = "placeOfClassName".localized
//        view.searchBarStyle = .minimal
//        return view
//    }()
//    
//    let lineView = {
//       let view = UILabel()
//        view.backgroundColor = .systemGray5
//        return view
//    }()
//    
//    let tableView = {
//        let view = UITableView()
//        view.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//        return view
//    }()
//
//    override func setConfigure() {
//        addSubview(searchBar)
//        addSubview(lineView)
//        addSubview(tableView)
//    }
//    
//    override func setConstraint() {
//        searchBar.snp.makeConstraints { make in
//            make.top.equalTo(self.safeAreaLayoutGuide)
//            make.horizontalEdges.equalToSuperview().inset(16)
//        }
//        
//        lineView.snp.makeConstraints { make in
//            make.top.equalTo(searchBar.snp.bottom)
//            make.horizontalEdges.equalToSuperview()
//            make.height.equalTo(0.7)
//        }
//        
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(lineView.snp.bottom).offset(8)
//            make.leading.trailing.equalTo(searchBar)
//            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(24)
//        }
//    }
//}
