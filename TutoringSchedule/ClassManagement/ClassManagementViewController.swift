////
////  ClassManagementViewController.swift
////  TutoringSchedule
////
////  Created by 김하은 on 2023/10/06.
////
//
import UIKit
import RealmSwift
//
 class ClassManagementViewController: UIViewController {
//
//    private let mainView = ClassManagementView()
//    private let realmRepository = RealmRepository()
//
//    override func loadView() {
//        self.view = mainView
//        mainView.delegate = self
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        navigationItem.title = "수업관리"
//
//        let addItem = UIBarButtonItem(image: UIImage(systemName: "text.badge.plus"), style: .plain, target: self, action: #selector(addButtonTapped))
//        addItem.width = 100
//        addItem.tintColor = .black
//
//        navigationItem.rightBarButtonItem = addItem
//
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
//        tapGestureRecognizer.cancelsTouchesInView = false
//        view.addGestureRecognizer(tapGestureRecognizer)
//
//        if let data = realmRepository.read(ClassTable.self) {
//
//            var tempData = data.where {
//                $0.ishidden == false
//            }.sorted(by: \.className)
//
//            mainView.data = tempData
//        }
//    }
//
//    @objc private func didTapView() {
//        view.endEditing(true)
//    }
//
//    @objc private func addButtonTapped() {
//        let vc = EditClassViewController(editType: .create, delegate: self)
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}
//
//extension ClassManagementViewController: saveSucsessDelegate {
//    func saveSucsess() {
//        mainView.tableView.reloadData()
//    }
//}
//
//extension ClassManagementViewController: sendSelectRowDelegate {
//    func selectRow<T>(data: T) {
//        guard let classData = data as? ClassTable else { return }
//
//        let vc = EditClassViewController(editType: .update( ), delegate: self)
//        vc.data = classData
//        navigationController?.pushViewController(vc, animated: true)
//    }
}
