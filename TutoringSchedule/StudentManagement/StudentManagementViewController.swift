//
//  StudentManagementViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/30.
//

import UIKit

class StudentManagementViewController: UIViewController {

    let mainView = StudentManagementView()
    private let realmRepository = RealmRepository()
    
    override func loadView() {
        self.view = mainView
        mainView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "학생 관리"

        let addItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.badge.plus"), style: .plain, target: self, action: #selector(addButtonTapped))
        addItem.width = 100
        addItem.tintColor = .black
        
        navigationItem.rightBarButtonItem = addItem
        
        mainView.data = realmRepository.read(StudentTable.self)?.sorted(by: \.name)
    }
        
    @objc private func addButtonTapped() {
        let vc = AddStudentViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension StudentManagementViewController: saveSucsessDelegate {
    func saveSucsess() {
        mainView.tableView.reloadData()
    }
}

extension StudentManagementViewController: sendSelectRowDelegate {
    func selectRow(data: StudentTable) {
        let vc = UpdateStudentViewController()
        vc.delegate = self
        vc.data = data
        navigationController?.pushViewController(vc, animated: true)
    }
}
