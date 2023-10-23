//
//  ClassManagementViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/06.
//

import UIKit

class ClassManagementViewController: UIViewController {
    
    private let mainView = ClassManagementView()
    private let viewModel = ClassManagementViewModel()
    
    var data: [ClassTable]?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "scheduleTabTitle".localized
        
        let addItem = UIBarButtonItem(image: UIImage(systemName: "text.badge.plus"), style: .plain, target: self, action: #selector(addButtonTapped))
        addItem.width = 100
        addItem.tintColor = .black
        
        navigationItem.rightBarButtonItem = addItem
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
        
        mainView.searchBar.delegate = self
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        bind()
        
        errorHandling {
            try viewModel.settingData()
        }
    }
    
    private func bind() {
        viewModel.state.bind { [weak self] eventType in
            guard let self else { return }
            
            if case .settingData(let data) = eventType {
                self.data = data
            } else if case .searchData(let data) = eventType {
                self.data = data
                self.mainView.tableView.reloadData()
            } else if case .rowDelete = eventType {
                self.mainView.tableView.reloadData()
            }
        }
    }
    
    @objc private func didTapView() {
        view.endEditing(true)
    }
    
    @objc private func addButtonTapped() {
        let vc = EditClassViewController(editType: .create, delegate: self)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ClassManagementViewController: saveSucsessDelegate {
    func saveSucsess() {
        mainView.tableView.reloadData()
    }
}

extension ClassManagementViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        errorHandling {
            try viewModel.searchData(keyWord: searchText)
        }
    }
}

extension ClassManagementViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data else { return UITableViewCell() }
        
        let cell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.row].className
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let data else { return }
        let classData = data[indexPath.row]


        var studentPK = [String]()
        studentPK.append(contentsOf: classData.studentPK)

        let newData = ClassTable(className: classData.className, tutoringPlace: classData.tutoringPlace, startDate: classData.startDate, endDate: classData.endDate, studentPK: studentPK)
        newData._id = classData._id
        newData.ishidden = true
        
        errorHandling {
            try viewModel.rowDelete(data: newData)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data else { return }
        
        let vc = EditClassViewController(editType: .update(data[indexPath.row]), delegate: self)
        navigationController?.pushViewController(vc, animated: true)
    }
}
