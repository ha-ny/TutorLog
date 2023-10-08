//
//  ScheduleManagementViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/06.
//

import UIKit
import SnapKit
import RealmSwift

class ScheduleManagementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, SaveSucsessDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    

    let realmModel = RealmModel.shared
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "일정 관리"

        let addItem = UIBarButtonItem(image: UIImage(systemName: "text.badge.plus"), style: .plain, target: self, action: #selector(addButtonTapped))
        addItem.width = 100
        addItem.tintColor = .black
        
        navigationItem.rightBarButtonItem = addItem

        setConfigure()
        setConstraint()
        
        guard let realmData = realmModel.read(ScheduleTable.self) else { return }
        data = realmData
    }

    func saveSucsess() {
        tableView.reloadData()
    }
    
    @objc func addButtonTapped() {
        let vc = AddScheduleViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setConfigure() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    func setConstraint() {
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalTo(searchBar)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        data = realmFile.readData(filterName: searchBar.text!)
//        tableView.reloadData()
    }
}
