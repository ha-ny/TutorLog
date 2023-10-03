//
//  StudentManagementViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/30.
//

import UIKit
import SnapKit
import RealmSwift

class StudentManagementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let realmFile = RealmFile()
    var data: Results<StudentTable>?
    
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
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "학생 관리"
        //text.badge.plus
        let addItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.badge.plus"), style: .plain, target: self, action: #selector(addButtonTapped))
        addItem.width = 100
        addItem.tintColor = .black
        
        navigationItem.rightBarButtonItem = addItem

        setConfigure()
        setConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        data = realmFile.readData()
        tableView.reloadData()
    }
    
    
    @objc func addButtonTapped() {
        let vc = AddStudentViewController()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if let data {
            cell.textLabel?.text = data[indexPath.row].name
        }

        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        data = realmFile.readData(filterName: searchBar.text!)
        tableView.reloadData()
    }
}
