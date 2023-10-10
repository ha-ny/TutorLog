//
//  ScheduleManagementView.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/06.
//

import UIKit
import RealmSwift

class ScheduleManagementView: BaseView {

    var data: Results<ScheduleTable>?
    
    lazy var searchBar = {
        let view = UISearchBar()
        view.placeholder = "과외명"
        view.searchBarStyle = .minimal
        view.delegate = self
        return view
    }()
    
    lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        return view
    }()

    override func setConfigure() {
        addSubview(searchBar)
        addSubview(tableView)
    }
    
    override func setConstraint() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalTo(searchBar)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}

extension ScheduleManagementView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data else { return UITableViewCell() }
        
        let cell = UITableViewCell()
        cell.textLabel?.text = "데이터"
        cell.selectionStyle = .none
        return cell
    }
}

extension ScheduleManagementView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        data = realmFile.readData(filterName: searchBar.text!)
//        tableView.reloadData()
    }
}
