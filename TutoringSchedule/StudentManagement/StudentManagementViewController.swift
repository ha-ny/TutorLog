//
//  StudentManagementViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/30.
//

import UIKit

class StudentManagementViewController: UIViewController {
    
    private let mainView = StudentManagementView()
    private let viewModel = StudentManagementViewModel()
    
    var data: [StudentTable]?
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "studentTabTitle".localized
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "addButton")
        imageView.contentMode = .scaleAspectFit
        
        let backButtonImage = UIImage.left.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = backButtonImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        mainView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
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
    
    @objc private func addButtonTapped() {
        let vc = EditStudentViewController(editType: .create, delegate: self)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension StudentManagementViewController: saveSucsessDelegate {
    func saveSucsess() {
        errorHandling {
            try viewModel.settingData()
        }
    }
}

extension StudentManagementViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        errorHandling {
            try viewModel.searchData(keyWord: searchText)
        }
    }
}

extension StudentManagementViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data else { return UITableViewCell() }
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        cell.textLabel?.text = data[indexPath.row].name
        cell.textLabel?.font = .systemFont(ofSize: 16)
        cell.textLabel?.textColor = .bdBlack
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let data else { return }
        let indexData = data[indexPath.row]
        
        let newData = StudentTable(name: indexData.name, studentPhoneNum: indexData.studentPhoneNum, parentPhoneNum: indexData.parentPhoneNum, address: indexData.address)
        newData._id = indexData._id
        newData.ishidden = true
        
        errorHandling {
            try viewModel.rowDelete(data: newData)
            try viewModel.settingData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data else { return }
        
        let vc = EditStudentViewController(editType: .update(data[indexPath.row]), delegate: self)
        navigationController?.pushViewController(vc, animated: true)
    }
}

