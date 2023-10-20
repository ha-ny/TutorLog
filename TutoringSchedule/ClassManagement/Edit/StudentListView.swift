//
//  StudentListView.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/13.
//

import UIKit
import RealmSwift

class StudentListView: BaseView {
    
    private let realmRepository = RealmRepository()
    var data: Results<StudentTable>?
    var delegate: sendSelectRowDelegate?
    
    var selectArray = List<ObjectId>()
    
    lazy var searchBar = {
        let view = UISearchBar()
        view.placeholder = "이름"
        view.searchBarStyle = .minimal
        view.delegate = self
        return view
    }()
    
    let lineView = {
        let view = UILabel()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        view.tintColor = .darkGray
        return view
    }()
    
    let nextButton = {
        let view = UIButton()
        view.layer.cornerRadius = 16
        view.tintColor = .black
        let configuration = UIImage.SymbolConfiguration(pointSize: 40)
        let image = UIImage(systemName: "arrow.right.circle", withConfiguration: configuration)
        view.setImage(image, for: .normal)
        return view
    }()
    
    override func setConfigure() {
        addSubview(searchBar)
        addSubview(lineView)
        addSubview(tableView)
        addSubview(nextButton)
    }
    
    override func setConstraint() {
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(0.7)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(8)
            make.leading.trailing.equalTo(searchBar)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(24)
        }
        
        nextButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(32)
            make.size.equalTo(45)
        }
    }
}

extension StudentListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data else { return UITableViewCell() }
        
        let cell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.row].name
        
        if let _ = selectArray.firstIndex(where: { $0 == data[indexPath.row]._id}) {
            cell.imageView?.image = UIImage(systemName: "checkmark")
            cell.isSelected = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath), let data else { return }

        guard let index = selectArray.firstIndex(where: {$0 == data[indexPath.row]._id}) else {
            cell.imageView?.image = UIImage(systemName: "checkmark")
            selectArray.append(data[indexPath.row]._id)
            return
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath), let data else { return }
        cell.imageView?.image = nil
        
        if let index = selectArray.firstIndex(where: {$0 == data[indexPath.row]._id}) {
            selectArray.remove(at: index)
        }
    }
}

extension StudentListView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let realmData = realmRepository.read(StudentTable.self) else { return }
        
        var tempData = realmData.where {
            $0.ishidden == false
        }.sorted(by: \.name)
        
        if !searchText.isEmpty {
            tempData = tempData.where {
                $0.name.contains(searchText)
            }
        }
        
        data = tempData
        tableView.reloadData()
    }
}

