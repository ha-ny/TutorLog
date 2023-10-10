//
//  StudentManagementView.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/30.
//

import UIKit
import RealmSwift

protocol sendSelectRowDelegate {
    func selectRow(data: StudentTable)
}

class StudentManagementView: BaseView {

    private let realmRepository = RealmRepository()
    var data: Results<StudentTable>?
    var delegate: sendSelectRowDelegate?
    
    lazy var searchBar = {
        let view = UISearchBar()
        view.placeholder = "이름"
        view.searchBarStyle = .minimal
        view.delegate = self
        return view
    }()
    
    lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
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
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(24)
        }
    }
}

extension StudentManagementView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data else { return UITableViewCell() }
        
        let cell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.row].name
        cell.selectionStyle = .none
        
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let data else { return }
        realmRepository.delete(data: data[indexPath.row])
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data else { return }
        delegate?.selectRow(data: data[indexPath.row])
    }
}

extension StudentManagementView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let realmData = realmRepository.read(StudentTable.self) else { return }
        
        var tempData = realmData.sorted(by: \.name)
        
        if !searchText.isEmpty {
            tempData = tempData.where {
                $0.name.contains(searchText)
            }
        }
        
        data = tempData
        tableView.reloadData()
    }
}
