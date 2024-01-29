//
//  StudentListViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/13.
//

import UIKit
import RealmSwift

protocol studentArrayDelegate {
    func studentArray(data: [String])
}

class StudentListViewController: UIViewController {

    private let mainView = StudentManagementView()
    private let viewModel = StudentManagementViewModel()
    
    var data: [StudentTable]?
    var delegate: studentArrayDelegate?
    var studentData = [String]()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
        mainView.tableView.allowsMultipleSelection = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let addItem = UIBarButtonItem(title: "addButtonTapped".localized, style: .plain, target: self, action: #selector(addButtonTapped))
        addItem.tintColor = .darkGray
        navigationItem.rightBarButtonItem = addItem
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
        
        mainView.searchBar.delegate = self
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.addButton.isHidden = true
        
        bind()
        
        errorHandling {
            try viewModel.settingData()
        }
    }

    @objc private func addButtonTapped() {
        delegate?.studentArray(data: studentData)
        dismiss(animated: true)
    }
    
    private func bind() {
        viewModel.state.bind { [weak self] eventType in
            guard let self else { return }
            
            if case .settingData(let data) = eventType{
                self.data = data
                mainView.tableView.reloadData()
            } else if case .searchData(let data) = eventType {
                self.data = data
                mainView.tableView.reloadData()
            }
        }
    }

    @objc private func didTapView() {
        view.endEditing(true)
    }
}

extension StudentListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        errorHandling {
            try viewModel.searchData(keyWord: searchText)
        }
    }
}

extension StudentListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data else { return UITableViewCell() }
        
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        cell.textLabel?.text = data[indexPath.row].name
        
        if let _ = isStudentPK(data: data[indexPath.row]) {
            cell.tintColor = .darkGray
            cell.imageView?.image = UIImage(systemName: "checkmark")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath), let data else { return }

        guard let _ = isStudentPK(data: data[indexPath.row]) else {
            cell.tintColor = .darkGray
            cell.imageView?.image = UIImage(systemName: "checkmark")
            studentData.append(data[indexPath.row]._id.stringValue)
            return
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath), let data else { return }
        cell.imageView?.image = nil

        if let index = isStudentPK(data: data[indexPath.row]) {
            studentData.remove(at: index)
        }
    }
    
    func isStudentPK(data: StudentTable) -> IndexPath.Index? {
        guard let index = studentData.firstIndex(where: {$0 == data._id.stringValue}) else { return nil }
        return index
    }
}



