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
    
    override func loadView() {
        self.view = mainView
        mainView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "학생관리"
        
        let addItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.badge.plus"), style: .plain, target: self, action: #selector(addButtonTapped))
        addItem.width = 100
        addItem.tintColor = .black
        
        navigationItem.rightBarButtonItem = addItem
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
        
        mainView.searchBar.delegate = self
        
        bind()
        viewModel.settingData()
    }
    
    private func bind() {
        viewModel.state.bind { [weak self] eventType in
            guard let self = self else { return }
            
            if case .settingData(let data) = eventType {
                self.mainView.data = data
            } else if case .searchData(let data) = eventType {
                self.mainView.data = data
                self.mainView.tableView.reloadData()
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
        mainView.tableView.reloadData()
    }
}

extension StudentManagementViewController: sendSelectRowDelegate {
    func selectRow<T>(data: T) {
        guard let studentData = data as? StudentTable else { return }
        
        let vc = EditStudentViewController(editType: .update(studentData), delegate: self)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension StudentManagementViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchData(keyWord: searchText)
    }
}

