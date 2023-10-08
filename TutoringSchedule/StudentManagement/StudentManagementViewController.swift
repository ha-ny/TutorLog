//
//  StudentManagementViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/30.
//

import UIKit

class StudentManagementViewController: UIViewController, SaveSucsessDelegate {

    let mainView = StudentManagementView()
    private let realmModel = RealmModel.shared
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "학생 관리"

        let addItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.badge.plus"), style: .plain, target: self, action: #selector(addButtonTapped))
        addItem.width = 100
        addItem.tintColor = .black
        
        navigationItem.rightBarButtonItem = addItem
        
        mainView.data = realmModel.read(StudentTable.self)
    }
        
    @objc private func addButtonTapped() {
        let vc = AddStudentViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //SaveSucsessDelegate
    func saveSucsess() {
        mainView.tableView.reloadData()
    }
}
