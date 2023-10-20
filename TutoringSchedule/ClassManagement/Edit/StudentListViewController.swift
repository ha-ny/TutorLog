//
//  StudentListViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/13.
//

import UIKit
import RealmSwift

protocol studentArrayDelegate {
    func studentArray(data: List<ObjectId>)
}

class StudentListViewController: UIViewController {

    private let mainView = StudentListView()
    private let realmRepository = RealmRepository()
    
    var studentData: List<ObjectId>?
    var delegate: studentArrayDelegate?
    
    override func loadView() {
        self.view = mainView
        mainView.tableView.allowsMultipleSelection = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
        
        mainView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        if let studentData {
            mainView.selectArray.append(objectsIn: studentData)
        }

        if let data = realmRepository.read(StudentTable.self) {
            var tempData = data.where {
                $0.ishidden == false
            }.sorted(by: \.name)
            
            mainView.data = tempData
        }
    }

    @objc private func nextButtonTapped() {
        delegate?.studentArray(data: mainView.selectArray)
        dismiss(animated: true)
    }
    
    @objc private func didTapView() {
        view.endEditing(true)
    }
}
 

